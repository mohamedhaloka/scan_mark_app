import 'package:path/path.dart';
import 'package:scan_mark_app/models/cart.dart';
import 'package:sqflite/sqflite.dart';

// THIS IS SQLITE FILE
class DbHelper {
  static final DbHelper _instance = DbHelper.internal();
  factory DbHelper() => _instance;
  DbHelper.internal();
  static Database _db;
  Future<Database> createDatabase() async {
    if (_db != null) {
      return _db;
    }
    //define the path to the database
    String path = join(await getDatabasesPath(), 'cache.db');
    _db = await openDatabase(path, version: 1, onCreate: (Database db, int v) {
      //create all tables
      // db.execute(
      //     "create table quotes(id integer primary key autoincrement, quot text not null, )");
      db
          .execute(
              "CREATE TABLE cart(id INTEGER PRIMARY KEY AUTOINCREMENT,productName TEXT,photo TEXT,priceDetails TEXT,averagePriceDetails TEXT);")
          .catchError((val) {
        print(val);
      });
    });
    return _db;
  }

  Future createCart(Cart cart) async {
    Database db = await createDatabase();
    //db.rawInsert('insert into courses')
    return db.insert('cart', cart.toMap());
  }

  allCarts() async {
    Database db = await createDatabase();
    //db.rawQuery("select * from courses")
    return db.query('cart', orderBy: 'id DESC');
  }

  Future<int> deleteCart(int id) async {
    Database db = await createDatabase();
    return db.delete('cart', where: 'id = ?', whereArgs: [id]);
  }
}
