import 'package:money_tracker/DataCentral/financial_category_model.dart';

import '../DataCentral/transaction_model.dart';


abstract class TransactionService {
  Future<List<Transaction>> getAllTransactions();
  Future<List<Transaction>> getAllTransactionsFor(FinancialCategory category);
  Future<List<Transaction>> addTransaction(int category, DateTime date, double cost, String extraNotes);
  Future<Transaction> updateTransaction(Transaction transaction);
  Future<Transaction> deleteTransaction(Transaction transaction);
}