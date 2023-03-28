import '../DataCentral/financial_category_model.dart';
import '../DataCentral/transaction_model.dart';

class TransactionRepositoryImpl {
  var _transactions = <Transaction>[];

  List<Transaction> sampleTransactions() => [
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
}
