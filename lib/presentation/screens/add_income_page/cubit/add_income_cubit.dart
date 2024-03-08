import 'package:bloc/bloc.dart';
import 'package:budget_binder/data/database/income_operations.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import '../../../../usecase/app_usecase/app_usecase.dart';
import '../../../../usecase/app_usecase/app_usecase_impl.dart';

part 'add_income_state.dart';

class AddIncomeCubit extends Cubit<AddIncomeState> {
  AddIncomeCubit() : super(AddIncomeInitial());

  final formKey = GlobalKey<FormState>();
  final TextEditingController amountController = TextEditingController();
  final TextEditingController sourceController = TextEditingController();

  final _incomeTable = IncomeDBOperations();
  final AppUsecase _appUsecase = AppUsecaseImpl();

  void submit() {
    if (formKey.currentState?.validate() ?? false) {
      int userID = _appUsecase.getCurrentUser().id;
      _incomeTable.addIncome(
        userId: userID,
        amount: double.parse(amountController.text),
        source: sourceController.text,
        date: DateTime.now().toString(),
      );
      formKey.currentState?.reset();
    }
  }
}
