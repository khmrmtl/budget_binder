import 'package:budget_binder/data/database/income_operations.dart';
import 'package:budget_binder/data/database/user_operations.dart';
import 'package:budget_binder/presentation/screens/budget_page/budget_page.dart';
import 'package:budget_binder/presentation/screens/expense_page/cubit/expense_page_cubit.dart';
import 'package:budget_binder/presentation/screens/history_page/history_page.dart';
import 'package:budget_binder/presentation/screens/home_page/home_page.dart';
import 'package:budget_binder/presentation/screens/income_page/cubit/income_page_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
    userTable.getUsers();
    incomeTable.getUserIncome(2);
    incomeTable.getTotalIncomeForUser(1);
    super.initState();
  }

  final List<Widget> _body = [
    const BudgetPage(),
    Navigator(
      onGenerateRoute: (settings) {
        return MaterialPageRoute(
          builder: (context) => const HomePageProvider(),
        );
      },
    ),
    Navigator(
      onGenerateRoute: (settings) {
        return MaterialPageRoute(
          builder: (context) => const HistoryPage(),
        );
      },
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<IncomePageCubit>(create: (context) => IncomePageCubit()),
        BlocProvider<ExpensePageCubit>(create: (context) => ExpensePageCubit()),
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
          onTap: (value) => setState(() => _currentIndex = value),
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
