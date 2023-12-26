import 'package:flutter_test/flutter_test.dart';
import 'package:money_tracker/DataCentral/financial_category_model.dart';
import 'package:money_tracker/DataCentral/transaction_model.dart';
import 'package:money_tracker/History/transaction_history_view_model.dart';

import '../mocks/transaction.dart';

void main() {
  late TransactionHistoryViewModel _sut;

  setUp(() {
    _sut = TransactionHistoryViewModelImpl(sampleTransactions());
  });

  test("update transactions", () {
    DateTime date = DateTime.now();
    double cost = 3.24;
    String notes = "notes";
    FinancialCategory mockNewCategory = FinancialCategory(5, "Category5");
    List<Transaction> mockTransactions = sampleTransactions();
    mockTransactions.add(Transaction(
        tag: 100,
        category: mockNewCategory,
        date: date,
        cost: cost,
        extraNotes: notes));
    _sut.updateTransactions(mockTransactions);
  });

  test("filter transactions by category name", () {
    List<Transaction> result = _sut.filterTransactions(textInput: "Category1",
        costFilter: TransactionCost.nothing, dateFilter: TransactionDate.nothing);

    expect(result.length, 4);
    expect(result.first.getCategoryName(), "Category1");
  });

    test("filter transactions by extra notes", () {
    List<Transaction> result = _sut.filterTransactions(textInput: "rand",
        costFilter: TransactionCost.nothing, costAmount: "50", dateFilter: TransactionDate.nothing, dateValue: null);

    expect(result.length, 1);
    expect(result.first.getNotes(), "Random Notes");
  });

  test("filter transactions by cost, greater than or equal to 100 dollars", () {
    List<Transaction> result = _sut.filterTransactions(
        costFilter: TransactionCost.greaterThanOrEqual, costAmount: "100", dateFilter: TransactionDate.nothing, dateValue: null);

    expect(result.length, 3);
  });

  test("filter transactions by cost, less than or equal to 50 dollars", () {
    List<Transaction> result = _sut.filterTransactions(textInput:
        "", costFilter: TransactionCost.lessThanOrEqual, costAmount: "50",dateFilter: TransactionDate.nothing);

    expect(result.length, 5);
  });

  test("filter transactions by date, on or before 12/25/2023", () {
    List<Transaction> result = _sut.filterTransactions(
        textInput: "",
        costFilter: TransactionCost.nothing,
        dateFilter: TransactionDate.beforeOrOn,
        dateValue: DateTime(2023, 12, 25, 0, 0));

    expect(result.length, 6);
  });

  test("filter transactions by date, on or after 12/25/2023", () {
    List<Transaction> result = _sut.filterTransactions(
        textInput: "",
        costFilter: TransactionCost.nothing,
        dateFilter: TransactionDate.afterOrOn,
        dateValue: DateTime(2023, 12, 25, 0, 0));

    expect(result.length, 3);
  });
}
