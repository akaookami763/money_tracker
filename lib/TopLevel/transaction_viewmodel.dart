import 'package:money_tracker/DataCentral/financial_category_model.dart';

import '../DataCentral/transaction_model.dart';

//TODO: convert the VM to use these errors for false returns
enum TransactionViewModelErrorState {
  doubleConvertionError,
  failedToFindCategoryError,
  databaseError
}

abstract class TransactionViewModel {
  /// Gets all transactions available in the app
  List<Transaction> getTransactions();

  /// Gets all categories available in the app
  List<FinancialCategory> getCategories();

  /// Added a transaction.
  ///Returns: True if the add was successful.  False if something went wrong.
  Future<bool> addTransaction(
      String categoryName, String cost, DateTime time, String extraNotes);

  /// Edits an existing transaction.
  ///Returns: True if the edit was successful.  False if something went wrong.
  Future<bool> editTransaction(String categoryName, String cost, DateTime date,
      String extraNotes, Transaction transaction);

  /// Deletes an existing transaction.
  ///Returns: True if the delete was successful.  False if something went wrong.
  Future<bool> deleteTransaction(Transaction transaction);
  Future<bool> createCategory(String categoryName);
  Future<bool> updateCategory(FinancialCategory category, newName);
  Future<bool> deleteCategory(FinancialCategory category);
}
