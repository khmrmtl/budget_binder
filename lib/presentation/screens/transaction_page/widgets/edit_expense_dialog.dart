import 'package:flutter/material.dart';
import '../../../../data/models/expense_model.dart';
import '../transaction_page.dart';

class EditExpenseDialog extends StatefulWidget {
  final ExpenseModel expense;

  const EditExpenseDialog({super.key, required this.expense});

  @override
  State<EditExpenseDialog> createState() => _EditExpenseDialogState();
}

class _EditExpenseDialogState extends State<EditExpenseDialog> {
  late TextEditingController _amountController;
  late TextEditingController _descriptionController;
  late TextEditingController _categoryController;
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    _amountController =
        TextEditingController(text: widget.expense.amount.toString());
    _descriptionController =
        TextEditingController(text: widget.expense.description);
    _categoryController = TextEditingController(text: widget.expense.category);
  }

  @override
  void dispose() {
    _amountController.dispose();
    _descriptionController.dispose();
    _categoryController.dispose();

    super.dispose();
  }

  void _save() async {
    setState(() => _loading = true);
    await TransactionPageProvider.cubit.updateExpense(
      widget.expense.id,
      _amountController.text,
      _descriptionController.text,
      _categoryController.text,
    );
    if (mounted) {
      Navigator.pop(context);
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
            Text('Edit Expense'),
            TextFormField(
              controller: _amountController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Amount'),
            ),
            TextFormField(
              controller: _descriptionController,
              decoration: InputDecoration(labelText: 'Description'),
            ),
            TextFormField(
              controller: _categoryController,
              decoration: InputDecoration(labelText: 'Category'),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: _loading ? null : _save,
              child: _loading
                  ? CircularProgressIndicator.adaptive()
                  : Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
