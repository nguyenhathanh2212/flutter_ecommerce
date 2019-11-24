import 'package:simple_app_ecommerce/src/models/service.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ServiceService {
//  Future<Service> getService(int id) async {
//    final db = await DBProvider.db.database;
//    var res = await db.query(_tableName, where: "id = ?", whereArgs: [id]);
//
//    return res.isNotEmpty ? Service.fromMap(res.first) : null;
//  }

  Future<Service> getAll() async {
    var response = await http.get('http://192.168.1.42:3000/services');

    if (response.statusCode == 200) {
      return Service.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load service');
    }
  }
}
