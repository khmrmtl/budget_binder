import 'package:budget_binder/presentation/screens/transaction_page/transaction_page.dart';
import 'package:flutter/material.dart';

import '../../../../data/models/income_model.dart';

class EditIncomeDialog extends StatefulWidget {
  final IncomeModel income;

  const EditIncomeDialog({super.key, required this.income});

  @override
  State<EditIncomeDialog> createState() => _EditIncomeDialogState();
}

class _EditIncomeDialogState extends State<EditIncomeDialog> {
  late TextEditingController _sourceController;
  late TextEditingController _amountController;
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    _sourceController = TextEditingController(text: widget.income.source);
    _amountController =
        TextEditingController(text: widget.income.amount.toString());
  }

  @override
  void dispose() {
    _sourceController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  void _save() async {
    setState(() => _loading = true);
    await TransactionPageProvider.cubit.updateIncome(
      widget.income.id,
      _amountController.text,
      _sourceController.text,
    );
    if (mounted) {
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Edit Income'),
            TextFormField(
              controller: _sourceController,
              decoration: InputDecoration(labelText: 'Source'),
            ),
            TextFormField(
              controller: _amountController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Amount'),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: _loading ? null : _save,
              child: _loading
                  ? const CircularProgressIndicator.adaptive()
                  : const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
