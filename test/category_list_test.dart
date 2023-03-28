import 'dart:math';

import 'package:flutter_test/flutter_test.dart';
import 'package:money_tracker/Categories/category_list_view_viewmodel.dart';
import 'package:money_tracker/DataCentral/financial_category_model.dart';

void main() {
  CategoryListViewViewModel _sut;

  List<FinancialCategory> _mockDatabase = [
      FinancialCategory('Health'),
      FinancialCategory('Groceries'),
      FinancialCategory('Water'),
      FinancialCategory('Mortgage Interest')
    ];

  test("update Suggested Categories", () {
    _sut = CategoryListViewViewModel();
    _sut.categories = _mockDatabase;

    _sut.updateSuggestions("gr");

    expect(_sut.suggestions
    , ['Groceries']);
  });
}