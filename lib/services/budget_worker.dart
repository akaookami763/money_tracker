import 'package:money_tracker/DataCentral/budget_model.dart';
import 'package:money_tracker/repositories/budget_repository.dart';
import 'package:money_tracker/repositories/budget_repository_abstract.dart';
import 'package:money_tracker/services/budget_service_abstract.dart';

class BudgetWorker implements BudgetService {
  BudgetCategoryRepository repo = BudgetCategoryRepositoryImpl();

  @override
  Future<bool> createBudgetCategory(String title) async {
    int result = await repo.createBudgetCategory(title);
    return true;
  }

  @override
  Future<bool> deleteBudgetCategory(BudgetCategory budgetCategory) async {
    int result = await repo.deleteBudgetCategory(budgetCategory);
    return true;
  }

  @override
  Future<bool> updateBudgetCategory(BudgetCategory budgetCategory) async {
    int result = await repo.updateBudgetCategory(budgetCategory);
    return true;
  }

}