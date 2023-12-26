import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:money_tracker/DataCentral/financial_category_model.dart';
import 'package:money_tracker/DataCentral/transaction_model.dart';
import 'package:money_tracker/mocks/transaction_repository_mock_impl.dart';
import 'package:money_tracker/repositories/transaction_repository_abstract.dart';
import 'package:money_tracker/services/transaction_worker.dart';

import '../mocks/category.dart';
import '../mocks/transaction.dart';
import 'transaction_worker_test.mocks.dart';

@GenerateMocks([TransactionRepository, Transaction])
void main() {
  TransactionWorker _sut;
  TransactionRepository _mockTransactionRepo = MockTransactionRepository();

  test("init the worker", () {
    // given
    _sut = TransactionWorker(_mockTransactionRepo);
  });

  test("Add a transaction", () async {
    // given
    int category = 1;
    DateTime date = DateTime(2017, 9, 7, 17, 30);
    double cost = 3.24;
    String extraNotes = "Notes";
    int success = 1;

    when(_mockTransactionRepo.createTransaction(
            category, date, cost, extraNotes))
        .thenAnswer((realInvocation) async => success);
    _sut = TransactionWorker(_mockTransactionRepo);

    expect(
        await _sut.addTransaction(category, date, cost, extraNotes), true);
  });

  test("Add a transaction fails", () async {
    int category = 1;
    DateTime date = DateTime(2017, 9, 7, 17, 30);
    double cost = 3.24;
    String extraNotes = "Notes";
    int success = 0;

    when(_mockTransactionRepo.createTransaction(
            category, date, cost, extraNotes))
        .thenAnswer((realInvocation) async => success);

    _sut = TransactionWorker(_mockTransactionRepo);

    expect(
        await _sut.addTransaction(category, date, cost, extraNotes), false);
  });

  test("Remove a transaction", () async {
    Transaction mockTransaction = MockTransaction();
    _sut = TransactionWorker(_mockTransactionRepo);

    when(_mockTransactionRepo.removeTransaction(mockTransaction))
        .thenAnswer((_) async => 1);

    expect(await _sut.deleteTransaction(mockTransaction), true);
  });

  test("Remove a transaction fails", () async {
    Transaction mockTransaction = MockTransaction();
    _sut = TransactionWorker(_mockTransactionRepo);

    when(_mockTransactionRepo.removeTransaction(mockTransaction))
        .thenAnswer((_) async => 0);
    //NOTES: Use () => for tests where a throw is expected.  Don't use "await"
    // https://stackoverflow.com/questions/54241396/flutter-test-that-a-specific-exception-is-thrown
    expect(
        () => _sut.deleteTransaction(mockTransaction), false);
  });

  test("Update a transaction", () async {
    Transaction mockTransaction = MockTransaction();
    _sut = TransactionWorker(_mockTransactionRepo);

    when(_mockTransactionRepo.updateTransaction(mockTransaction))
        .thenAnswer((_) async => 1);

    expect(await _sut.updateTransaction(mockTransaction), true);
  });

  test("Update a transaction fails", () async {
    Transaction mockTransaction = MockTransaction();
    _sut = TransactionWorker(_mockTransactionRepo);

    when(_mockTransactionRepo.updateTransaction(mockTransaction))
        .thenAnswer((_) async => 0);
    //NOTES: Use () => for tests where a throw is expected.  Don't use "await"
    // https://stackoverflow.com/questions/54241396/flutter-test-that-a-specific-exception-is-thrown
    // expect(() => _sut.updateTransaction(mockTransaction), throwsA(isA<Error>()));
        expect(() => _sut.updateTransaction(mockTransaction), false);

  });

  test("Get all transactions", () async {
    _sut = TransactionWorker(_mockTransactionRepo);
    List<Transaction> mockTransactions = sampleTransactions();
    when(_mockTransactionRepo.getAllTransactions())
        .thenAnswer((realInvocation) async => mockTransactions);

        List<Transaction> result = await _sut.getAllTransactions();

        expect(result, mockTransactions);
        expect(result.first.getCost(), 102.48);
  });

  test("Get all transactions for the test financial category", () async {
    _sut = TransactionWorker(_mockTransactionRepo);
    List<Transaction> mockTransactions = sampleTransactions();
    FinancialCategory category = sampleCategories().first; // "category1"
    when(_mockTransactionRepo.getAllTransactions())
        .thenAnswer((realInvocation) async => mockTransactions);

    List<Transaction> results = await _sut.getAllTransactionsFor(category);
        expect(results.length, 4);
  });
}
