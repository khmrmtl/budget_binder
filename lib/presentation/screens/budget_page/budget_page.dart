import 'package:budget_binder/presentation/screens/budget_page/cubit/budget_page_cubit.dart';
import 'package:budget_binder/presentation/screens/budget_page/widgets/budget_tile.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BudgetPage extends StatelessWidget {
  const BudgetPage({super.key});

  void _showUsernameInputDialog(BuildContext context, BudgetPageCubit cubit) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Enter Username'),
          content: TextField(
            controller: cubit.usernameController,
            decoration: InputDecoration(labelText: 'Username'),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                cubit.createBudget();
                Navigator.of(context).pop();
              },
              child: Text('Submit'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final budgetPageCubit = BlocProvider.of<BudgetPageCubit>(context);
    return Scaffold(
      body: BlocBuilder<BudgetPageCubit, BudgetPageState>(
        builder: (context, state) {
          return SafeArea(
            child: Center(
              child: Column(
                children: [
                  Expanded(
                    child: state is BudgetPageLoaded
                        ? CarouselSlider(
                            carouselController:
                                budgetPageCubit.buttonCarouselController,
                            options: CarouselOptions(
                              enlargeCenterPage: true,
                              initialPage: state.selectedIndex,
                              scrollDirection: Axis.vertical,
                              viewportFraction: 0.5,
                              onPageChanged: budgetPageCubit.onPageChanged,
                            ),
                            items: state.users
                                .map((e) => Builder(
                                      builder: (context) => BudgetTile(user: e),
                                    ))
                                .toList(),
                          )
                        : Text("No users yet"),
                  ),
                  ElevatedButton(
                      onPressed: () =>
                          _showUsernameInputDialog(context, budgetPageCubit),
                      child: Text('add user')),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
