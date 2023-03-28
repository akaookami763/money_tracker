import 'package:money_tracker/DataCentral/financial_category_model.dart';
import 'package:money_tracker/DataCentral/transaction_model.dart';
import 'package:money_tracker/repositories/transaction_repository_abstract.dart';

class TransactionRepositoryMock extends TransactionRepository {
  final List<Transaction> _mockDatabase = [
    Transaction(
        category: FinancialCategory("Category1"),
        date: DateTime.now(),
        cost: 42.35,
        extraNotes: ""),
    Transaction(
        category: FinancialCategory("Category1"),
        date: DateTime.now(),
        cost: 3.45,
        extraNotes: ""),
    Transaction(
        category: FinancialCategory("Category1"),
        date: DateTime.now(),
        cost: 100.34,
        extraNotes: ""),
    Transaction(
        category: FinancialCategory("Category1"),
        date: DateTime.now(),
        cost: 24.11,
        extraNotes: ""),
    Transaction(
        category: FinancialCategory("Category2"),
        date: DateTime.now(),
        cost: 48372.32,
        extraNotes: ""),
    Transaction(
        category: FinancialCategory("Category2"),
        date: DateTime.now(),
        cost: 48.835,
        extraNotes: ""),
    Transaction(
        category: FinancialCategory("Category3"),
        date: DateTime.now(),
        cost: 102.48,
        extraNotes: ""),
    Transaction(
        category: FinancialCategory("Category4"),
        date: DateTime.now(),
        cost: 0.54,
        extraNotes: ""),
  ];

  @override
  Future<int> createTransaction(Transaction transaction) {
    return Future(() {
      _mockDatabase.add(transaction);
      return 1;
    });
  }

  @override
  Future<List<Transaction>> getAllTransactions() {
    return Future(() => _mockDatabase);
  }

  @override
  Future<int> removeTransaction(Transaction transaction) {
    if (_mockDatabase.remove(transaction)) {
      return Future(() => 1);
    }
    return Future(() => 0);
  }
}
