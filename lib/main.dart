import 'dart:convert';

import 'package:budget_binder/core/constants.dart';
import 'package:budget_binder/core/storage_manager.dart';
import 'package:budget_binder/data/models/user_model.dart';
import 'package:budget_binder/presentation/screens/welcome_page/cubit/welcome_page_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'data/database/database_helper.dart';
import 'presentation/main_page.dart';
import 'presentation/screens/welcome_page/welcome_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DatabaseHelper().database; // initialize database

  final userData = await StorageManager.readData(kUserKey);
  final UserModel? user;
  if (userData != null) {
    user = UserModel.fromMap(jsonDecode(userData));
  } else {
    user = null;
  }

  runApp(MyApp(user: user));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.user});
  final UserModel? user;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Budget Binder',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: BlocProvider<WelcomePageCubit>(
        create: (context) => WelcomePageCubit()..init(),
        // child: const HomePage(),

        child: user != null ? MainPage(user: user!) : const WelcomePage(),
      ),
    );
  }
}
