import 'package:money_tracker/DataCentral/financial_category_model.dart';
import 'package:money_tracker/DataCentral/transaction_model.dart';
import 'package:money_tracker/repositories/transaction_repository_abstract.dart';

import '../mocks/transaction_list_mock.dart';

class TransactionRepositoryMock extends TransactionRepository {
  final List<Transaction> _mockDatabase = transactionListMock;

  @override
  Future<int> createTransaction(Transaction transaction) {
    return Future(() {
      _mockDatabase.add(transaction);
      return 1;
    });
  }

  @override
  Future<List<Transaction>> getAllTransactions() {
    return Future(() => _mockDatabase);
  }

  @override
  Future<List<Transaction>> getAllTransactionsFor(FinancialCategory category) {
    return Future(() => _mockDatabase.where((element) => element.getCategory() == category).toList());
  }

  @override
  Future<int> removeTransaction(Transaction transaction) {
    if (_mockDatabase.remove(transaction)) {
      return Future(() => 1);
    }
    return Future(() => 0);
  }
}
