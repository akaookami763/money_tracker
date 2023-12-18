import 'package:sqflite/sqflite.dart';

import '../DataCentral/financial_category_model.dart';
import '../services/database_helper.dart';
import 'category_repository_abstract.dart';

class FinancialCategoryRepositoryImpl extends FinancialCategoryRepository {

  final String CATEGORY_TABLE = 'categories';
  final String TAG_FIELD = 'tag';
  final String NAME_FIELD = 'name';

  /// Create a category in the database
  /// Returns: The unique key hash of the category if a success, or 0 if there is a failure
  @override
  Future<int> createCategory(String name) async {
    Database database = await DatabaseHelper.instance.database;
    Map<String, dynamic> row = {
      NAME_FIELD: name,
    };
    return await database.insert(CATEGORY_TABLE, row);
  }

  @override
  Future<int> updateCategoryByName(int tag, String name) async {
    Database database = await DatabaseHelper.instance.database;
    Map<String, dynamic> row = {
      NAME_FIELD: name,
    };
    return await database.update(CATEGORY_TABLE, row, where: '$TAG_FIELD = ?', whereArgs: [tag]);
  }

  @override
  Future<int> removeCategory(FinancialCategory category) async {
    Database database = await DatabaseHelper.instance.database;

    return database
        .delete(CATEGORY_TABLE, where: '$TAG_FIELD = ?', whereArgs: [category.tag]);
  }

  @override
  Future<List<FinancialCategory>> getAllCategories() async {
    Database database = await DatabaseHelper.instance.database;
    final allRows = await database.query(CATEGORY_TABLE);

    return allRows.map((e) {
      return FinancialCategory.fromMap(e);
    }).toList();
  }

  @override
  Future<FinancialCategory?> getCategoryByTag(int tag) async {
    Database database = await DatabaseHelper.instance.database;

    List<String> columns = [TAG_FIELD, NAME_FIELD];
    String whereString = '$TAG_FIELD = ?';
    final Map<String, dynamic> category = (await database.query(CATEGORY_TABLE,
        columns: columns,
        where: whereString,
        whereArgs: [tag])) as Map<String, dynamic>;

    if (category.isEmpty) {
      return null;
    } else {
      return FinancialCategory.fromMap(category);
    }
  }

  @override
  Future<FinancialCategory?> getCategoryByName(String name) async {
    Database database = await DatabaseHelper.instance.database;

    List<String> columns = [TAG_FIELD, NAME_FIELD];
    String whereString = '$NAME_FIELD = ?';
    final List<Map<String, dynamic>> category = await database.query(
        CATEGORY_TABLE,
        columns: columns,
        where: whereString,
        whereArgs: [name]);

    if (category.isEmpty) {
      return null;
    } else {
      return FinancialCategory.fromMap(category[0]);
    }
  }
}
