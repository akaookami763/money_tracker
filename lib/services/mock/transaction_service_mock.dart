import 'package:money_tracker/mocks/transaction_repository_mock_impl.dart';

import '../../DataCentral/financial_category_model.dart';
import '../../DataCentral/transaction_model.dart';
import '../../repositories/transaction_repository_abstract.dart';
import '../transaction_service_abstract.dart';

class TransactionServiceMock extends TransactionService {
  TransactionRepository repo = TransactionRepositoryMockImpl();

  @override
  Future<List<Transaction>> getAllTransactions() {
    return Future(() => repo.getAllTransactions());
  }

  @override
  Future<List<Transaction>> getAllTransactionsFor(FinancialCategory category) {
    return repo.getAllTransactionsFor(category);
  }

  @override
  Future<int> addTransaction(int category, DateTime date, double cost, String extraNotes) async {
    return await repo.createTransaction(category, date, cost, extraNotes);
  }

  @override
  Future<Transaction> updateTransaction(Transaction transaction) {
    // TODO: implement updateTransaction
    throw UnimplementedError();
  }

  @override
  Future<Transaction> deleteTransaction(Transaction transaction) {
    // TODO: implement deleteTransaction
    throw UnimplementedError();
  }
  
  @override
  Future<FinancialCategory?> createCategory(String categoryName) {
    // TODO: implement createCategory
    throw UnimplementedError();
  }
  
  @override
  Future<FinancialCategory?> findCategory(String categoryName) {
    // TODO: implement findCategory
    throw UnimplementedError();
  }
}