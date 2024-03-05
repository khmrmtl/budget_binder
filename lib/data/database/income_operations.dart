import 'package:budget_binder/data/database/database_helper.dart';

import '../../core/constants.dart';

class IncomeDBOperations {
  final dbHelper = DatabaseHelper();

  Future<int> addIncome({
    required int userId,
    required double amount,
    required String source,
    required String date,
  }) async {
    final database = await dbHelper.database;
    final data = {
      'user_id': userId,
      'amount': amount,
      'source': source,
      'date': date,
    };
    final id = await database.insert(kIncomeTable, data);
    return id;
  }

  Future<List<Map<String, dynamic>>> getUserIncome(int userId) async {
    final database = await dbHelper.database;
    final result = await database
        .query(kIncomeTable, where: 'user_id = ?', whereArgs: [userId]);
    print(result);
    return result;
  }

  Future<int> delete(int id) async {
    final database = await dbHelper.database;
    return await database
        .delete(kIncomeTable, where: 'id = ?', whereArgs: [id]);
  }

  Future<int> update(
      {required int id, required double amount, required String source}) async {
    final database = await dbHelper.database;
    final data = {
      'amount': amount,
      'source': source,
    };
    return await database
        .update(kIncomeTable, data, where: 'id = ?', whereArgs: [id]);
  }

  Future<double> getTotalIncomeForUser(int userId) async {
    final database = await dbHelper.database;
    final result = await database.rawQuery('''
      SELECT COALESCE(SUM(amount), 0.0) AS totalIncome
      FROM $kIncomeTable
      WHERE user_id = ?
    ''', [userId]);
    print(result);

    return result.isNotEmpty ? result.first['totalIncome'] as double : 0.0;
  }
}
