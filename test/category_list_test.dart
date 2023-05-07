import 'package:flutter_test/flutter_test.dart';
import 'package:money_tracker/Categories/category_list_view_viewmodel.dart';
import 'package:money_tracker/services/mock/category_service_mock.dart';
import 'package:money_tracker/services/mock/transaction_service_mock.dart';

void main() {
  CategoryListViewViewModelImpl _sut;

  test("update Suggested Categories", () async {
    _sut = CategoryListViewViewModelImpl(CategoryServiceMock(), TransactionServiceMock());

    _sut.updateSuggestions("gr");

    expect(_sut.allSuggestions.length, 1);
  });
  test("Run initial load", () async {
    _sut = CategoryListViewViewModelImpl(CategoryServiceMock(), TransactionServiceMock());


    expect(_sut.allCategories.length, 6);
    expect(_sut.allSuggestions.length, 6);
  });

  test("Integration of making a new transaction for the same category twice", () async {
    _sut = CategoryListViewViewModelImpl(CategoryServiceMock(), TransactionServiceMock());
    await _sut.initialAction();
    await _sut.addTransaction("new", "3.45");
    await _sut.addTransaction("new", "10.34");

  });
}
