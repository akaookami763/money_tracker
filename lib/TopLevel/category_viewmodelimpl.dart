import 'package:flutter/material.dart';
import 'package:money_tracker/services/category_service_abstract.dart';
import 'package:money_tracker/DataCentral/financial_category_model.dart';

import 'category_viewmodel.dart';

class CategoryViewModelImpl extends ChangeNotifier
    implements CategoryViewModel {
  List<FinancialCategory> _categories = [];
  final CategoryService _categoryService;

  CategoryViewModelImpl(this._categoryService) {
    _updateCategories();
  }

  @override
  List<FinancialCategory> getCategories() {
    return _categories;
  }

  @override
  void createCategory(String categoryName) async {
    int result = await _categoryService.createCategory(categoryName);
    if (result == 0) {
      return;
    }
    _updateCategories();
  }

  @override
  void deleteCategory(FinancialCategory category) async {
    FinancialCategory fCategory =
        await _categoryService.removeCategory(category);
    _updateCategories();
  }

  @override
  void editCategory(FinancialCategory category, String categoryName) async {
    FinancialCategory fCategory =
        await _categoryService.updateCategory(category.tag, categoryName);
    _updateCategories();
  }

  void _updateCategories() async {
    _categories = await _categoryService.getAllCategories();
          print("SELFLOG: Notify listeners that categories have changed");

    notifyListeners();
  }
}
