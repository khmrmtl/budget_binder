import 'package:flutter/material.dart';
import '../../../../data/models/income_model.dart';
import '../transaction_page.dart';

class DeleteIncomeDialog extends StatefulWidget {
  const DeleteIncomeDialog({super.key, required this.income});

  final IncomeModel income;

  @override
  State<DeleteIncomeDialog> createState() => _DeleteIncomeDialogState();
}

class _DeleteIncomeDialogState extends State<DeleteIncomeDialog> {
  bool _loading = false;

  void _delete() async {
    setState(() => _loading = true);
    await TransactionPageProvider.cubit.deleteIncome(widget.income.id);
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
