import 'package:budget_binder/data/database/expense_operations.dart';
import 'package:budget_binder/usecase/app_usecase/app_usecase.dart';
import 'package:budget_binder/usecase/app_usecase/app_usecase_impl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'add_expense_state.dart';

class AddExpenseCubit extends Cubit<AddExpenseState> {
  AddExpenseCubit() : super(AddExpenseInitial());

  final formKey = GlobalKey<FormState>();
  final TextEditingController amountController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController categoryController = TextEditingController();

  final _expenseTable = ExpenseDBOperations();
  final AppUsecase _appUsecase = AppUsecaseImpl();

  void submit() {
    if (formKey.currentState?.validate() ?? false) {
      int userID = _appUsecase.getCurrentBudget().id;
      _expenseTable.addExpense(
        userId: userID,
        amount: double.parse(amountController.text),
        description: descriptionController.text,
        category: categoryController.text,
        date: DateTime.now().toString(),
      );
      formKey.currentState?.reset();
    }
  }
}
