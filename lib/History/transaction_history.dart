import 'package:flutter/material.dart';
import 'package:money_tracker/History/transaction_history_view_model.dart';
import 'package:money_tracker/Transactions/transaction_view.dart';
import 'package:money_tracker/services/transaction_service.dart';

import '../DataCentral/transaction_model.dart';

class TransactionHistory extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _TransactionHistoryState();
  }
}

class _TransactionHistoryState extends State<TransactionHistory> {
  final TransactionHistoryViewModel _viewModel =
      TransactionHistoryViewModelImpl(TransactionWorker());

  @override
  void initState() {
    super.initState();
    _viewModel.initialAction().then((value) {
      setState(() {});
    });
  }

  void _deleteTransaction(Transaction transaction) {
    _viewModel.deleteTransaction(transaction).then((value) {
      setState(() {
        
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_viewModel.allTransactions.isEmpty) {
      return Text(
          "Still Loading Transactions"); // TODO: Refactor to split between loading state and having no data
    }
    return ListView.builder(
      itemCount: _viewModel.allTransactions.length,
      itemBuilder: (ctx, index) => Dismissible(
        key: ValueKey(_viewModel.allTransactions[index]),
         child: TransactionView(_viewModel.allTransactions[index]),
         direction: DismissDirection.endToStart,
         onDismissed: (direction) {
          _deleteTransaction(_viewModel.allTransactions[index]);
         } ,)
          ,
    );
  }
}
