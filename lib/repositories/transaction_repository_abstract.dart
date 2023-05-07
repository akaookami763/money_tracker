import 'package:money_tracker/DataCentral/transaction_model.dart';

import '../DataCentral/financial_category_model.dart';

abstract class TransactionRepository {
  Future<List<Transaction>> getAllTransactions();
  Future<List<Transaction>> getAllTransactionsFor(FinancialCategory category);
  Future<Transaction> getTransactionByTag(int tag);
  Future<int> createTransaction(int category, DateTime date, double cost, String extraNotes);
  Future<int> removeTransaction(Transaction transaction);
}