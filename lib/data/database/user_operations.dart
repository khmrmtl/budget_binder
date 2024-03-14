import 'package:budget_binder/data/database/database_helper.dart';
import 'package:budget_binder/data/models/user_model.dart';

import '../../core/constants.dart';

class BudgetDBOperations {
  final dbHelper = DatabaseHelper();

  Future<int> createUser(String username) async {
    final database = await dbHelper.database;
    final data = {'username': username};
    final id = await database.insert(kBudgetTable, data);
    return id;
  }

  Future<List<BudgetModel>> getUsers() async {
    final database = await dbHelper.database;
    final result = await database.query(kBudgetTable, orderBy: 'id');
    print(result);
    final users = result.map((e) => BudgetModel.fromMap(e)).toList();
    print(users);
    return users;
  }

  Future<int> delete(int id) async {
    final database = await dbHelper.database;
    return await database
        .delete(kBudgetTable, where: 'id = ?', whereArgs: [id]);
  }

  Future<int> update(int id, String username) async {
    final database = await dbHelper.database;
    final data = {'username': username};
    return await database
        .update(kBudgetTable, data, where: 'id = ?', whereArgs: [id]);
  }
}
