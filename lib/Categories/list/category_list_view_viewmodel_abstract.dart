
import 'package:money_tracker/DataCentral/financial_category_model.dart';
import 'package:money_tracker/DataCentral/transaction_model.dart';

enum CategoryListViewState {
  loading,
  error,
  idle,
}

abstract class CategoryListViewViewModel {
  late DateTime currentDate;
  late CategoryListViewState viewState;
  late Map<FinancialCategory, double> categories;
  Map<FinancialCategory, double> getSuggestedCategories(String userInput);
  void updateCategories(List<FinancialCategory> list, List<Transaction> transactions);
  Future removeCategory(String categoryName);
}