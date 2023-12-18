
import 'package:money_tracker/DataCentral/financial_category_model.dart';

abstract class CategoryListViewViewModel {
  String notes = "";

  Future initialAction();
  void updateCategories(List<FinancialCategory> list);
  void setCategoriesFromList(List<FinancialCategory> list);
  Map<FinancialCategory, double> categories();
  Map<FinancialCategory, double> filterSuggestedCategories(String userInput);
  Future removeCategory(String categoryName);
}