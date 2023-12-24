import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:money_tracker/DataCentral/financial_category_model.dart';
import 'package:money_tracker/DataCentral/transaction_model.dart';
import 'package:money_tracker/TopLevel/transaction_viewmodel.dart';
import 'package:money_tracker/TopLevel/transaction_viewmodelimpl.dart';
import 'package:money_tracker/services/category_service_abstract.dart';
import 'package:money_tracker/services/transaction_service_abstract.dart';

import 'transaction_viewmodel_test.mocks.dart';


@GenerateMocks([TransactionService, CategoryService])
void main() {
  late TransactionViewModel _sut;
  late TransactionService _mockTransactionService;
  late CategoryService _mockCategoryService;

  setUp(() {
    _mockTransactionService = MockTransactionService();
    _mockCategoryService = MockCategoryService();
    _sut =
        TransactionViewModelImpl(_mockTransactionService, _mockCategoryService);
  });

  test("Adding a transaction will make the transaction", () async {
    String categoryName = "Category1";
    int category = 1;
    DateTime date = DateTime(2017, 9, 7, 17, 30);
    String cost = "3.24";
    double convertedCost = 3.24;
    String extraNotes = "Notes";
    FinancialCategory mockNewCategory = FinancialCategory(1, "Category1");

    when(_mockTransactionService.addTransaction(
            category, date, convertedCost, extraNotes))
        .thenAnswer((fI) async => true);
    bool result =
        await _sut.addTransaction(categoryName, cost, date, extraNotes);

    expect(result, true);
  });

  test(
      "Adding a transaction with a cost that cannot be converted to double will return an error state",
      () async {
    bool result = await _sut.addTransaction(
        "Pointless", "Can't convert", DateTime.now(), "Pointless");

    expect(result, false);
  });

  test("Updating a transaction will change its details to what is desired",
      () async {
    String categoryName = "Category1";
    DateTime date = DateTime(2017, 9, 7, 17, 30);
    String cost = "3.24";
    double convertedCost = 3.24;
    String extraNotes = "Notes";
    FinancialCategory mockCategory = FinancialCategory(100, "TestCategory");
    Transaction mockTransaction = Transaction(
        tag: 100,
        category: mockCategory,
        date: date,
        cost: convertedCost,
        extraNotes: extraNotes);
    bool result = await _sut.editTransaction(
        categoryName, cost, date, extraNotes, mockTransaction);

    expect(result, true);
  });

  test(
      "Updating a category in a transaction will update the desired transaction and the corresponding category",
      () {});

  test(
      "Deleting a transaction will remove the transaction from the available source",
      () {});

  test(
      "Deleting a transaction where it is the only transaction of a category will remove the transaction and category from the available source",
      () {});
}
