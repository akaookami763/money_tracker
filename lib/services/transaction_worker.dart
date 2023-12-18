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

  @override
  Future<int> addTransaction(
      int category, DateTime date, double cost, String extraNotes) async {
    return _repository.createTransaction(category, date, cost, extraNotes);
  }

  @override
  Future<Transaction> updateTransaction(Transaction transaction) async {
    final int success = await _repository.updateTransaction(transaction);
    if (success == 1) {
      return transaction;
    } else {
      print(success);
      throw Error();
    }
  }

  @override
  Future<Transaction> deleteTransaction(Transaction transaction) async {
    final int success = await _repository.removeTransaction(transaction);
    if (success == 1) {
      return transaction;
    } else {
      throw Error();
    }
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

  Future<FinancialCategory?> createCategory(String categoryName) async {
    int success = await categoryRepository.createCategory(categoryName);
    if (success == 0) {
      return null;
    }
    return findCategory(categoryName);
  }

  Future<FinancialCategory?> findCategory(String categoryName) async {
    return await categoryRepository.getCategoryByName(categoryName);
  }
}
