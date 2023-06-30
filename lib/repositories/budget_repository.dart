import 'package:money_tracker/DataCentral/budget_model.dart';
import 'package:money_tracker/repositories/budget_repository_abstract.dart';
import 'package:money_tracker/services/database_helper.dart';
import 'package:sqflite/sqflite.dart';

class BudgetCategoryRepositoryImpl implements BudgetCategoryRepository {
  @override
  Future<int> createBudgetCategory(String title) async {
    Database db = await DatabaseHelper.instance.database;
    Map<String, dynamic> row = {
      'title': title,
    };

    int result = await db.insert('budget', row);
    if(result == 0) {
      throw Error();
    }
    return result;
  }

  @override
  Future<int> deleteBudgetCategory(BudgetCategory category) async {
    Database db = await DatabaseHelper.instance.database;

    int result = await db.delete('budget', where: 'tag = ?', whereArgs: [category.tag]);
    if(result != 1) {
      throw Error();
    }
    return result;
  }

  @override
  Future<int> updateBudgetCategory(BudgetCategory category) async {
    Database db = await DatabaseHelper.instance.database;
    Map<String, dynamic> row = {
      'cost': category.cost
    };

    int result = await db.update('budget', row, where: 'tag = ?', whereArgs: [category.tag]);
    if(result != 1) {
      throw Error();
    }
    return result;
  }

}