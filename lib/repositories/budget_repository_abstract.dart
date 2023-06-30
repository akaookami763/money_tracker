import 'dart:async';

import 'package:money_tracker/DataCentral/budget_model.dart';

abstract class BudgetCategoryRepository {
  Future<int> createBudgetCategory(String title);
  Future<int> updateBudgetCategory(BudgetCategory category);
  Future<int> deleteBudgetCategory(BudgetCategory category);
}