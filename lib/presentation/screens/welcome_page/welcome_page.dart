import 'package:budget_binder/presentation/screens/welcome_page/cubit/welcome_page_cubit.dart';
import 'package:budget_binder/presentation/screens/welcome_page/widgets/user_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  void _showUsernameInputDialog(BuildContext context, WelcomePageCubit cubit) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Enter Username'),
          content: TextField(
            controller: cubit.usernameController,
            decoration: InputDecoration(labelText: 'Username'),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                cubit.createUser();
                Navigator.of(context).pop();
              },
              child: Text('Submit'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final welcomePageCubit = BlocProvider.of<WelcomePageCubit>(context);
    return Scaffold(
      body: BlocBuilder<WelcomePageCubit, WelcomePageState>(
        builder: (context, state) {
          return SafeArea(
            child: Center(
              child: Column(
                children: [
                  Expanded(
                    child: state is WelcomePageInitial
                        ? Text("No users yet")
                        : SingleChildScrollView(
                            child: Column(
                              children: (state as WelcomePageLoaded)
                                  .users
                                  .map((e) => UserTile(user: e))
                                  .toList(),
                            ),
                          ),
                  ),
                  ElevatedButton(
                      onPressed: () =>
                          _showUsernameInputDialog(context, welcomePageCubit),
                      child: Text('add user')),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
