
import 'package:flutter/material.dart';
import 'package:money_tracker/DataCentral/financial_category_model.dart';

import 'category_list_mock.dart';
import '../repositories/category_repository_abstract.dart';

class FinancialCategoryRepositoryMock extends FinancialCategoryRepository {

  final List<FinancialCategory> _mockDatabase = categoryListMock;

  @override
  Future<int> createCategory(String name) {
    return Future(() {
      _mockDatabase.add(FinancialCategory(UniqueKey().hashCode, name));
      return 1;
    });
  }

  @override
  Future<int> addCategory(FinancialCategory category) {
    return Future(() {
      _mockDatabase.add(category);
      return 1;
    });
  }

  @override
  Future<FinancialCategory> getCategoryByName(String name) {
    // TODO: implement getCategoryByName
    throw UnimplementedError();
  }

  @override
  Future<FinancialCategory> getCategoryByTag(int tag) {
    // TODO: implement getCategoryByTag
    throw UnimplementedError();
  }

  @override
  Future<List<FinancialCategory>> getAllCategories() {
    return  Future(() => _mockDatabase);
  }

  @override
  Future<int> removeCategory(FinancialCategory category) {
      return Future(() {
        if(_mockDatabase.remove(category)) {
        return 1;
        }
       return 0;
    });
  }

}