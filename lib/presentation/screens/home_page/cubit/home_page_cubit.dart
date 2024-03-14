import 'package:budget_binder/usecase/app_usecase/app_usecase.dart';
import 'package:budget_binder/usecase/app_usecase/app_usecase_impl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../data/database/expense_operations.dart';
import '../../../../data/database/income_operations.dart';

part 'home_page_state.dart';

class HomePageCubit extends Cubit<HomePageState> {
  HomePageCubit() : super(HomePageInitial());
  final AppUsecase _appUsecase = AppUsecaseImpl();

  final IncomeDBOperations _incomeTable = IncomeDBOperations();
  final ExpenseDBOperations _expenseTable = ExpenseDBOperations();
  late final int userId;

  void init() async {
    userId = _appUsecase.getCurrentUser().id;
    showBalance();
  }

  void showBalance() async {
    double income = await _incomeTable.getTotalIncomeForUser(userId);
    double expense = await _expenseTable.getTotalExpenseForUser(userId);
    emit(
      HomePageLoaded(
        balance: income - expense,
        totalIncome: income,
        totalExpenses: expense,
      ),
    );
  }
}
