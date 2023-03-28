import 'package:money_tracker/DataCentral/financial_category_model.dart';
import 'package:money_tracker/services/category_service.dart';
import 'package:money_tracker/services/category_service_abstract.dart';

class CategoryListViewViewModel {
  List<FinancialCategory> _categories = [];
  List<FinancialCategory> _suggestions = [];

  List<String> get suggestions {
    return _suggestions.map((suggestion) {
      return suggestion.name;
    }).toList();
  }

  CategoryService worker = CategoryServiceMock();

  Future<bool> initialActions() async {
    _categories = await worker.getAllCategories();

    return true;
  }

  List<FinancialCategory> getCategories() {
    return _suggestions.isNotEmpty ? _suggestions : _categories;
  }

  void updateSuggestions(String userEntry) {
    _suggestions = _categories
        .where((category) => category.name.contains(userEntry))
        .toList();
  }
}
