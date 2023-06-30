import 'package:money_tracker/DataCentral/financial_category_model.dart';

class BudgetCategory {
  final int tag;
  final String title;
  final double cost;

  BudgetCategory(this.tag, this.title, this.cost);
}

class BudgetSubCategory {
  final int tag;
  final String title;
  final BudgetCategory parent;

  BudgetSubCategory(this.tag, this.title, this.parent);
}