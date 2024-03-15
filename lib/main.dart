import 'dart:convert';
import 'package:budget_binder/core/constants.dart';
import 'package:budget_binder/core/storage_manager.dart';
import 'package:budget_binder/data/models/user_model.dart';
import 'package:budget_binder/usecase/app_usecase/app_usecase.dart';
import 'package:budget_binder/usecase/app_usecase/app_usecase_impl.dart';
import 'package:flutter/material.dart';
import 'data/database/database_helper.dart';
import 'presentation/main_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DatabaseHelper().database; // initialize database

  final budgetData = await StorageManager.readData(kBudgetKey);
  final AppUsecase appUsecase = AppUsecaseImpl();
  final BudgetModel? activeBudget;

  if (budgetData != null) {
    activeBudget = BudgetModel.fromMap(jsonDecode(budgetData));
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
      home: const MainPage(),
    );
  }
}
