import 'package:flutter/material.dart';
import 'package:money_tracker/DataCentral/financial_category_model.dart';

abstract class CategoryService {
  Future<int> createCategory(String name);
  Future<FinancialCategory> updateCategory(int categoryId, String newName);
  Future<FinancialCategory> removeCategory(FinancialCategory category);
  Future<List<FinancialCategory>> getAllCategories();
  Future<FinancialCategory?> getCategoryByName(String name);
  Future<FinancialCategory?> getCategoryByTag(int tag);
}
