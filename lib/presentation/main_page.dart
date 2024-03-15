import 'package:budget_binder/data/database/income_operations.dart';
import 'package:budget_binder/data/database/budget_operations.dart';
import 'package:budget_binder/presentation/screens/budget_page/budget_page.dart';
import 'package:budget_binder/presentation/screens/home_page/cubit/home_page_cubit.dart';
import 'package:budget_binder/presentation/screens/transaction_page/transaction_page.dart';
import 'package:budget_binder/presentation/screens/home_page/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'screens/budget_page/cubit/budget_page_cubit.dart';
import 'screens/transaction_page/cubit/transaction_page_cubit.dart';

final homePageCubit = HomePageCubit();
final budgetCubit = BudgetPageCubit();
final transactionCubit = TransactionPageCubit();

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 0;

  final userTable = BudgetDBOperations();
  final incomeTable = IncomeDBOperations();

  @override
  void initState() {
    userTable.getBudgets();
    incomeTable.getUserIncome(2);
    incomeTable.getTotalIncomeForUser(1);
    super.initState();
  }

  void ontap(int index) {
    setState(() => _currentIndex = index);
  }

  final List<Widget> _body = [
    Navigator(
      onGenerateRoute: (settings) {
        return MaterialPageRoute(
          builder: (context) => const HomePage(),
        );
      },
    ),
    const BudgetPage(),
    Navigator(
      onGenerateRoute: (settings) {
        return MaterialPageRoute(
          builder: (context) => const TransactionPage(),
        );
      },
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<HomePageCubit>(create: (context) => homePageCubit..init()),
        BlocProvider<BudgetPageCubit>(create: (context) => budgetCubit..init()),
        BlocProvider<TransactionPageCubit>(
            create: (context) => transactionCubit..init()),
      ],
      child: Scaffold(
        body: IndexedStack(
          index: _currentIndex,
          children: _body,
        ),
        floatingActionButton: FloatingActionButton(onPressed: () {
          // userTable.createUser('user2');
          // userTable.update(2, "user2");
          // incomeTable.addIncome(
          //   userId: 1,
          //   amount: 200,
          //   source: "source",
          //   date: DateTime.now().toString(),
          // );
        }),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: ontap,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.add,
              ),
              label: 'add',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.history,
              ),
              label: 'Transactions',
            ),
          ],
        ),
      ),
    );
  }
}
