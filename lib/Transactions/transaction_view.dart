import 'package:flutter/material.dart';
import 'package:money_tracker/DataCentral/transaction_model.dart';

class TransactionView extends StatelessWidget {
  final Transaction transaction;

  TransactionView(this.transaction);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Card(
        child: Row(
          children: [
            Column(
              children: [
                Text(transaction.getDate().toIso8601String()),
                Text(transaction.getCategoryName()),
              ],
            ),
            Text(transaction.getCost().toString()),
          ],
        ),
      ),
    );
  }
}
