import 'package:budget_binder/data/models/user_model.dart';
import 'package:budget_binder/presentation/main_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/welcome_page_cubit.dart';

class UserTile extends StatelessWidget {
  const UserTile({super.key, required this.user});

  final UserModel user;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text('User ID: ${user.id}'),
      subtitle: Text('Username: ${user.username}'),
      onTap: () {
        BlocProvider.of<WelcomePageCubit>(context).selectUser(user);
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => MainPage(user: user)));
      },
      // Add more details as needed
    );
  }
}
