import '../DataCentral/financial_category_model.dart';

abstract class FinancialCategoryRepository {
  /// Gets all category objects in the database
  /// Returns: A list of category objects
  Future<List<FinancialCategory>> getAllCategories();
  
  Future<FinancialCategory?> getCategoryByTag(int tag);
  Future<FinancialCategory?> getCategoryByName(String name);
  Future<int> createCategory(String name);
  Future<int> updateCategoryByName(int tag, String name);
  Future<int> removeCategory(FinancialCategory category);
}
