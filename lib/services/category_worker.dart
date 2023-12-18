import 'package:money_tracker/DataCentral/financial_category_model.dart';
import '../repositories/category_repository_abstract.dart';
import 'category_service_abstract.dart';

class CategoryWorker extends CategoryService {
  FinancialCategoryRepository repository;

  CategoryWorker(this.repository);
  @override
  Future<int> createCategory(String name) async {
    return await repository.createCategory(name);
  }

  @override
  Future<FinancialCategory> updateCategory(int categoryId, String newName) async {
    int success = await repository.updateCategoryByName(categoryId, newName);
    if (success == 1) {
      return FinancialCategory(categoryId, newName);
    } else {
       throw Error();
    }
  }

  @override
  Future<FinancialCategory> removeCategory(FinancialCategory category) async {
    int success = await repository.removeCategory(category);
    if(success == 1) {
      return category;
    } else {
      throw Error();
    }
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
