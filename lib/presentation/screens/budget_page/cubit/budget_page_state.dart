part of 'budget_page_cubit.dart';

@immutable
sealed class BudgetPageState {}

final class BudgetPageInitial extends BudgetPageState {}

final class BudgetPageLoaded extends BudgetPageState {
  final List<BudgetModel> users;
  final int selectedIndex;

  BudgetPageLoaded({
    required this.users,
    required this.selectedIndex,
  });
}
