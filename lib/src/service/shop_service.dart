import 'package:simple_app_ecommerce/src/models/shop.dart';
import 'package:simple_app_ecommerce/database.dart';

class ShopService {
  String _tableName = 'items';

  dynamic newShop(Shop newShop) async {
    final db = await DBProvider.db.database;
    var res = await db.insert(_tableName, newShop.toMap());

    return res;
  }

  Future<Shop> getShop(int id) async {
    final db = await DBProvider.db.database;
    var res = await db.query(_tableName, where: "id = ?", whereArgs: [id]);

    return res.isNotEmpty ? Shop.fromMap(res.first) : null;
  }

  Future<List<Shop>> getAllShops() async {
    final db = await DBProvider.db.database;
    var res = await db.query(_tableName);
    List<Shop> list = res.isNotEmpty ? res.map((data) => Shop.fromMap(data)).toList() : [];

    return list;
  }
}
