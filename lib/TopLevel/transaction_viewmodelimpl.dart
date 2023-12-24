import 'package:flutter/material.dart';
import 'package:money_tracker/DataCentral/transaction_model.dart';

import 'package:money_tracker/TopLevel/transaction_viewmodel.dart';
import 'package:money_tracker/services/category_service_abstract.dart';
import 'package:money_tracker/services/transaction_service_abstract.dart';

import '../DataCentral/financial_category_model.dart';

class TransactionViewModelImpl extends ChangeNotifier
    implements TransactionViewModel {
  List<Transaction> _transactions = [];
  List<FinancialCategory> _categories = [];
  final TransactionService _transactionService;
  final CategoryService _categoryService;

  TransactionViewModelImpl(this._transactionService, this._categoryService) {
    _updateTransactions();
  }

  @override
  List<Transaction> getTransactions() {
    return _transactions;
  }

  @override
  Future<bool> addTransaction(String categoryName, String cost, DateTime time,
      String extraNotes) async {
    double doubleCost = double.tryParse(cost) ?? -1;
    if (doubleCost <= 0) {
      return false;
    }

    // Get the category used
    FinancialCategory? selectedCategory =
        await _categoryService.getCategoryByName(categoryName);
    bool success;
    // If this is a new category, make it and use it's tag to make the transaction
    if (selectedCategory == null) {
      success = await _categoryService.createCategory(categoryName);
      if (success) {
        FinancialCategory? newCategory =
            await _categoryService.getCategoryByName(categoryName);
        if (newCategory != null) {
          success = await _transactionService.addTransaction(
              newCategory.tag, time, doubleCost, extraNotes);
        }
      }
    } else {
      success = await _transactionService.addTransaction(
          selectedCategory.tag, time, doubleCost, extraNotes);
    }
    if (success) {
      _updateTransactions();
    }
    return success;
  }

  @override
  Future<bool> deleteTransaction(Transaction transaction) async {
    bool success = await _transactionService.deleteTransaction(transaction);

    if (success) {
      _updateTransactions();
    }
    return success;
  }

  @override
  Future<bool> editTransaction(String categoryName, String cost, DateTime date,
      String extraNotes, Transaction transaction) async {
    double doubleCost = double.tryParse(cost) ?? -1;
    if (doubleCost <= 0) {
      return false; // TODO: Change this function to pass an error for bad parsing
    }
    FinancialCategory? selectedCategory =
        await _categoryService.getCategoryByName(categoryName);

    if (selectedCategory == null) {
      return false;
    }

    Transaction updatedTransaction = Transaction(
        tag: transaction.getTag(),
        category: selectedCategory,
        date: date,
        cost: doubleCost,
        extraNotes: extraNotes);

    bool success =
        await _transactionService.updateTransaction(updatedTransaction);

    if (success) {
      _updateTransactions();
    }
    return success;
  }

  @override
  List<FinancialCategory> getCategories() {
    return _categories;
  }

  @override
  Future<bool> createCategory(String categoryName) async {
    bool success = await _categoryService.createCategory(categoryName);
    if (success) {
      _updateTransactions();
    }
    return success;
  }

  @override
  Future<bool> deleteCategory(FinancialCategory category) async {
    bool success = await _categoryService.removeCategory(category);
    if (success) {
      _updateTransactions();
    }
    return success;
  }

  @override
  Future<bool> updateCategory(FinancialCategory category, newName) async {
    bool success = await _categoryService.updateCategory(category.tag, newName);
    if (success) {
      _updateTransactions();
    }
    return success;
  }

  // MARK: Class Functions

  void _updateTransactions() async {
    _transactions = await _transactionService.getAllTransactions();
    _categories = await _categoryService.getAllCategories();
    notifyListeners();
  }
}
