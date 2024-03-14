import 'package:budget_binder/data/models/expense_model.dart';
import 'package:flutter/material.dart';

import 'delete_expense_dialog.dart';
import 'edit_expense_dialog.dart';

class ExpenseTile extends StatelessWidget {
  const ExpenseTile({super.key, required this.model});

  final ExpenseModel model;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      color: Colors.red,
      margin: EdgeInsets.all(10),
      child: ListTile(
        contentPadding: EdgeInsets.all(10),
        title: Text('Amount: ${model.amount}'),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Description: ${model.description}'),
            Text('Category: ${model.category}'),
            Text('Date: ${model.date}'),
            Row(
              children: [
                ElevatedButton(
                    onPressed: () => showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return EditExpenseDialog(expense: model);
                          },
                        ),
                    child: Text('Edit')),
                SizedBox(width: 10),
                ElevatedButton(
                  child: Icon(Icons.delete),
                  onPressed: () => showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return DeleteExpenseDialog(expense: model);
                    },
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
