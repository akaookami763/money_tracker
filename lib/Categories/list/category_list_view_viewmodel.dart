import 'package:money_tracker/Categories/list/category_list_view_viewmodel_abstract.dart';
import 'package:money_tracker/DataCentral/financial_category_model.dart';
import 'package:money_tracker/DataCentral/transaction_model.dart';
import 'package:money_tracker/Utils/DateUtils/date_picker_params.dart';
import 'package:money_tracker/services/category_service_abstract.dart';
import 'package:money_tracker/services/transaction_service_abstract.dart';

enum CategoryListViewState {
  loading,
  error,
  idle,
}

class CategoryListViewViewModelImpl extends CategoryListViewViewModel {
  Map<FinancialCategory, double> _presentableCategories = {};
  List<Transaction> _transactions;
  DateTime currentDate = DateTime.now();
  CategoryListViewState viewState = CategoryListViewState.loading;

  TransactionService _transactionService;
  CategoryService _categoryService;

  CategoryListViewViewModelImpl(
      this._categoryService, this._transactionService, this._transactions);

  @override
  Future initialAction() async {
    viewState = CategoryListViewState.loading;
    await _setCategories();
    await _setTransactions();
    viewState = CategoryListViewState.idle;
  }

  @override
  Future removeCategory(String categoryName) {
    // TODO: implement removeCategory
    throw UnimplementedError();
  }

  @override
  Map<FinancialCategory, double> categories() {
    return _presentableCategories;
  }

  @override
  void updateCategories(List<FinancialCategory> list) {
    _convertCategoriesToViewableCategories(list);
  }

  @override
  Map<FinancialCategory, double> filterSuggestedCategories(String userInput) {
    if (userInput.isEmpty) {
      return _presentableCategories;
    }
    Map<FinancialCategory, double> filteredMap = {
      for (final key in _presentableCategories.keys)
        if (key.name.contains(userInput))
          key: _presentableCategories[
              key]! // TODO: Refactor to avoid force unwrapping
    };
    return filteredMap;
  }

  Future _setCategories() async {
    List<FinancialCategory> categories =
        await _categoryService.getAllCategories();
    _presentableCategories =
        await _convertCategoriesToViewableCategories(categories);
  }

  Future _setTransactions() async {
    _transactions = await _transactionService.getAllTransactions();
  }

  @override
  void setCategoriesFromList(List<FinancialCategory> list) async {
    _presentableCategories = await _convertCategoriesToViewableCategories(list);
  }

  Future<Map<FinancialCategory, double>> _convertCategoriesToViewableCategories(
      List<FinancialCategory> list) async {
    for (FinancialCategory category in list) {
      List<Transaction> transactions =
          await _transactionService.getAllTransactionsFor(category);
      if (transactions.isEmpty) {
        continue;
      }
      double cost = transactions
          .map((e) => e.getCost())
          .reduce((value, element) => value + element);

      _presentableCategories.update(category, (value) => cost, ifAbsent: () => cost);
    }
    return _presentableCategories;
  }

  // Date Picker Implementations

  DatePickerParams getPickerDates() {
    final today = DateTime.now();
    final firstDate = DateTime(today.year - 1);
    return DatePickerParams(firstDate, today, currentDate);
  }
}

// class CategoryListViewViewModelImpl extends CategoryListViewViewModel {
//   List<FinancialCategory> _categories = [];
//   DateTime currentDate = DateTime.now();

//   @override
//   // TODO: implement notes
//   String get notes => super.notes;
//   @override
//   List<FinancialCategory> get allCategories => _categories;

//   final Map<FinancialCategory, double> _suggestions = {};
//   Map<FinancialCategory, double> _updatedSuggestions = {};

//   Map<FinancialCategory, double> get allSuggestions => _updatedSuggestions;

//   final CategoryService _cWorker;

//   final TransactionService _tWorker;

//   CategoryListViewViewModelImpl(this._cWorker, this._tWorker);

//   @override
//   Future initialAction() async {
//     _categories = await _cWorker.getAllCategories();
//     _setSuggestions();

//   }

//   @override
//   Future removeCategory(String categoryName) {
//     // TODO: implement removeCategory
//     throw UnimplementedError();
//   }

//   @override
//   void updateSuggestions(String userInput) {
//     _updatedSuggestions = Map<FinancialCategory, double>.from(_suggestions);
//     _updatedSuggestions.removeWhere((key, value) {
//       return !key.name.toLowerCase().contains(userInput.toLowerCase());
//     });
//   }

//   void _updateSuggestionsWithTransaction(
//       FinancialCategory category, double cost, bool isNewCategory) {
//     if (isNewCategory) {
//       _suggestions.addAll(<FinancialCategory, double>{category: cost});
//       _updatedSuggestions.addAll(<FinancialCategory, double>{category: cost});
//       return;
//     }
//     _suggestions.update(category, (value) {
//       return value + cost;
//     });
//     _updatedSuggestions.update(category, (value) {
//       return value + cost;
//     });
//   }

//   void updateAllCategories(List<FinancialCategory> list) {
//     _categories = list;
//     _setSuggestions();
    
//   }

//   void _setSuggestions() async {
//         for (FinancialCategory category in _categories) {
//       List<Transaction> filteredTransactions = await _tWorker.getAllTransactionsFor(category);
//       if(filteredTransactions.isEmpty) { // TODO: Find general place to put this logic.  Shouldn't depend on viewModel level
//         _cWorker.removeCategory(category);
//         continue;
//       }
//       double cost = filteredTransactions
//           .map((e) => e.getCost())
//           .reduce((value, element) => value + element);
//       _suggestions.addAll(<FinancialCategory, double>{category: cost});
//       _updatedSuggestions.addAll(<FinancialCategory, double>{category: cost});
//     }
//   }
// }
