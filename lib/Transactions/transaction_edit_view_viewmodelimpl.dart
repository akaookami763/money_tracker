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