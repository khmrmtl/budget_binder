import 'package:budget_binder/presentation/screens/transaction_page/cubit/transaction_page_cubit.dart';
import 'package:budget_binder/presentation/screens/transaction_page/widgets/income_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'widgets/expense_tile.dart';

class TransactionPageProvider extends StatelessWidget {
  const TransactionPageProvider({super.key});
  static final cubit = TransactionPageCubit();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => cubit..init(),
      child: const TransactionPage(),
    );
  }
}

class TransactionPage extends StatelessWidget {
  const TransactionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<TransactionPageCubit, TransactionPageState>(
        builder: (context, state) {
          if (state is TransactionPageLoaded) {
            return SingleChildScrollView(
              child: Column(
                children: state.transactions.reversed.map((e) {
                  if (e.isIncome) {
                    return IncomeTile(model: e.income!);
                  } else {
                    return ExpenseTile(model: e.expense!);
                  }
                }).toList(),
              ),
            );
          }
          return Center(
            child: Text("asdasd"),
          );
        },
      ),
    );
  }
}
