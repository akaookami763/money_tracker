import 'package:money_tracker/DataCentral/financial_category_model.dart';
import '../repositories/category_repository_abstract.dart';
import 'category_service_abstract.dart';

class CategoryWorker extends CategoryService {
  FinancialCategoryRepository repository;

  CategoryWorker(this.repository);
  @override
  Future<bool> createCategory(String name) async {
    int success = await repository.createCategory(name);
    return success != 0 ? true : false;
  }

  @override
  Future<bool> updateCategory(int categoryId, String newName) async {
    int success = await repository.updateCategoryByName(categoryId, newName);
    return success == 1 ? true : false;
  }

  @override
  Future<bool> removeCategory(FinancialCategory category) async {
    int success = await repository.removeCategory(category);
    return success == 1 ? true : false;
  }

  @override
  Future<List<FinancialCategory>> getAllCategories() async {
    return await repository.getAllCategories();
  }

  @override
  Future<FinancialCategory?> getCategoryByName(String name) async {
    return await repository.getCategoryByName(name);
  }

  @override
  Future<FinancialCategory?> getCategoryByTag(int tag) async {
    return await repository.getCategoryByTag(tag);
  }
}
