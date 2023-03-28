import 'package:money_tracker/DataCentral/financial_category_model.dart';

import '../DataCentral/transaction_model.dart';


abstract class TransactionService {
  Future<List<Transaction>> getAllTransactions();
  Future<List<Transaction>> addTransaction(Transaction transaction);
  Future<List<Transaction>> updateTransaction(Transaction transaction);
}