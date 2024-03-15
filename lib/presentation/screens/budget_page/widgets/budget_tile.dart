import 'package:budget_binder/data/models/user_model.dart';
import 'package:flutter/material.dart';

class BudgetTile extends StatelessWidget {
  const BudgetTile({super.key, required this.user});

  final BudgetModel user;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Container(
        height: 300,
        child: ListTile(
          title: Text('User ID: ${user.id}'),
          subtitle: Text('Username: ${user.username}'),
          onTap: () {
            // BlocProvider.of<BudgetPageCubit>(context).selectUser(user);
            // Navigator.pushReplacement(
            //     context, MaterialPageRoute(builder: (context) => const MainPage()));
          },
          // Add more details as needed
        ),
      ),
    );
  }
}
