import 'package:money_tracker/DataCentral/financial_category_model.dart';
import 'package:money_tracker/DataCentral/transaction_model.dart';
import 'package:money_tracker/repositories/transaction_repository.dart';
import 'package:money_tracker/repositories/transaction_repository_abstract.dart';
import 'package:money_tracker/services/transaction_service_abstract.dart';
import 'package:sqflite/sqflite.dart' hide Transaction;
import 'database_helper.dart';

class TransactionWorker extends TransactionService {
  TransactionRepository repository = TransactionRepositoryImpl();

  @override
  Future<List<Transaction>> addTransaction(
      int category, DateTime date, double cost, String extraNotes) async {
    final int = repository.createTransaction(category, date, cost, extraNotes);

    return getAllTransactions();
  }

  @override
  Future<List<Transaction>> getAllTransactions() async {
    return repository.getAllTransactions();
  }

  @override
  Future<List<Transaction>> getAllTransactionsFor(FinancialCategory category) {
    // TODO: implement getAllTransactionsFor
    throw UnimplementedError();
  }

  @override
  Future<Transaction> updateTransaction(Transaction transaction) async {
    final int success = await repository.updateTransaction(transaction);
    if (success == 1) {
      return transaction;
    } else {
      print(success);
      throw Error();
    }
  }

  @override
  Future<Transaction> deleteTransaction(Transaction transaction) async {
    final int success = await repository.removeTransaction(transaction);
    if (success == 1) {
      return transaction;
    } else {
      throw Error();
    }
  }
}
