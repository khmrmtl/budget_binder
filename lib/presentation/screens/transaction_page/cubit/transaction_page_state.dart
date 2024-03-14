part of 'transaction_page_cubit.dart';

@immutable
sealed class TransactionPageState {}

final class TransactionPageInitial extends TransactionPageState {}

final class TransactionPageLoaded extends TransactionPageState {
  final List<TransactionModel> transactions;

  TransactionPageLoaded({required this.transactions});
}
