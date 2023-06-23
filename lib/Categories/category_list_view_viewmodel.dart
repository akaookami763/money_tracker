import 'package:money_tracker/DataCentral/financial_category_model.dart';
import 'package:money_tracker/DataCentral/transaction_model.dart';
import 'package:money_tracker/services/category_service_abstract.dart';
import 'package:money_tracker/services/transaction_service_abstract.dart';
import '../Utils/DateUtils/date_picker_params.dart';
import 'category_list_view_viewmodel_abstract.dart';

class CategoryListViewViewModelImpl extends CategoryListViewViewModel {
  List<FinancialCategory> _categories = [];
  List<Transaction> _transactions = [];
  DateTime currentDate = DateTime.now();

  @override
  // TODO: implement notes
  String get notes => super.notes;
  @override
  List<FinancialCategory> get allCategories => _categories;
  @override
  List<Transaction> get recentTransactions =>
      _transactions.where((transaction) {
        return transaction.getDate().isAfter(
              DateTime.now().subtract(
                Duration(days: 7),
              ),
            );
      }).toList();

  final Map<FinancialCategory, double> _suggestions = {};
  Map<FinancialCategory, double> _updatedSuggestions = {};

  Map<FinancialCategory, double> get allSuggestions => _updatedSuggestions;

  final CategoryService _cWorker;

  final TransactionService _tWorker;

  CategoryListViewViewModelImpl(this._cWorker, this._tWorker);

  @override
  Future initialAction() async {
    _categories = await _cWorker.getAllCategories();
    _transactions = await _tWorker.getAllTransactions();
    for (FinancialCategory category in _categories) {
      List<Transaction> filteredTransactions = _transactions.where((element) {
        return element.getCategory().tag == category.tag;
      }).toList();
      if(filteredTransactions.isEmpty) { // TODO: Find general place to put this logic.  Shouldn't depend on viewModel level
        _cWorker.removeCategory(category);
        continue;
      }
      double cost = filteredTransactions
          .map((e) => e.getCost())
          .reduce((value, element) => value + element);
      _suggestions.addAll(<FinancialCategory, double>{category: cost});
      _updatedSuggestions.addAll(<FinancialCategory, double>{category: cost});
    }
  }

  @override
  Future addTransaction(String userInput, String amount) async {
    FinancialCategory selectedCategory;

    double doubleCost = double.tryParse(amount) ?? -1;
    if (doubleCost <= 0) {
      return;
    }
    bool newCategory = false;
    List<FinancialCategory> categories =
        _categories.where((element) => element.name == userInput).toList();
    if (categories.length != 1) { //If there's more than 1 filtered category, we make a new one
      newCategory = true;
      int tag = await _cWorker.createCategory(userInput);
      if (tag != -1) {
        selectedCategory = FinancialCategory(tag, userInput);
      } else {
        print("Failed to make category");
        return;
      }
    } else {
      selectedCategory = categories[0]; //There will only be 1 filtered category
    }

    await _tWorker.addTransaction(
        selectedCategory.tag, currentDate, doubleCost, notes);
    _categories = await _cWorker.getAllCategories();

    //Reset the date after adding a transaction
    currentDate = DateTime.now();

    _updateSuggestionsWithTransaction(
        selectedCategory, doubleCost, newCategory);
  }

  @override
  Future removeCategory(String categoryName) {
    // TODO: implement removeCategory
    throw UnimplementedError();
  }

  @override
  void updateSuggestions(String userInput) {
    _updatedSuggestions = Map<FinancialCategory, double>.from(_suggestions);
    _updatedSuggestions.removeWhere((key, value) {
      return !key.name.toLowerCase().contains(userInput.toLowerCase());
    });
  }

  void _updateSuggestionsWithTransaction(
      FinancialCategory category, double cost, bool isNewCategory) {
    if (isNewCategory) {
      _suggestions.addAll(<FinancialCategory, double>{category: cost});
      _updatedSuggestions.addAll(<FinancialCategory, double>{category: cost});
      return;
    }
    _suggestions.update(category, (value) {
      return value + cost;
    });
    _updatedSuggestions.update(category, (value) {
      return value + cost;
    });
  }

  // Date Picker Implementations

  DatePickerParams getPickerDates() {
    final today = DateTime.now();
    final firstDate = DateTime(today.year - 1);
    return DatePickerParams(firstDate, today, currentDate);
  }
}
