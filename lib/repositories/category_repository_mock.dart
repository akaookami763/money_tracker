
import 'package:money_tracker/DataCentral/financial_category_model.dart';

import 'category_repository_abstract.dart';

class FinancialCategoryRepositoryMock extends FinancialCategoryRepository {

  final List<FinancialCategory> _mockDatabase = [
      FinancialCategory('Category1'),
      FinancialCategory('Category2'),
      FinancialCategory('Category3'),
      FinancialCategory('Category4')
    ];

  @override
  Future<int> createCategory(String name) {
    return Future(() {
      _mockDatabase.add(FinancialCategory(name));
      return 1;
    });
  }

  @override
  Future<List<FinancialCategory>> getAllCategories() {
    return  Future(() => _mockDatabase);
  }

  @override
  Future<int> removeCategory(FinancialCategory category) {
      return Future(() {
        if(_mockDatabase.remove(category)) {
        return 1;
        }
       return 0;
    });
  }

}