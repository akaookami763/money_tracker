
import 'package:money_tracker/DataCentral/financial_category_model.dart';

abstract class CategoryService {
  Future<List<FinancialCategory>> getAllCategories();
  Future<int> createCategory(String name);
  Future<int> removeCategory(FinancialCategory category);
}