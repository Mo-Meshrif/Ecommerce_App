import '../model/paymentMethodModel.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class PaymentDatabaseHelper {
  PaymentDatabaseHelper._();
  static final PaymentDatabaseHelper db = PaymentDatabaseHelper._();
  Database? _database;
  Future<Database?> get database async {
    if (_database != null) {
      return _database;
    }
    _database = await initDb();
    return _database;
  }

  initDb() async {
    var path = join(await getDatabasesPath(), 'Payment.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async => await db.execute('''
    CREATE TABLE paymentMethod(
              id INTEGER PRIMARY KEY,
              cardImage TEXT NOT NULL,
              cardNumber TEXT NOT NULL,
              expireDate TEXT NOT NULL,
              cvv TEXT NOT NULL,
              cardHolderName TEXT NOT NULL,
              isSelected INTEGER NOT NULL)
    '''),
    );
  }

  Future<void> insert(PaymentMehodModel payment) async {
    var dbClient = await database;
    await dbClient!.update('paymentMethod', {'isSelected': 0}).then(
      (_) async => await dbClient.insert(
        'paymentMethod',
        payment.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      ),
    );
  }

  Future<List<PaymentMehodModel>> getAllPayments() async {
    var dbClient = await database;
    List<Map> queryList = await dbClient!.query('paymentMethod');
    return queryList.isEmpty
        ? []
        : queryList
            .map((e) => PaymentMehodModel.fromJson(e as Map<String, dynamic>))
            .toList();
  }

  Future<void> deleteOnePayment(id) async {
    var dbClient = await database;
    await dbClient!.delete('paymentMethod', where: 'id=?', whereArgs: [id]);
  }

  Future<void> updateSelected(id) async {
    var dbClient = await database;
    await dbClient!.update('paymentMethod', {'isSelected': 0}).then((_) async =>
        await dbClient.update('paymentMethod', {'isSelected': 1},
            where: 'id=?', whereArgs: [id]));
  }
}
