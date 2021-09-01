import '../model/cartProductModel.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class CartDataBaseHelper {
  CartDataBaseHelper._();
  static final CartDataBaseHelper db = CartDataBaseHelper._();
  Database _database;
  Future<Database> get database async {
    if (_database != null) {
      return _database;
    }
    _database = await initDb();
    return _database;
  }

  initDb() async {
    String path = join(await getDatabasesPath(), 'CartProduct.db');
    return await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute('''
            CREATE TABLE cartProduct(
              id TEXT NOT NULL,
              sellerId TEXT NOT NULL,
              name TEXT NOT NULL,
              imgUrl TEXT NOT NULL,
              size TEXT NOT NULL,
              color TEXT NOT NULL,
              price TEXT NOT NULL,
              quantity INTEGER NOT NULL)
            ''');
    });
  }

  insert(CartProductModel cartProd) async {
    var dbClient = await database;
    await dbClient.insert(
      'cartProduct',
      cartProd.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<CartProductModel>> getAllProducts() async {
    var dbClient = await database;
    List<Map<String, Object>> maps = await dbClient.query('cartProduct');
    return maps != null
        ? maps.map((e) => CartProductModel.fromJson(e)).toList()
        : [];
  }

  updateProduct(CartProductModel cartProduct) async {
    var dbClient = await database;
    await dbClient.update(
      'cartProduct',
      cartProduct.toJson(),
      where: 'id=?',
      whereArgs: [cartProduct.id],
    );
  }

  deleteProduct(CartProductModel cartProduct) async {
    var dbClient = await database;
    await dbClient.delete(
      'cartProduct',
      where: 'id=?',
      whereArgs: [cartProduct.id],
    );
  }

  deleteAll() async {
    var dbClient = await database;
    await dbClient.delete('cartProduct');
  }
}
