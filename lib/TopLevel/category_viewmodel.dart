import 'package:flutter/material.dart';
import 'package:money_tracker/DataCentral/financial_category_model.dart';

abstract class CategoryViewModel extends ChangeNotifier {

  List<FinancialCategory> getCategories();  
  void createCategory(String categoryName);
  void editCategory(FinancialCategory category, String categoryName);
  void deleteCategory(FinancialCategory category);

}