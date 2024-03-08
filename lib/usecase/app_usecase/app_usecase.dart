import 'package:budget_binder/data/models/user_model.dart';

abstract class AppUsecase {
  Future<double> getUserBalance(int id);
  UserModel getCurrentUser();
  void setCurrentUser(UserModel currentUser);
}
