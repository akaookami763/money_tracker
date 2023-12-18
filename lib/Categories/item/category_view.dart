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
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(boxShadow:[BoxShadow(spreadRadius: 1, blurRadius: 10, blurStyle: BlurStyle.solid)] , borderRadius: BorderRadius.circular(3), color: Colors.purple),
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Text(category.name, style: TextStyle(color: Color.fromARGB(255, 226, 224, 224), fontSize: 12),),
        Text(cost.toStringAsFixed(2), style: TextStyle(color: Color.fromARGB(255, 226, 224, 224), fontSize: 12),)
      ],
    )
    ),
    onTap: () {
      onTap(category);
    },);
  }
}
