import 'package:budget_binder/data/database/database_helper.dart';

import '../../core/constants.dart';

class ExpenseDBOperations {
  final dbHelper = DatabaseHelper();

  Future<int> addExpense({
    required int userId,
    required double amount,
    required String description,
    required String category,
    required String date,
  }) async {
    final database = await dbHelper.database;
    final data = {
      'user_id': userId,
      'amount': amount,
      'description': description,
      'category': category,
      'date': date,
    };
    final id = await database.insert(kExpensesTable, data);
    return id;
  }

  Future<List<Map<String, dynamic>>> getUserExpenses(int userId) async {
    final database = await dbHelper.database;
    final result = await database
        .query(kExpensesTable, where: 'user_id = ?', whereArgs: [userId]);
    print(result);
    return result;
  }

  Future<int> delete(int id) async {
    final database = await dbHelper.database;
    return await database
        .delete(kExpensesTable, where: 'id = ?', whereArgs: [id]);
  }

  Future<int> update(
      {required int id, required double amount, required String source}) async {
    final database = await dbHelper.database;
    final data = {
      'amount': amount,
      'source': source,
    };
    return await database
        .update(kExpensesTable, data, where: 'id = ?', whereArgs: [id]);
  }

  Future<double> getTotalExpenseForUser(int userId) async {
    final database = await dbHelper.database;
    final result = await database.rawQuery('''
      SELECT COALESCE(SUM(amount), 0.0) AS totalExpense
      FROM $kExpensesTable
      WHERE user_id = ?
    ''', [userId]);
    print(result);

    return result.isNotEmpty ? result.first['totalExpense'] as double : 0.0;
  }
}
