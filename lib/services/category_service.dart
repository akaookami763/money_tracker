import 'package:flutter/material.dart';
import 'package:money_tracker/DataCentral/financial_category_model.dart';

import '../repositories/category_repository.dart';
import '../repositories/category_repository_abstract.dart';
import 'category_service_abstract.dart';

class CategoryWorker extends CategoryService {
  FinancialCategoryRepository repository = FinancialCategoryRepositoryImpl();
  @override
  Future<int> createCategory(String name) async {
    return await repository.createCategory(name);
  }

  @override
  Future<List<FinancialCategory>> getAllCategories() async {
    return await repository.getAllCategories();
  }

  @override
  Future<int> removeCategory(FinancialCategory category) async {
    return await repository.removeCategory(category);
  }
}
