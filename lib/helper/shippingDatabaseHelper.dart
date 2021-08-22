import '../model/shippingAddressModel.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class ShippingDatabaseHelper {
  ShippingDatabaseHelper._();
  static final ShippingDatabaseHelper db = ShippingDatabaseHelper._();
  Database _database;
  Future<Database> get database async {
    if (_database != null) {
      return _database;
    }
    _database = await initDb();
    return _database;
  }

  initDb() async {
    var path = join(await getDatabasesPath(), 'Shipping.db');
    return await openDatabase(path,
        version: 1,
        onCreate: (Database db, int version) async => await db.execute('''
            CREATE TABLE shippingAddress(
              id INTEGER PRIMARY KEY,
              fullName TEXT NOT NULL,
              mobileNumber TEXT NOT NULL,
              state TEXT NOT NULL,
              city TEXT NOT NULL,
              street TEXT NOT NULL,
              isSelected INTEGER NOT NULL)
            '''));
  }

  Future<void> insert(ShippingAddressModel shipping) async {
    var dbClient = await database;
    await dbClient.update('shippingAddress', {'isSelected': 0}).then(
        (_) async => await dbClient.insert(
              'shippingAddress',
              shipping.toJson(),
              conflictAlgorithm: ConflictAlgorithm.replace,
            ));
  }

  Future<List<ShippingAddressModel>> getAllShipping() async {
    var dbClient = await database;
    List<Map> queryList = await dbClient.query('shippingAddress');
    return queryList == null
        ? []
        : queryList.map((e) => ShippingAddressModel.fromJson(e)).toList();
  }

  Future<void> deleteOneShipping(id) async {
    var dbClient = await database;
    await dbClient.delete('shippingAddress', where: 'id=?', whereArgs: [id]);
  }

  Future<void> updateSelected(id) async {
    var dbClient = await database;
    await dbClient.update('shippingAddress', {'isSelected': 0}).then(
        (_) async => await dbClient.update('shippingAddress', {'isSelected': 1},
            where: 'id=?', whereArgs: [id]));
  }
}
