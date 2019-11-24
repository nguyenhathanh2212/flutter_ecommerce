import 'package:simple_app_ecommerce/src/models/user.dart';
import 'package:simple_app_ecommerce/database.dart';

class UserService {
  String _tableName = 'users';

  dynamic newUser(User newUser) async {
    final db = await DBProvider.db.database;
    var res = await db.insert(_tableName, newUser.toMap());

    return res;
  }

//  updateClient(Client newClient) async {
//    final db = await database;
//    var res = await db.update("Client", newClient.toMap(),
//        where: "id = ?", whereArgs: [newClient.id]);
//    return res;
//  }

  Future<User> getUser(int id) async {
    final db = await DBProvider.db.database;
    var res = await db.query(_tableName, where: "id = ?", whereArgs: [id]);

    return res.isNotEmpty ? User.fromMap(res.first) : null;
  }

  Future<List<User>> getAllUsers() async {
    final db = await DBProvider.db.database;
    var res = await db.query(_tableName);
    List<User> list = res.isNotEmpty ? res.map((data) => User.fromMap(data)).toList() : [];

    return list;
  }

//  deleteClient(int id) async {
//    final db = await database;
//    return db.delete("Client", where: "id = ?", whereArgs: [id]);
//  }
//
//  deleteAll() async {
//    final db = await database;
//    db.rawDelete("Delete * from Client");
//  }
}
