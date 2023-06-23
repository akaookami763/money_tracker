
import 'package:flutter_test/flutter_test.dart';
import 'package:money_tracker/DataCentral/financial_category_model.dart';
import 'package:money_tracker/DataCentral/transaction_model.dart';
import 'package:money_tracker/Transactions/transaction_edit_view_viewModel.dart';
import 'package:money_tracker/Transactions/transaction_edit_view_viewmodelimpl.dart';
import 'package:money_tracker/services/mock/category_service_mock.dart';
import 'package:money_tracker/services/mock/transaction_service_mock.dart';


void main() {

TransactionEditViewViewModel sut;

test("Edit transaction", () {
  Transaction testTransaction = Transaction(tag: -1, category: FinancialCategory(-1, "Old Category"), date: DateTime.now(), cost: 7.12, extraNotes: "Old Notes");
  sut = TransactionEditViewViewModelImpl(testTransaction, CategoryServiceMock(), TransactionServiceMock());

  DateTime testDate = DateTime.now();

  sut.editTransaction("New Category", "5.21", testDate, "New Notes");

  expect(sut.transaction.getCategoryName, "New Category");
  expect(sut.transaction.getCost, 5.21);
  expect(sut.transaction.getDate, testDate);
  expect(sut.transaction.getNotes, "New Notes");
});
}

