import 'dart:convert';

import 'package:budget_binder/core/constants.dart';
import 'package:budget_binder/core/storage_manager.dart';
import 'package:budget_binder/data/models/user_model.dart';
import 'package:budget_binder/presentation/screens/budget_page/cubit/budget_page_cubit.dart';
import 'package:budget_binder/usecase/app_usecase/app_usecase.dart';
import 'package:budget_binder/usecase/app_usecase/app_usecase_impl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'data/database/database_helper.dart';
import 'presentation/main_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DatabaseHelper().database; // initialize database

  final userData = await StorageManager.readData(kUserKey);
  final AppUsecase appUsecase = AppUsecaseImpl();
  final BudgetModel? activeBudget;

  if (userData != null) {
    activeBudget = BudgetModel.fromMap(jsonDecode(userData));
    appUsecase.setCurrentBudget(activeBudget);
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Budget Binder',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: BlocProvider<BudgetPageCubit>(
        create: (context) => BudgetPageCubit()..init(),
        // child: const HomePage(),

        child: const MainPage(),
      ),
    );
  }
}
