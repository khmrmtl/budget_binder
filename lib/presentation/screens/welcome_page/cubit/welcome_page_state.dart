part of 'welcome_page_cubit.dart';

@immutable
sealed class WelcomePageState {}

final class WelcomePageInitial extends WelcomePageState {}

final class WelcomePageLoaded extends WelcomePageState {
  final List<UserModel> users;

  WelcomePageLoaded({required this.users});
}
