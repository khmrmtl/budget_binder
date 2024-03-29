import 'package:flutter/material.dart';
import '../../../../data/models/income_model.dart';
import '../cubit/transaction_page_cubit.dart';

class DeleteIncomeDialog extends StatefulWidget {
  const DeleteIncomeDialog(
      {super.key, required this.income, required this.cubit});

  final IncomeModel income;
  final TransactionPageCubit cubit;

  @override
  State<DeleteIncomeDialog> createState() => _DeleteIncomeDialogState();
}

class _DeleteIncomeDialogState extends State<DeleteIncomeDialog> {
  bool _loading = false;

  void _delete() async {
    setState(() => _loading = true);

    await widget.cubit.deleteIncome(widget.income.id);
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
