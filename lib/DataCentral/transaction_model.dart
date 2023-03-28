import 'package:flutter/material.dart';

import 'financial_category_model.dart';

/// A transaction object contains information of a user entered transaction they have performed.  It is editable with setters
class Transaction {
  late final UniqueKey _tag;
  late FinancialCategory _category;
  late DateTime _date;
  late double _cost;
  late String _extraNotes;

  Transaction(
      {required FinancialCategory category,
      required DateTime date,
      required double cost,
      required String extraNotes}) {
    this._category = category;
    this._date = date;
    this._cost = cost;
    this._extraNotes = extraNotes;

    this._tag = UniqueKey();
  }

  Transaction.fromMap(Map<String, dynamic> res)
      : _tag = res['tag'],
        _cost = res['cost'],
        _category = res['category'],
        _extraNotes = res['extraNotes'],
        _date = res['date'];

  UniqueKey getTag() {
    return this._tag;
  }

  FinancialCategory getCategory() {
    return this._category;
  }

  String getCategoryName() {
    return this._category.name;
  }

  DateTime getDate() {
    return this._date;
  }

  double getCost() {
    return this._cost;
  }

  String getNotes() {
    return this._extraNotes;
  }

  void editNotes(String notes) {
    this._extraNotes = notes;
  }

  void editDate(DateTime date) {
    this._date = date;
  }

  void editCategory(FinancialCategory category) {
    this._category = category;
  }

  void editCost(double cost) {
    this._cost = cost;
  }
}
