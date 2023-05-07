import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:money_tracker/DataCentral/transaction_model.dart';
import 'package:money_tracker/History/chart_bar.dart';

class ChartData {
  final String day;
  final double amount;

  ChartData(this.day, this.amount);
}

class WeeklyChart extends StatelessWidget {
  final List<Transaction> weeklyTransactions;

  const WeeklyChart(this.weeklyTransactions);

  List<ChartData> get groupedTransactionValues {
    if (weeklyTransactions.isEmpty) {
      return [];
    }
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));

      Iterable<Transaction> allTransactions =
          weeklyTransactions.where((transaction) {
        return transaction.getDate().day == weekDay.day;
      });
      Iterable<double> costs = allTransactions.map((e) {
        return e.getCost();
      });
      double totalSum = costs.isEmpty
          ? 0.0
          : costs.reduce(
              (value, element) {
                return value + element;
              },
            );

      return ChartData(DateFormat.E().format(weekDay).substring(0, 1), totalSum);
    });
  }

  double get maxSpending {
    return groupedTransactionValues.fold(0.0, (value, element) {
      return value + (element.amount);
    });
  }

  double percentageSpent(double totalAmount) {
    return maxSpending == 0 ? 0 : totalAmount / maxSpending;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 6,
        margin: EdgeInsets.all(20),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: groupedTransactionValues.map(
              (data) {
                return ChartBar(data.day, data.amount, percentageSpent(data.amount));
              },
            ).toList()));
  }
}
