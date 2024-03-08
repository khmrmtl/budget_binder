import 'package:budget_binder/presentation/screens/add_income_page/add_income_page.dart';
import 'package:budget_binder/presentation/screens/home_page/cubit/home_page_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../add_expense_page/add_expense_page.dart';

class HomePageProvider extends StatelessWidget {
  const HomePageProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => HomePageCubit()..init(),
      child: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: BlocBuilder<HomePageCubit, HomePageState>(
        builder: (context, state) {
          return Column(
            children: [
              Text(
                (state is HomePageLoaded)
                    ? 'Balance: ${state.balance}'
                    : 'Processing balance',
              ),
              Row(
                children: [
                  Column(
                    children: [
                      if (state is HomePageLoaded)
                        Text('Total income: ${state.totalIncome}'),
                      ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const AddIncomePageProvider()),
                            );
                          },
                          child: Text("add income")),
                    ],
                  ),
                  Spacer(),
                  Column(
                    children: [
                      if (state is HomePageLoaded)
                        Text('Total expenses: ${state.totalExpenses}'),
                      ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const AddExpensePageProvider()),
                            );
                          },
                          child: Text("add expenses")),
                    ],
                  )
                ],
              )
            ],
          );
        },
      )),
    );
  }
}
