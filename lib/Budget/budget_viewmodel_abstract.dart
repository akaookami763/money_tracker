import 'package:money_tracker/DataCentral/budget_model.dart';

abstract class BudgetViewModel {
  List<BudgetCategory> budgetItems = [];

  void setupBudgetItem();
  void createBudgetItem(String title);
  void editBudgetItem(BudgetCategory category);
  BudgetSubCategory createBudgetSubCategoryItem(String title);
}