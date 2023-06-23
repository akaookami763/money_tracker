import 'package:flutter/material.dart';
import 'package:money_tracker/DataCentral/financial_category_model.dart';

class CategoryNameView extends StatelessWidget {
  final String name;
  final Function(String) onTap;

  CategoryNameView(this.name, this.onTap);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(child: Container(
      margin: EdgeInsets.fromLTRB(8, 4, 8, 4),
      decoration: BoxDecoration(
        border: Border.all(
          width: 5,
          color: Colors.purple
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(children: [
        Text(name),
      ],
      mainAxisAlignment: MainAxisAlignment.center,
    )
    ),
    onTap: () {
      onTap(name);
    },);
  }
}
