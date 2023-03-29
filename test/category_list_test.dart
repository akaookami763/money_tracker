import 'package:flutter_test/flutter_test.dart';
import 'package:money_tracker/Categories/category_list_view_viewmodel.dart';
import 'package:money_tracker/DataCentral/financial_category_model.dart';
import 'package:money_tracker/services/category_service.dart';
import 'package:money_tracker/services/transaction_service.dart';

void main() {
  CategoryListViewViewModelImpl _sut;

  test("update Suggested Categories", () async {
    _sut = await CategoryListViewViewModelImpl.create(
        c: CategoryServiceMock(), t: TransactionServiceMock());

    Map<FinancialCategory, double> result = _sut.updateSuggestions("gr");

    expect(result.entries.length, 1);
  });
  test("Run initial load", () async {
    _sut = await CategoryListViewViewModelImpl.create(
        c: CategoryServiceMock(), t: TransactionServiceMock());

    expect(_sut.allCategories.length, 6);
    expect(_sut.allSuggestions.length, 6);
  });
}
