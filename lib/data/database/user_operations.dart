import 'package:budget_binder/data/database/database_helper.dart';
import 'package:budget_binder/data/models/user_model.dart';

import '../../core/constants.dart';

class UserDBOperations {
  final dbHelper = DatabaseHelper();

  Future<int> createUser(String username) async {
    final database = await dbHelper.database;
    final data = {'username': username};
    final id = await database.insert(kUserTable, data);
    return id;
  }

  Future<List<UserModel>> getUsers() async {
    final database = await dbHelper.database;
    final result = await database.query(kUserTable, orderBy: 'id');
    print(result);
    final users = result.map((e) => UserModel.fromMap(e)).toList();
    print(users);
    return users;
  }

  Future<int> delete(int id) async {
    final database = await dbHelper.database;
    return await database.delete(kUserTable, where: 'id = ?', whereArgs: [id]);
  }

  Future<int> update(int id, String username) async {
    final database = await dbHelper.database;
    final data = {'username': username};
    return await database
        .update(kUserTable, data, where: 'id = ?', whereArgs: [id]);
  }
}
