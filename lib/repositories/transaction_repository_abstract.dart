import 'package:money_tracker/DataCentral/transaction_model.dart';

import '../DataCentral/financial_category_model.dart';

abstract class TransactionRepository {
  Future<List<Transaction>> getAllTransactions();
  Future<int> createTransaction(Transaction transaction);
  Future<int> removeTransaction(Transaction transaction);
}