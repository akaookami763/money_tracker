import 'package:flutter/material.dart';
import 'package:money_tracker/DataCentral/financial_category_model.dart';

import '../repositories/category_repository_abstract.dart';
import '../repositories/category_repository_mock.dart';
import 'category_service_abstract.dart';
import 'database_helper.dart';

class CategoryWorker extends CategoryService {
  @override
  Future<int> createCategory(String name) async {
    final database = await DatabaseHelper.instance.database;
    Map<String, String> row = {
      'name': name,
      'tag' : UniqueKey().toString(),
    };
    return (database.insert('categories', row));
  }

  @override
  Future<int> addCategory(FinancialCategory category) async {
    final database = await DatabaseHelper.instance.database;
    Map<String, String> row = {
      'name': category.name,
      'tag' : category.tag.toString(),
    };
    return (database.insert('categories', row));
  }

  @override
  Future<List<FinancialCategory>> getAllCategories() async {
    final database = await DatabaseHelper.instance.database;
    final allRows = await database.query('categories');
    return allRows.map((category) {
      return FinancialCategory.fromMap(category);
    }).toList();
  }

  @override
  Future<int> removeCategory(FinancialCategory category) async {
    final database = await DatabaseHelper.instance.database;
    return await database
        .delete('categories', whereArgs: [category.tag]).then((value) {
      return value == 1 ? 0 : 1;
    });
  }
}

class CategoryServiceMock extends CategoryService {
  FinancialCategoryRepository repo = FinancialCategoryRepositoryMock();

  @override
  Future<int> createCategory(String name) {
    return repo.createCategory(name);
  }

  @override
  Future<int> addCategory(FinancialCategory category) {
    return repo.addCategory(category);
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
