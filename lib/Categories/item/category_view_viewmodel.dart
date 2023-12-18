import 'package:money_tracker/DataCentral/financial_category_model.dart';
import 'package:money_tracker/DataCentral/transaction_model.dart';
import 'package:money_tracker/repositories/transaction_repository.dart';
import 'package:money_tracker/services/transaction_service_abstract.dart';
import 'package:money_tracker/services/transaction_worker.dart';

class CategoryViewViewModel {
  final FinancialCategory _category;

CategoryViewViewModel(this._category);
  final TransactionService _transactionService = TransactionWorker(TransactionRepositoryImpl());

  FinancialCategory get category => _category;

  void costIncrease(String cost, DateTime date,
      String extraNotes) async {
    double doubleCost = double.parse(cost);
    if (doubleCost <= 0) {
      return;
    }

    int result = await _transactionService.addTransaction(
        _category.tag, date, doubleCost, extraNotes);

    if (result == 1) {
    List<Transaction> transactions = await _transactionService.getAllTransactions();
              updateSum(transactions);
    monthlySum(transactions);

    } else {
      //Handle error
    }

  }

  void costDecrease(String category, String cost, DateTime date,
      String extraNotes) async {
    double doubleCost = double.parse(cost);
    if (doubleCost <= 0) {
      return;
    }

    int result = await _transactionService.addTransaction(
        _category.tag, date, doubleCost, extraNotes);

    if (result == 1) {
    List<Transaction> transactions = await _transactionService.getAllTransactions();
              updateSum(transactions);
    monthlySum(transactions);

    } else {
      //Handle error
    }
  }

  double updateSum(List<Transaction> transactions) {
    return transactions
        .map((e) => e.getCost())
        .reduce((value, element) => value + element);
  }

  double monthlySum(List<Transaction> transactions) {
    int currentMonth = DateTime.now().month;
    List<Transaction> monthlyTransactions = transactions
        .where((transaction) => transaction.getDate().month == currentMonth)
        .toList();

    return monthlyTransactions
        .map((e) => e.getCost())
        .reduce((value, element) => value + element);
  }
}
