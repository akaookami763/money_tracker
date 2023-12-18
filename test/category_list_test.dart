import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:money_tracker/Categories/list/category_list_view_viewmodel.dart';
import 'package:money_tracker/services/category_service_abstract.dart';
import 'package:money_tracker/services/mock/category_service_mock.dart';
import 'package:money_tracker/services/mock/transaction_service_mock.dart';
import 'package:money_tracker/services/transaction_service_abstract.dart';

import 'category_list_test.mocks.dart';


@GenerateMocks([CategoryService, TransactionService])
void main() {
  CategoryListViewViewModelImpl _sut;
  CategoryService _categoryServiceMock;
  TransactionService _transactionService;

  setUp(() {
    _categoryServiceMock = MockCategoryService();
    _transactionService = MockTransactionService();
    _sut = CategoryListViewViewModelImpl(_categoryServiceMock, _transactionService);
  });

  test("load all categories", () {

  });

  test("load all suggested categories", () {
    _sut.initialAction();

    expect(_sut., matcher)
  });

  test("update the suggested categories list", () {

  });

  test("reset suggested categories after new transaction", () {

  });

}
