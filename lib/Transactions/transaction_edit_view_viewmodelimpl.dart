import 'package:flutter/foundation.dart';
import 'package:money_tracker/DataCentral/financial_category_model.dart';
import 'package:money_tracker/Transactions/transaction_edit_view_viewModel.dart';
import 'package:money_tracker/services/category_service_abstract.dart';
import 'package:money_tracker/services/transaction_service_abstract.dart';
import '../DataCentral/transaction_model.dart';
import '../Utils/DateUtils/date_picker_params.dart';

class TransactionEditViewViewModelImpl implements TransactionEditViewViewModel {
  @override
  Transaction transaction;
  @override
  CategoryService categoryService;
  @override
  TransactionService transactionService;

  TransactionEditViewViewModelImpl(this.transaction, this.categoryService, this.transactionService);

  List<FinancialCategory> _categories = [];
  List<FinancialCategory> _suggestedCategories = [];

  @override
  List<FinancialCategory> get allCategories => _categories;

  @override
  List<FinancialCategory> get allSuggestions => _suggestedCategories;

    @override
  Future initialAction() async {
    _categories = await categoryService.getAllCategories();
  }

@override
  Future<bool> editTransaction(String categoryName, String cost, DateTime date, String extraNotes) async {
        FinancialCategory selectedCategory;

    double doubleCost = double.tryParse(cost) ?? -1;
    if (doubleCost <= 0) {
      return false;
    }
    List<FinancialCategory> categories =
        _categories.where((element) => element.name == categoryName).toList();
    if (categories.length != 1) { //If there's more than 1 filtered category, we make a new one
      int tag = await categoryService.createCategory(categoryName);
      if (tag != -1) {
        selectedCategory = FinancialCategory(tag, categoryName);
      } else {
        if (kDebugMode) {
          print("Failed to make category");
        }
        return false;
      }
    } else {
      selectedCategory = categories[0]; //There will only be 1 filtered category
    }

    transaction.editCategory(selectedCategory);
    transaction.editCost(doubleCost);
    transaction.editDate(date);
    transaction.editNotes(extraNotes);

    await transactionService.updateTransaction(transaction);
    return true;
  }

  @override
  void updateSuggestions(String userInput) {
    _suggestedCategories = _categories.where((element) {
      return element.name.contains(userInput);
    }).toList();
  }

    // Date Picker Implementations
  @override
  DatePickerParams getPickerDates() {
    final today = DateTime.now();
    final firstDate = DateTime(today.year - 1);
    return DatePickerParams(firstDate, today, transaction.getDate());
  }
}