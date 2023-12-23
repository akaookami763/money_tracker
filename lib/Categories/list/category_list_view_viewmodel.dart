import 'package:money_tracker/Categories/list/category_list_view_viewmodel_abstract.dart';
import 'package:money_tracker/DataCentral/financial_category_model.dart';
import 'package:money_tracker/DataCentral/transaction_model.dart';

class CategoryListViewViewModelImpl extends CategoryListViewViewModel {


  CategoryListViewViewModelImpl() {
    categories = {};
    currentDate = DateTime.now();
    viewState = CategoryListViewState.idle;
  }

  // MARK: Abstract functions

  @override
  Future removeCategory(String categoryName) {
    // TODO: implement removeCategory
    throw UnimplementedError();
  }

  @override
  void updateCategories(List<FinancialCategory> list, List<Transaction> transactions) {
              print("SELFLOG: Taking top level state categories and converting them here");

    _convertCategoriesToViewableCategories(list, transactions);
  }

  @override
  Map<FinancialCategory, double> getSuggestedCategories(String userInput) {
    if (userInput.isEmpty) {
      return categories;
    }
    Map<FinancialCategory, double> filteredMap = {
      for (final key in categories.keys)
        if (key.name.contains(userInput))
          key: categories[
              key]! // TODO: Refactor to avoid force unwrapping
    };
    return filteredMap;
  }

  // MARK: Class functions

  Map<FinancialCategory, double> _convertCategoriesToViewableCategories(
      List<FinancialCategory> list, List<Transaction> transactions) {
    for (FinancialCategory category in list) {
      if (transactions.isEmpty) {
        continue;
      }
      List<Transaction> categoryTransactions = transactions.where((transaction) => category == transaction.getCategory()).toList();
      if(categoryTransactions.isEmpty) {
        continue; // This should never happen, but it is.  Need to find out why.  For some reason the database has extra categories like "test"
      }
      double cost = categoryTransactions
          .map((e) => e.getCost())
          .reduce((value, element) => value + element);

      categories.update(category, (value) => cost,
          ifAbsent: () => cost);
    }
    return categories;
  }

}
