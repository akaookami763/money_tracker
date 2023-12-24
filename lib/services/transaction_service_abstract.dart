import 'package:money_tracker/DataCentral/financial_category_model.dart';

import '../DataCentral/transaction_model.dart';


abstract class TransactionService {
  Future<List<Transaction>> getAllTransactions();
  Future<List<Transaction>> getAllTransactionsFor(FinancialCategory category);
  Future<bool> addTransaction(int category, DateTime date, double cost, String extraNotes);
  Future<bool> updateTransaction(Transaction transaction);
  Future<bool> deleteTransaction(Transaction transaction);
}