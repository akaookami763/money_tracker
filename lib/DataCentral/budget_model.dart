import 'package:money_tracker/DataCentral/financial_category_model.dart';

class BudgetCategory {
  final int tag;
  final String title;
  final double cost;
  final List<FinancialCategory> spendingCategories;

  BudgetCategory(this.tag, this.title, this.cost, this.spendingCategories);

  void addSpendingCategory(FinancialCategory category) {
    spendingCategories.add(category);
  }

  void removeSpendingCategory(FinancialCategory category) {
    spendingCategories.removeWhere((element) {
      return element == category;
    });
  }
}

class BudgetSubCategory {
  final int tag;
  final String title;
  final BudgetCategory parent;

  BudgetSubCategory(this.tag, this.title, this.parent);
}