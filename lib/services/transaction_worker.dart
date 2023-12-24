import 'package:mockito/annotations.dart';
import 'package:money_tracker/DataCentral/financial_category_model.dart';
import 'package:money_tracker/DataCentral/transaction_model.dart';
import 'package:money_tracker/repositories/category_repository_abstract.dart';
import 'package:money_tracker/repositories/transaction_repository.dart';
import 'package:money_tracker/repositories/transaction_repository_abstract.dart';
import 'package:money_tracker/services/transaction_service_abstract.dart';

import '../repositories/category_repository.dart';

class TransactionWorker extends TransactionService {
  TransactionRepository _repository = TransactionRepositoryImpl();
  FinancialCategoryRepository categoryRepository =
      FinancialCategoryRepositoryImpl();

  TransactionWorker(this._repository);
  /// Create a transaction in the database
  /// Returns: True if it was added.  False if creation failed
  @override
  Future<bool> addTransaction(
      int category, DateTime date, double cost, String extraNotes) async {
    int success = await _repository.createTransaction(category, date, cost, extraNotes);
    return success != 0 ? true : false;

  }

  @override
  Future<bool> updateTransaction(Transaction transaction) async {
    int success = await _repository.updateTransaction(transaction);
    return success == 1 ? true : false;
  }

  @override
  Future<bool> deleteTransaction(Transaction transaction) async {
    int success = await _repository.removeTransaction(transaction);
    return success == 1 ? true : false;
  }

  @override
  Future<List<Transaction>> getAllTransactions() async {
    return _repository.getAllTransactions();
  }

  @override
  Future<List<Transaction>> getAllTransactionsFor(FinancialCategory category) async {
    List<Transaction> transactions = await _repository.getAllTransactions();

    return transactions.where((element) => 
      element.getCategory() == category
    ).toList();
  }

  Future<bool> createCategory(String categoryName) async {
    int success = await categoryRepository.createCategory(categoryName);
    return success != 0 ? true : false;
  }

  Future<FinancialCategory?> findCategory(String categoryName) async {
    return await categoryRepository.getCategoryByName(categoryName);
  }
}
