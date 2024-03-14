import 'package:budget_binder/data/models/expense_model.dart';
import 'package:budget_binder/data/models/income_model.dart';

class TransactionModel {
  final bool isIncome; // transaction is expense if !income
  final ExpenseModel? expense;
  final IncomeModel? income;

  TransactionModel({required this.isIncome, this.expense, this.income});
}
