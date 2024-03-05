import 'package:budget_binder/data/database/income_operations.dart';
import 'package:budget_binder/data/database/user_operations.dart';
import 'package:budget_binder/data/models/user_model.dart';
import 'package:budget_binder/presentation/screens/income_page/cubit/income_page_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key, required this.user});

  final UserModel user;
  static late final UserModel currentUser;

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 0;

  final userTable = UserDBOperations();
  final incomeTable = IncomeDBOperations();

  @override
  void initState() {
    MainPage.currentUser = widget.user;
    userTable.getUsers();
    incomeTable.getUserIncome(2);
    incomeTable.getTotalIncomeForUser(1);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<IncomePageCubit>(create: (context) => IncomePageCubit()),
        BlocProvider<IncomePageCubit>(create: (context) => IncomePageCubit()),
      ],
      child: Scaffold(
        body: const Placeholder(),
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
                Icons.history,
              ),
              label: 'next',
            ),
          ],
        ),
      ),
    );
  }
}
