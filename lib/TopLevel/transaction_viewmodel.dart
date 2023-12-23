import 'package:money_tracker/services/category_service_abstract.dart';

import '../DataCentral/transaction_model.dart';
import '../services/transaction_service_abstract.dart';

abstract class TransactionViewModel {

  List<Transaction> getTransactions();
  void createTransaction(String categoryName, String cost, DateTime time, String extraNotes);
  void editTransaction(String categoryName, String cost, DateTime date, String extraNotes, Transaction transaction);
  void deleteTransaction(Transaction transaction);
}