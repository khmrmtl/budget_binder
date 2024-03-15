import 'dart:convert';

import 'package:budget_binder/core/constants.dart';
import 'package:budget_binder/core/storage_manager.dart';
import 'package:budget_binder/data/database/budget_operations.dart';
import 'package:budget_binder/data/models/user_model.dart';
import 'package:budget_binder/presentation/main_page.dart';
import 'package:budget_binder/usecase/app_usecase/app_usecase.dart';
import 'package:budget_binder/usecase/app_usecase/app_usecase_impl.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'budget_page_state.dart';

class BudgetPageCubit extends Cubit<BudgetPageState> {
  BudgetPageCubit() : super(BudgetPageInitial());

  CarouselController buttonCarouselController = CarouselController();

  final _budgetTable = BudgetDBOperations();
  final AppUsecase _appUsecase = AppUsecaseImpl();

  TextEditingController usernameController = TextEditingController();
  List<BudgetModel> _budgets = [];

  void init() async {
    _budgets = await _budgetTable.getBudgets();
    if (_budgets.isNotEmpty && _appUsecase.hasAnActiveBudget) {
      final currentBudget = _appUsecase.getCurrentBudget();
      int index =
          _budgets.indexWhere((budget) => budget.id == currentBudget.id);
      emit(BudgetPageLoaded(users: _budgets, selectedIndex: index));
    }
  }

  Future<void> createBudget() async {
    int id = await _budgetTable.createBudget(usernameController.text);
    final newBudget = await _budgetTable.getBudgetByID(id);

    if (newBudget != null) {
      _budgets.add(newBudget);
      _selectBudget(newBudget);
      int index = _budgets.length - 1;
      buttonCarouselController.animateToPage(
        index,
        duration: const Duration(seconds: 1),
      );
      emit(BudgetPageLoaded(users: _budgets, selectedIndex: index));
    }
  }

  Future<void> _selectBudget(BudgetModel budget) async {
    _appUsecase.setCurrentBudget(budget);
    await StorageManager.saveData(kBudgetKey, jsonEncode(budget.toMap()));
  }

  void onPageChanged(int index, CarouselPageChangedReason reason) async {
    final selectedBudget = _budgets[index];
    _selectBudget(selectedBudget);

    //reflect changes on home and transactions
    // globally declared - located at main page
    homePageCubit.init();
    transactionCubit.init();

    emit(BudgetPageLoaded(users: _budgets, selectedIndex: index));
  }
}
