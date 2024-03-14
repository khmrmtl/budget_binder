import 'package:budget_binder/data/models/expense_model.dart';
import 'package:flutter/material.dart';

import '../transaction_page.dart';

class DeleteExpenseDialog extends StatefulWidget {
  const DeleteExpenseDialog({super.key, required this.expense});

  final ExpenseModel expense;

  @override
  State<DeleteExpenseDialog> createState() => _DeleteExpenseDialogState();
}

class _DeleteExpenseDialogState extends State<DeleteExpenseDialog> {
  bool _loading = false;

  void _delete() async {
    setState(() => _loading = true);
    await TransactionPageProvider.cubit.deleteExpense(widget.expense.id);
    if (mounted) {
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Confirm Deletion'),
      content: Text('Are you sure you want to delete this item?'),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(); // Close the dialog
          },
          child: Text('Cancel'),
        ),
        TextButton(
          onPressed: _loading ? null : _delete,
          child: _loading
              ? const CircularProgressIndicator.adaptive()
              : const Text('Delete'),
        ),
      ],
    );
  }
}
