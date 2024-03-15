import 'package:budget_binder/presentation/screens/add_income_page/add_income_page.dart';
import 'package:budget_binder/presentation/screens/home_page/cubit/home_page_cubit.dart';
// import 'package:budget_binder/usecase/app_usecase/app_usecase_impl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../add_expense_page/add_expense_page.dart';

// class HomePageProvider extends StatelessWidget {
//   const HomePageProvider({super.key});

//   @override
//   Widget build(BuildContext context) {
//     print('start home');
//     return BlocProvider(
//       create: (BuildContext context) => HomePageCubit()..init(),
//       child: const HomePage(),
//     );
//   }
// }

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    print('dito');
    // final currentBudget = AppUsecaseImpl().getCurrentBudget();
    return Scaffold(
      body: SafeArea(child: BlocBuilder<HomePageCubit, HomePageState>(
        builder: (context, state) {
          return Column(
            children: [
              SizedBox(
                width: double.infinity,
                child: Card(
                  elevation: 3,
                  margin: const EdgeInsets.all(20.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  color: const Color(0xFF111729),
                  child: const Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Hey, !",
                          style: TextStyle(color: Colors.white, fontSize: 32),
                        ),
                        SizedBox(height: 10),
                        Text(
                          "Welcome to BudgetBinder,\nYour Financial Companion 🌟",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            height: 1,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
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
