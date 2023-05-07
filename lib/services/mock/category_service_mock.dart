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
  Future<int> removeCategory(FinancialCategory category) {
    return repo.removeCategory(category);
  }
}