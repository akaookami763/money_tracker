import '../DataCentral/financial_category_model.dart';

abstract class FinancialCategoryRepository {
  Future<List<FinancialCategory>> getAllCategories();
  Future<int> createCategory(String name);
  Future<int> removeCategory(FinancialCategory category);
}