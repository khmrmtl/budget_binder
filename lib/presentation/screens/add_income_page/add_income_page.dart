import 'package:budget_binder/presentation/screens/add_income_page/cubit/add_income_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddIncomePageProvider extends StatelessWidget {
  const AddIncomePageProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddIncomeCubit(),
      child: const AddIncomePage(),
    );
  }
}

class AddIncomePage extends StatelessWidget {
  const AddIncomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<AddIncomeCubit>(context);
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
              controller: cubit.sourceController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter the source';
                }
                return null;
              },
              decoration: InputDecoration(
                labelText: 'Source',
              ),
            ),
            ElevatedButton(
              onPressed: cubit.submit,
              child: Text('Add Income'),
            ),
          ],
        ),
      ),
    );
  }
}
