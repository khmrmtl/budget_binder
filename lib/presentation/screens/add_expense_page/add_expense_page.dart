import 'package:budget_binder/presentation/screens/add_expense_page/cubit/add_expense_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddExpensePageProvider extends StatelessWidget {
  const AddExpensePageProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddExpenseCubit(),
      child: const AddExpensePage(),
    );
  }
}

class AddExpensePage extends StatelessWidget {
  const AddExpensePage({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<AddExpenseCubit>(context);
    return Scaffold(
      body: Form(
        key: cubit.formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: cubit.amountController,
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter the amount';
                }
                return null;
              },
              decoration: InputDecoration(
                labelText: 'Amount',
              ),
            ),
            TextFormField(
              controller: cubit.descriptionController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter the description';
                }
                return null;
              },
              decoration: InputDecoration(
                labelText: 'Description',
              ),
            ),
            TextFormField(
              controller: cubit.categoryController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter the category';
                }
                return null;
              },
              decoration: InputDecoration(
                labelText: 'Category',
              ),
            ),
            ElevatedButton(
              onPressed: cubit.submit,
              child: Text('Add an expense'),
            ),
          ],
        ),
      ),
    );
  }
}
