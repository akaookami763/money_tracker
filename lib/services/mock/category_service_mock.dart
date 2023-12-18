import '../../DataCentral/financial_category_model.dart';
import '../../mocks/category_repository_mock.dart';
import '../../repositories/category_repository_abstract.dart';
import '../category_service_abstract.dart';

class CategoryServiceMock extends CategoryService {
  FinancialCategoryRepository repo = FinancialCategoryRepositoryMock();

  @override
  Future<int> createCategory(String name) {
    return repo.createCategory(name);
  }

  @override
  Future<List<FinancialCategory>> getAllCategories() {
    return repo.getAllCategories();
  }

  @override
  Future<FinancialCategory> removeCategory(FinancialCategory category) async {
    int result = await repo.removeCategory(category);
    if (result == 1) {
      return category;
    } else {
      throw Error();
    }
  }
  
  @override
  Future<FinancialCategory> updateCategory(int categoryId, String newName) {
    // TODO: implement updateCategory
    throw UnimplementedError();
  }
  
  @override
  Future<FinancialCategory?> getCategoryByName(String name) {
    // TODO: implement getCategoryByName
    throw UnimplementedError();
  }
  
  @override
  Future<FinancialCategory?> getCategoryByTag(int tag) {
    // TODO: implement getCategoryByTag
    throw UnimplementedError();
  }
}