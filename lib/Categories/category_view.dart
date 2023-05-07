import 'package:flutter/material.dart';
import 'package:money_tracker/DataCentral/financial_category_model.dart';

class CategoryView extends StatelessWidget {
  final FinancialCategory category;
  final double cost;
  final Function(FinancialCategory) onTap;

  CategoryView(this.category, this.cost, this.onTap);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(child: Container(
      margin: EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(
          width: 5,
          color: Colors.purple
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(children: [
        Text(category.name),
        Text(cost.toStringAsFixed(2))
      ],
      mainAxisAlignment: MainAxisAlignment.center,
    )
    ),
    onTap: () {
      onTap(category);
    },);
  }
}
