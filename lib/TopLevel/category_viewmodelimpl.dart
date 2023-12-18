import 'package:flutter/material.dart';
import 'package:money_tracker/services/category_service_abstract.dart';
import 'package:money_tracker/DataCentral/financial_category_model.dart';

import 'category_viewmodel.dart';

class CategoryViewModelImpl extends ChangeNotifier
    implements CategoryViewModel {
  final CategoryService _categoryService;

  CategoryViewModelImpl(this._categoryService);

  @override
  void createCategory(String categoryName) async {
    int result = await _categoryService.createCategory(categoryName);
    if (result == 0) {
      return;
    }
    notifyListeners();
  }

  @override
  void deleteCategory(FinancialCategory category) async {
    FinancialCategory fCategory =
        await _categoryService.removeCategory(category);

    notifyListeners();
  }

  @override
  void editCategory(FinancialCategory category, String categoryName) async {
    FinancialCategory fCategory =
        await _categoryService.updateCategory(category.tag, categoryName);

    notifyListeners();
  }
  
  @override
  Future<List<FinancialCategory>> getAllCategories() async {
    return await _categoryService.getAllCategories();
  }
}
