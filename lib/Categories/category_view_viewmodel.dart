import 'package:flutter/foundation.dart';
import 'package:money_tracker/DataCentral/financial_category_model.dart';
import 'package:money_tracker/services/category_service_abstract.dart';
import 'package:money_tracker/services/transaction_service.dart';

import '../DataCentral/transaction_model.dart';
import '../services/category_service.dart';
import '../services/transaction_service_abstract.dart';

class CategoryViewViewModel extends ChangeNotifier {
  List<Transaction> _transactions = [];
  final FinancialCategory _category;

CategoryViewViewModel(this._category);
  //TODO: Change to real data once everything is implemented
  CategoryService worker = CategoryWorker(); // CategoryServiceMock();
  TransactionService tWorker = TransactionWorker(); //TransactionServiceMock();

  List<Transaction> get transactions => _transactions;
  FinancialCategory get category => _category;

  Future<void> initialActions() async {
    _transactions = await tWorker.getAllTransactionsFor(category);
  }

  void costIncrease(String cost, DateTime date,
      String extraNotes) async {
    double doubleCost = double.parse(cost);
    if (doubleCost <= 0) {
      return;
    }

    _transactions = await tWorker.addTransaction(
        _category.tag, date, doubleCost, extraNotes);

    updateSum();
    monthlySum();

    notifyListeners();
  }

  void costDecrease(String category, String cost, DateTime date,
      String extraNotes) async {
    double doubleCost = double.parse(cost);
    if (doubleCost <= 0) {
      return;
    }

    _transactions = await tWorker.addTransaction(
        _category.tag, date, doubleCost * -1, extraNotes);

    updateSum();
    monthlySum();

    notifyListeners();
  }

  double updateSum() {
    return _transactions
        .map((e) => e.getCost())
        .reduce((value, element) => value + element);
  }

  double monthlySum() {
    int currentMonth = DateTime.now().month;
    List<Transaction> monthlyTransactions = transactions
        .where((transaction) => transaction.getDate().month == currentMonth)
        .toList();

    return monthlyTransactions
        .map((e) => e.getCost())
        .reduce((value, element) => value + element);
  }
}
