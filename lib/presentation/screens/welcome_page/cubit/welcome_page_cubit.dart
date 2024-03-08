import 'dart:convert';

import 'package:budget_binder/core/constants.dart';
import 'package:budget_binder/core/storage_manager.dart';
import 'package:budget_binder/data/database/user_operations.dart';
import 'package:budget_binder/data/models/user_model.dart';
import 'package:budget_binder/usecase/app_usecase/app_usecase.dart';
import 'package:budget_binder/usecase/app_usecase/app_usecase_impl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'welcome_page_state.dart';

class WelcomePageCubit extends Cubit<WelcomePageState> {
  WelcomePageCubit() : super(WelcomePageInitial());

  final _userTable = UserDBOperations();
  final AppUsecase _appUsecase = AppUsecaseImpl();

  TextEditingController usernameController = TextEditingController();
  List<UserModel> _users = [];

  void init() async {
    _users = await _userTable.getUsers();
    if (_users.isNotEmpty) emit(WelcomePageLoaded(users: _users));
  }

  Future<void> createUser() async {
    await _userTable.createUser(usernameController.text);
    init();
  }

  Future<void> selectUser(UserModel user) async {
    _appUsecase.setCurrentUser(user);
    await StorageManager.saveData(kUserKey, jsonEncode(user.toMap()));
  }
}
