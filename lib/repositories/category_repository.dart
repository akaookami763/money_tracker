import 'package:sqflite/sqflite.dart';

import '../DataCentral/financial_category_model.dart';
import '../services/database_helper.dart';
import 'category_repository_abstract.dart';

class FinancialCategoryRepositoryImpl extends FinancialCategoryRepository {
  /// Create a category in the database
  /// Returns: The unique key hash of the category if a success, or -1 if there is a failure
  @override
  Future<int> createCategory(String name) async {
    Database database = await DatabaseHelper.instance.database;
        Map<String, dynamic> row = {
      'name': name,
    };
    return await database.insert('categories', row);
  }

  @override
  Future<List<FinancialCategory>> getAllCategories() async {
        Database database = await DatabaseHelper.instance.database;
       final allRows = await database.query('categories');

       return allRows.map((e) {
        return FinancialCategory.fromMap(e);
       }).toList();
  }

  @override
  Future<FinancialCategory> getCategoryByTag(int tag) async {
    Database database = await DatabaseHelper.instance.database;

    List<String> columns = ['tag', 'name'];
    String whereString = 'tag = ?';
    final Map<String, dynamic> category = (await database.query('categories', columns: columns, where: whereString, whereArgs: [tag])) as Map<String, dynamic>;

    return FinancialCategory.fromMap(category);
  }

  @override
  Future<FinancialCategory> getCategoryByName(String name) async  {
        Database database = await DatabaseHelper.instance.database;

    List<String> columns = ['tag', 'name'];
    String whereString = 'tag = ?';
    final Map<String, dynamic> category = (await database.query('categories', columns: columns, where: whereString, whereArgs: [name])) as Map<String, dynamic>;

    return FinancialCategory.fromMap(category);
  }

  @override
  Future<int> removeCategory(FinancialCategory category) async {
    Database database = await DatabaseHelper.instance.database;

    return database.delete('categories', where: 'tag = ?', whereArgs: [category.tag]);
  }

}
