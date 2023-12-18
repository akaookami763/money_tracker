import 'package:flutter/material.dart';
import 'package:money_tracker/DataCentral/transaction_model.dart';

import 'package:money_tracker/TopLevel/transaction_viewmodel.dart';
import 'package:money_tracker/services/category_service_abstract.dart';
import 'package:money_tracker/services/transaction_service_abstract.dart';

import '../DataCentral/financial_category_model.dart';

class TransactionViewModelImpl extends ChangeNotifier
    implements TransactionViewModel {
  final TransactionService _transactionService;
  final CategoryService _categoryService;

  TransactionViewModelImpl(this._transactionService, this._categoryService);

  @override
  void createTransaction(String categoryName, String cost, DateTime time,
      String extraNotes) async {
    double doubleCost = double.tryParse(cost) ?? -1;
    if (doubleCost <= 0) {
      return; // TODO: Change this function to pass an error for bad parsing
    }

    // Get the category used
    FinancialCategory? selectedCategory =
        await _categoryService.getCategoryByName(categoryName);

    // If this is a new category, make it and use it's tag to make the transaction
    if (selectedCategory == null) {
      int success = await _categoryService.createCategory(categoryName);
      if (success != 0) {
        FinancialCategory? newCategory =
            await _categoryService.getCategoryByName(categoryName);
        if (newCategory != null) {
          await _transactionService.addTransaction(
              newCategory.tag, time, doubleCost, extraNotes);
        }
      }
    } else {
      await _transactionService.addTransaction(
          selectedCategory.tag, time, doubleCost, extraNotes);
    }

    notifyListeners();
  }

  @override
  void deleteTransaction(Transaction transaction) async {
    await _transactionService.deleteTransaction(transaction);

    notifyListeners();
  }

  @override
  void editTransaction(String categoryName, String cost, DateTime date,
      String extraNotes, Transaction transaction) async {
    double doubleCost = double.tryParse(cost) ?? -1;
    if (doubleCost <= 0) {
      return; // TODO: Change this function to pass an error for bad parsing
    }
    FinancialCategory? selectedCategory =
        await _categoryService.getCategoryByName(categoryName);

    if (selectedCategory == null) {
      return;
    }

    Transaction updatedTransaction = Transaction(
        tag: transaction.getTag(),
        category: selectedCategory,
        date: date,
        cost: doubleCost,
        extraNotes: extraNotes);

    await _transactionService.updateTransaction(updatedTransaction);

    notifyListeners();
  }
}
