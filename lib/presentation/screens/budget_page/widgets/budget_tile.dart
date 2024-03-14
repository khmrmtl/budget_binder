import 'package:budget_binder/data/models/user_model.dart';
import 'package:budget_binder/presentation/main_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/budget_page_cubit.dart';

class BudgetTile extends StatelessWidget {
  const BudgetTile({super.key, required this.user});

  final BudgetModel user;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text('User ID: ${user.id}'),
      subtitle: Text('Username: ${user.username}'),
      onTap: () {
        // BlocProvider.of<BudgetPageCubit>(context).selectUser(user);
        // Navigator.pushReplacement(
        //     context, MaterialPageRoute(builder: (context) => const MainPage()));
      },
      // Add more details as needed
    );
  }
}
