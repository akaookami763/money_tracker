import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:money_tracker/Categories/list/category_list_view_viewmodel.dart';
import 'package:money_tracker/DataCentral/financial_category_model.dart';
import 'package:money_tracker/DataCentral/transaction_model.dart';

import 'mocks/category.dart';
import 'mocks/transaction.dart';


void main() {
  late CategoryListViewViewModelImpl _sut;

  List<Transaction> mockTransactionsFiltered(FinancialCategory category) {
    return sampleTransactions().where((transation) => transation.getCategory() == category).toList();
  }

  setUp(() {
    _sut = CategoryListViewViewModelImpl();
  });

  test("get all suggested categories", () {
    _sut.updateCategories(sampleCategories(), sampleTransactions());
    Map<FinancialCategory, double> result = _sut.getSuggestedCategories("");
    expect(result.length, 4);
  });

  test("get suggested categories by filter", () {
        _sut.updateCategories(sampleCategories(), sampleTransactions());

    Map<FinancialCategory, double> result = _sut.getSuggestedCategories("1");
    expect(result.length, 1);
  });

  test("when adding a transaction with a new category, update the categories", () {
    DateTime date = DateTime.now();
    double cost = 3.24;
    String notes = "notes";
    List<FinancialCategory> mockList = sampleCategories();
    FinancialCategory mockNewCategory = FinancialCategory(5, "Category5");
    mockList.add(FinancialCategory(5, "Category5"));
    List<Transaction> mockTransactions = sampleTransactions();
    mockTransactions.add(Transaction(tag: 100, category: mockNewCategory, date: date, cost: cost, extraNotes: notes));
    _sut.updateCategories(mockList, mockTransactions);

    expect(_sut.getSuggestedCategories("").length, 5);
  });

  test("when adding a transaction with an existing category, don't update the categories", () {
    DateTime date = DateTime.now();
    double cost = 3.24;
    String notes = "notes";
    List<FinancialCategory> mockList = sampleCategories();
    FinancialCategory mockOldCategory = sampleCategories().where((element) => element.tag == 3).toList().first;
    List<Transaction> mockTransactions = sampleTransactions();
    mockTransactions.add(Transaction(tag: 100, category: mockOldCategory, date: date, cost: cost, extraNotes: notes));

    _sut.updateCategories(mockList, mockTransactions);

    expect(_sut.getSuggestedCategories("").length, 4);

  });

}
