
import 'package:money_tracker/services/category_service_abstract.dart';
import 'package:money_tracker/services/transaction_service_abstract.dart';

import '../DataCentral/financial_category_model.dart';
import '../DataCentral/transaction_model.dart';
import '../Utils/DateUtils/date_picker_params.dart';

abstract class TransactionEditViewViewModel {
  final Transaction transaction;
  final List<FinancialCategory> allCategories = [];
  final List<FinancialCategory> allSuggestions = [];
  final CategoryService categoryService;
  final TransactionService transactionService;

  Future initialAction();
  void updateSuggestions(String userInput);
  DatePickerParams getPickerDates();


  TransactionEditViewViewModel(this.transaction, this.categoryService, this.transactionService);
}