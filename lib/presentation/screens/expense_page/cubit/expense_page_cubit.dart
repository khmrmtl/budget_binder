import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'expense_page_state.dart';

class ExpensePageCubit extends Cubit<ExpensePageState> {
  ExpensePageCubit() : super(ExpensePageInitial());
}
