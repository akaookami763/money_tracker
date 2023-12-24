import 'package:money_tracker/DataCentral/transaction_model.dart';

import '../DataCentral/financial_category_model.dart';

abstract class TransactionRepository {
  /// Gets all transaction objects in the database
  /// Returns: A list of transaction objects
  Future<List<Transaction>> getAllTransactions();

  /// Gets all transaction objects, for a given category, in the database
  /// Returns: A list of transaction objects for the given category
  Future<List<Transaction>> getAllTransactionsFor(FinancialCategory category);

  /// Gets a transaction via it's exclusive identifer
  /// Returns: A transaction object corresponding to the passed tag
  Future<Transaction?> getTransactionByTag(int tag);

  /// Updates a transaction that exists in the database
  /// Returns: The number of rows changed.  Should always be 1.  If 0 or less, there was an error.  If higher than 1, something went wrong
  Future<int> updateTransaction(Transaction transaction);

  /// Create a transaction in the database
  /// Returns: The unique key hash of the transaction if a success, or 0 if there is a failure
  Future<int> createTransaction(
      int category, DateTime date, double cost, String extraNotes);

  /// Removes a transaction object from the database
  /// Returns: The number of rows affected by the change.  Should always be 1.  If 0 or less, it failed.  If higher than 1, something went wrong
  Future<int> removeTransaction(Transaction transaction);
}
