import 'package:budget_binder/data/database/database_helper.dart';
import 'package:budget_binder/data/models/user_model.dart';

import '../../core/constants.dart';

class BudgetDBOperations {
  final dbHelper = DatabaseHelper();

  Future<int> createBudget(String username) async {
    final database = await dbHelper.database;
    final data = {'username': username};
    final id = await database.insert(kBudgetTable, data);
    return id;
  }

  Future<List<BudgetModel>> getBudgets() async {
    final database = await dbHelper.database;
    final result = await database.query(kBudgetTable, orderBy: 'id');
    print(result);
    final budgets = result.map((e) => BudgetModel.fromMap(e)).toList();
    print(budgets);
    return budgets;
  }

  Future<BudgetModel?> getBudgetByID(int id) async {
    final database = await dbHelper.database;
    final result =
        await database.query(kBudgetTable, where: 'id = ?', whereArgs: [id]);
    print(result);
    final budget = result.map((e) => BudgetModel.fromMap(e)).toList();
    print(budget);
    if (result.isNotEmpty) {
      return BudgetModel.fromMap(result.first);
    } else {
      return null;
    }
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
