import 'package:money_tracker/DataCentral/financial_category_model.dart';
import 'package:money_tracker/DataCentral/transaction_model.dart';
import 'package:money_tracker/services/category_service_abstract.dart';
import 'package:money_tracker/services/transaction_service_abstract.dart';

abstract class CategoryListViewViewModel {
  final List<FinancialCategory> allCategories = [];
  final Map<FinancialCategory, double> allSuggestions = {};

  Future initialAction();
  void updateSuggestions(String userInput);
  void addTransaction(String userInput, String amount);
}

class CategoryListViewViewModelImpl extends CategoryListViewViewModel {
  List<FinancialCategory> _categories = [];

  List<FinancialCategory> get allCategories => _categories;

  final Map<FinancialCategory, double> _suggestions = {};
  Map<FinancialCategory, double> _updatedSuggestions = {};

  Map<FinancialCategory, double> get allSuggestions => _updatedSuggestions;

  late CategoryService _cWorker;

  late TransactionService _tWorker;

  CategoryListViewViewModelImpl(this._cWorker, this._tWorker);

  @override
  Future initialAction() async {
    _categories = await _cWorker.getAllCategories();
    List<Transaction> transactions = await _tWorker.getAllTransactions();
    for (FinancialCategory category in _categories) {
      List<Transaction> filteredTransactions = transactions.where((element) {
        return element.getCategory() == category;
      }).toList();
      double cost = filteredTransactions
          .map((e) => e.getCost())
          .reduce((value, element) => value + element);
      _suggestions.addAll(<FinancialCategory, double>{category: cost});
      _updatedSuggestions.addAll(<FinancialCategory, double>{category: cost});
    }
  }

  @override
  void addTransaction(String userInput, String amount) async {
    FinancialCategory selectedCategory;

    double doubleCost = double.parse(amount);
    if (doubleCost <= 0) {
      return;
    }

    List<FinancialCategory> categories =
        _categories.where((element) => element.name == userInput).toList();
    if (categories.length != 1) {
      selectedCategory = FinancialCategory(userInput);
    } else {
      selectedCategory = categories[0];
    }

    //TODO: Add extraNotes to the UI
    Transaction newTransaction = Transaction(
        category: selectedCategory,
        date: DateTime.now(),
        cost: doubleCost,
        extraNotes: "");

    await _tWorker.addTransaction(newTransaction);
    _categories = await _cWorker.getAllCategories();
  }

  @override
  void updateSuggestions(String userInput) {
    _updatedSuggestions = Map<FinancialCategory, double>.from(_suggestions);
    _updatedSuggestions.removeWhere((key, value) {
      return !key.name.toLowerCase().contains(userInput.toLowerCase());
    });
  }
}
