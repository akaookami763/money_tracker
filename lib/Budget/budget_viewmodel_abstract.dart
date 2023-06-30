import 'package:money_tracker/DataCentral/budget_model.dart';

abstract class BudgetViewModel {
  List<BudgetCategory> budgetItems = [];

  void createBudgetItem(String title);
  BudgetSubCategory createBudgetSubCategoryItem(String title);
}