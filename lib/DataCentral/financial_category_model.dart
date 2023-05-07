import 'package:flutter/material.dart';

class FinancialCategory {
  final int tag;
  final String name;

  FinancialCategory(this.tag, this.name);

  @override
  bool operator == (other) {
    if(other is! FinancialCategory) return false;
    return other.tag == tag && other.name == name;
  }

  @override
  int get hashCode => name.hashCode ^ tag.hashCode;

  FinancialCategory.fromMap(Map<String, dynamic> res)
      : tag = res['tag'],
        name = res['name'];
}
