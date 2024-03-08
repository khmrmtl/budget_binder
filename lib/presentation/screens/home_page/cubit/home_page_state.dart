part of 'home_page_cubit.dart';

@immutable
sealed class HomePageState {}

final class HomePageInitial extends HomePageState {}

final class HomePageLoaded extends HomePageState {
  final double balance;
  final double totalIncome;
  final double totalExpenses;

  HomePageLoaded(
      {required this.totalIncome,
      required this.totalExpenses,
      required this.balance});
}
