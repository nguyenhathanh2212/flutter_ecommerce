import 'dart:async';
import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBProvider {
  DBProvider._();
  static final DBProvider db = DBProvider._();
  Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    // if _database is null we instantiate it
    _database = await initDB();
    return _database;
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "dbapp2.db");
    return await openDatabase(path, version: 1,
      onOpen: (db) {},
      onCreate: (Database db, int version) async {
        await db.execute("CREATE TABLE users ("
            "id INTEGER PRIMARY KEY AUTOINCREMENT,"
            "uid TEXT,"
            "username TEXT,"
            "email TEXT,"
            "created_at DATETIME DEFAULT CURRENT_TIMESTAMP)"
        );

        await db.execute("CREATE TABLE items ("
            "id INTEGER PRIMARY KEY AUTOINCREMENT,"
            "name TEXT,"
            "created_at DATETIME DEFAULT CURRENT_TIMESTAMP)"
        );

        await db.execute("CREATE TABLE shops ("
            "id INTEGER PRIMARY KEY AUTOINCREMENT,"
            "name TEXT,"
            "address TEXT,"
            "created_at DATETIME DEFAULT CURRENT_TIMESTAMP,"
            "FOREIGN KEY(id) REFERENCES service_shop(shop_id))"
        );

        await db.execute("CREATE TABLE services ("
            "id INTEGER PRIMARY KEY AUTOINCREMENT,"
            "name TEXT,"
            "icon_url TEXT,"
            "created_at DATETIME DEFAULT CURRENT_TIMESTAMP,"
            "FOREIGN KEY(id) REFERENCES service_shop(service_id))"
        );

        await db.execute("CREATE TABLE service_shop ("
            "id INTEGER PRIMARY KEY AUTOINCREMENT,"
            "shop_id INTEGER,"
            "service_id INTEGER,"
            "item_shop_id INTEGER,"
            "created_at DATETIME DEFAULT CURRENT_TIMESTAMP)"
        );

        await db.execute("CREATE TABLE item_shop ("
            "id INTEGER PRIMARY KEY AUTOINCREMENT,"
            "shop_id INTEGER,"
            "item_id INTEGER,"
            "quantity INTEGER,"
            "price REAL,"
            "created_at DATETIME DEFAULT CURRENT_TIMESTAMP,"
            "FOREIGN KEY(id) REFERENCES service_shop(item_shop_id))"
        );
      }
    );
  }
}