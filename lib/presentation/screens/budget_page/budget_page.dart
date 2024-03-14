import 'package:budget_binder/presentation/screens/budget_page/cubit/budget_page_cubit.dart';
import 'package:budget_binder/presentation/screens/budget_page/widgets/budget_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BudgetPage extends StatelessWidget {
  const BudgetPage({super.key});

  void _showUsernameInputDialog(BuildContext context, BudgetPageCubit cubit) {
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
    final welcomePageCubit = BlocProvider.of<BudgetPageCubit>(context);
    return Scaffold(
      body: BlocBuilder<BudgetPageCubit, BudgetPageState>(
        builder: (context, state) {
          return SafeArea(
            child: Center(
              child: Column(
                children: [
                  Expanded(
                    child: state is BudgetPageInitial
                        ? Text("No users yet")
                        : SingleChildScrollView(
                            child: Column(
                              children: (state as BudgetPageLoaded)
                                  .users
                                  .map((e) => BudgetTile(user: e))
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
