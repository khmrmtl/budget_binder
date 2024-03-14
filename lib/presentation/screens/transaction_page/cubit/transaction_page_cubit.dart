import 'package:budget_binder/data/database/expense_operations.dart';
import 'package:budget_binder/data/database/income_operations.dart';
import 'package:budget_binder/data/models/expense_model.dart';
import 'package:budget_binder/data/models/income_model.dart';
import 'package:budget_binder/data/models/transaction_model.dart';
import 'package:budget_binder/usecase/app_usecase/app_usecase.dart';
import 'package:budget_binder/usecase/app_usecase/app_usecase_impl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../data/models/user_model.dart';

part 'transaction_page_state.dart';

class TransactionPageCubit extends Cubit<TransactionPageState> {
  TransactionPageCubit() : super(TransactionPageInitial());

  final _incomeTable = IncomeDBOperations();
  final _expenseTable = ExpenseDBOperations();
  final AppUsecase _appUsecase = AppUsecaseImpl();
  late final UserModel currentUser;

  void init() async {
    currentUser = _appUsecase.getCurrentUser();
    showTransactions();
  }

  Future<void> showTransactions() async {
    List<IncomeModel> income = await _incomeTable.getUserIncome(currentUser.id);
    List<ExpenseModel> expenses =
        await _expenseTable.getUserExpenses(currentUser.id);
    List<dynamic> transactions = [...income, ...expenses];
    //sort by time
    transactions.sort((a, b) => a.date.compareTo(b.date));

    List<TransactionModel> transactionsObject = transactions.map((e) {
      bool isIncome = (e is IncomeModel);
      if (isIncome) {
        return TransactionModel(isIncome: true, income: e);
      } else {
        return TransactionModel(isIncome: false, expense: e as ExpenseModel);
      }
    }).toList();

    emit(TransactionPageLoaded(transactions: transactionsObject));
  }

  Future<void> updateExpense(
      int id, String amount, String description, String category) async {
    await _expenseTable.update(
      id: id,
      amount: double.parse(amount),
      category: category,
      description: description,
    );
    //update transactions page
    await showTransactions();
  }

  Future<void> deleteExpense(int id) async {
    await _expenseTable.delete(id);
    //update transactions page
    await showTransactions();
  }

  Future<void> updateIncome(int id, String amount, String source) async {
    await _incomeTable.update(
        id: id, amount: double.parse(amount), source: source);
    //update transactions page
    await showTransactions();
  }

  Future<void> deleteIncome(int id) async {
    await _incomeTable.delete(id);
    //update transactions page
    await showTransactions();
  }
}
