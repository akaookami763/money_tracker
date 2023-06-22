import '../DataCentral/financial_category_model.dart';
import '../DataCentral/transaction_model.dart';

abstract class CategoryListViewViewModel {
  final List<FinancialCategory> allCategories = [];
  final List<Transaction> recentTransactions = [];
  final Map<FinancialCategory, double> allSuggestions = {};
  String notes = "";

  Future initialAction();
  void updateSuggestions(String userInput);
  Future addTransaction(String userInput, String amount);
  Future removeCategory(String categoryName);
}