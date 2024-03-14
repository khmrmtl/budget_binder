import 'package:budget_binder/data/models/income_model.dart';
import 'package:flutter/material.dart';

import 'delete_income_dialog.dart';
import 'edit_income_dialog.dart';

class IncomeTile extends StatelessWidget {
  const IncomeTile({super.key, required this.model});

  final IncomeModel model;
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      color: Colors.green,
      margin: EdgeInsets.all(10),
      child: ListTile(
        contentPadding: EdgeInsets.all(10),
        title: Text('Amount: ${model.amount}'),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Source: ${model.source}'),
            Text('Date: ${model.date}'),
            Row(
              children: [
                ElevatedButton(
                    onPressed: () => showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return EditIncomeDialog(income: model);
                          },
                        ),
                    child: Text('Edit')),
                SizedBox(width: 10),
                ElevatedButton(
                  child: Icon(Icons.delete),
                  onPressed: () => showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return DeleteIncomeDialog(income: model);
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
