import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'income_page_state.dart';

class IncomePageCubit extends Cubit<IncomePageState> {
  IncomePageCubit() : super(IncomePageInitial());
}
