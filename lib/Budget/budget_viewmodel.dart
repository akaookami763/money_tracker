import 'package:money_tracker/DataCentral/budget_model.dart';
import 'package:money_tracker/services/budget_service_abstract.dart';
import 'package:money_tracker/services/budget_worker.dart';

import 'budget_viewmodel_abstract.dart';

class BudgetViewModelImpl implements BudgetViewModel {
  @override
  List<BudgetCategory> budgetItems = [];

  BudgetService worker = BudgetWorker();

  @override
  void setupBudgetItem() {
    // TODO: implement setupBudgetItem
  }

  @override
  void createBudgetItem(String title) {
    worker.createBudgetCategory(title);
  }

  @override
  void editBudgetItem(BudgetCategory category) {
    // TODO: implement editBudgetItem
  }

  @override
  BudgetSubCategory createBudgetSubCategoryItem(String title) {
    // TODO: implement createBudgetSubCategoryItem
    throw UnimplementedError();
  }

}