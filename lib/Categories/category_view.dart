import 'package:flutter/material.dart';
import 'package:money_tracker/DataCentral/financial_category_model.dart';

class CategoryView extends StatelessWidget {
  final FinancialCategory category;
  final double cost;
  final Function(FinancialCategory) onTap;

  CategoryView(this.category, this.cost, this.onTap);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(child: Column(
      children: [
        Text(category.name),
        Text(cost.toStringAsFixed(2))
      ],
    ),
    onTap: () {
      onTap(category);
    },);
  }
}
