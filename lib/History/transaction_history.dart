import 'package:flutter/material.dart';
import 'package:money_tracker/History/transaction_history_view_model.dart';
import 'package:money_tracker/TopLevel/transaction_viewmodelimpl.dart';
import 'package:money_tracker/Transactions/transaction_view.dart';
import 'package:money_tracker/repositories/transaction_repository.dart';
import 'package:money_tracker/services/transaction_worker.dart';
import 'package:provider/provider.dart';


class TransactionHistory extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _TransactionHistoryState();
  }
}

class _TransactionHistoryState extends State<TransactionHistory> {
  final TransactionHistoryViewModel _viewModel =
      TransactionHistoryViewModelImpl(TransactionWorker(TransactionRepositoryImpl()));

  @override
  void initState() {
    super.initState();
    _viewModel.initialAction().then((value) {
      setState(() {});
    });
  }

  void _deleteTransaction() {
    ScaffoldMessenger.of(context)
        .clearSnackBars(); // For removing older snackbars that weren't dismissed yet
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text("You Deleted a Transaction")));
  }

  @override
  Widget build(BuildContext context) {
    final transactions = context.watch<TransactionViewModelImpl>();
    if (_viewModel.allTransactions.isEmpty) {
      return Text(
          "Still Loading Transactions"); // TODO: Refactor to split between loading state and having no data
    }
    return ListView.builder(
      itemCount: _viewModel.allTransactions.length,
      itemBuilder: (ctx, index) => Dismissible(
        key: ValueKey(_viewModel.allTransactions[index]),
        background: Container(
          color: Colors.red,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Icon(
                  Icons.delete,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
        child: TransactionView(_viewModel.allTransactions[index]),
        direction: DismissDirection.endToStart,
        onDismissed: (direction) {
          transactions.deleteTransaction(_viewModel.allTransactions[index]);

          _viewModel
              .deleteTransaction(_viewModel.allTransactions[index])
              .then((value) => _deleteTransaction());
        },
      ),
    );
  }
}
