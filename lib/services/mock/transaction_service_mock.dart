import 'package:money_tracker/mocks/transaction_repository_mock_impl.dart';

import '../../DataCentral/financial_category_model.dart';
import '../../DataCentral/transaction_model.dart';
import '../../repositories/transaction_repository_abstract.dart';
import '../transaction_service_abstract.dart';

class TransactionServiceMock extends TransactionService {
  TransactionRepository repo = TransactionRepositoryMockImpl();

  @override
  Transaction createTransaction(FinancialCategory category, double cost,
      DateTime date, String extraNotes) {
    // TODO: implement createTransaction
    throw UnimplementedError();
  }

  @override
  Future<List<Transaction>> getAllTransactions() {
    return Future(() => repo.getAllTransactions());
  }

  @override
  Future<List<Transaction>> getAllTransactionsFor(FinancialCategory category) {
    return repo.getAllTransactionsFor(category);
  }

  @override
  Future<List<Transaction>> addTransaction(int category, DateTime date, double cost, String extraNotes) async {
    int result = await repo.createTransaction(category, date, cost, extraNotes);
    if (result == 1) {
      return repo.getAllTransactions();
    }
    return Future(() => []);
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
}