import 'package:money_tracker/DataCentral/budget_model.dart';

abstract class BudgetService {
  Future<bool> createBudgetCategory(String title);
  Future<bool> updateBudgetCategory(BudgetCategory budgetCategory);
  Future<bool> deleteBudgetCategory(BudgetCategory budgetCategory);
}