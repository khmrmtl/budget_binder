import 'package:budget_binder/data/database/expense_operations.dart';
import 'package:budget_binder/data/database/income_operations.dart';

import '../../data/models/user_model.dart';
import 'app_usecase.dart';

class AppUsecaseImpl implements AppUsecase {
  // Private constructor
  AppUsecaseImpl._privateConstructor();

  // Singleton instance
  static final AppUsecaseImpl _instance = AppUsecaseImpl._privateConstructor();

  // Factory constructor to provide the singleton instance
  factory AppUsecaseImpl() {
    return _instance;
  }

  final IncomeDBOperations _incomeTable = IncomeDBOperations();
  final ExpenseDBOperations _expenseTable = ExpenseDBOperations();

  late BudgetModel activeBudget;
  bool _hasAnActiveBudget = false;

  @override
  bool get hasAnActiveBudget => _hasAnActiveBudget;

  @override
  BudgetModel getCurrentBudget() {
    return activeBudget;
  }

  @override
  void setCurrentBudget(BudgetModel currentUser) {
    if (!_hasAnActiveBudget) _hasAnActiveBudget = true;
    activeBudget = currentUser;
  }

  @override
  Future<double> getBudgetBalance(int id) async {
    double income = await _incomeTable.getTotalIncomeForUser(id);
    double expense = await _expenseTable.getTotalExpenseForUser(id);
    double balance = income - expense;
    return balance;
  }
}
