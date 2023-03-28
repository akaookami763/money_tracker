import 'package:flutter/material.dart';

class FinancialCategory {
  final UniqueKey tag;
  final String name;

  FinancialCategory(this.name) : tag = UniqueKey();

  FinancialCategory.fromMap(Map<String, dynamic> res)
      : tag = res['tag'],
        name = res['name'];
}
