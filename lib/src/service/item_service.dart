import 'package:simple_app_ecommerce/src/models/item.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ItemService {
//  String _tableName = 'items';
//
//  dynamic newItem(Item newItem) async {
//    final db = await DBProvider.db.database;
//    var res = await db.insert(_tableName, newItem.toMap());
//
//    return res;
//  }
//
//  Future<Item> getItem(int id) async {
//    final db = await DBProvider.db.database;
//    var res = await db.query(_tableName, where: "id = ?", whereArgs: [id]);
//
//    return res.isNotEmpty ? Item.fromMap(res.first) : null;
//  }

  Future<Item> getAll() async {
    var response = await http.get('http://192.168.1.42:3000/items');

    if (response.statusCode == 200) {
      return Item.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load items');
    }
  }
  Future<Item> getByServiceId(int serviceId) async {
    var response = await http.get('http://192.168.1.42:3000/items?service_id=${serviceId}');

    if (response.statusCode == 200) {
      return Item.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load items');
    }
  }

}
