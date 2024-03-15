import 'package:budget_binder/data/models/user_model.dart';

abstract class AppUsecase {
  Future<double> getBudgetBalance(int id);
  BudgetModel getCurrentBudget();
  void setCurrentBudget(BudgetModel currentUser);
  bool get hasAnActiveBudget;
}
