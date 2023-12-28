import 'package:flutter/material.dart';
import 'package:money_tracker/History/transaction_history_view_model.dart';
import 'package:money_tracker/TopLevel/transaction_viewmodelimpl.dart';
import 'package:money_tracker/Transactions/transaction_view.dart';
import 'package:provider/provider.dart';

class TransactionHistory extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _TransactionHistoryState();
  }
}

class _TransactionHistoryState extends State<TransactionHistory> {
  final TransactionHistoryViewModel _viewModel =
      TransactionHistoryViewModelImpl([]);
  final _textFilterController = TextEditingController();
  final _costFilterController = TextEditingController();

  @override
  void initState() {
    super.initState();
    setState(() {});
    _textFilterController.addListener(() {
      setState(() {
        _viewModel.filterTransactions(
            textInput: _textFilterController.text,
            costFilter: TransactionCost.nothing,
            costAmount: _costFilterController.text,
            dateFilter: TransactionDate.nothing);
      });
    });
    _costFilterController.addListener(() {
      setState(() {
        _viewModel.filterTransactions(
            textInput: _textFilterController.text,
            costFilter: TransactionCost.nothing,
            costAmount: _costFilterController.text,
            dateFilter: TransactionDate.nothing);
      });
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
    final transactionViewModel = context.watch<TransactionViewModelImpl>();
    _viewModel.updateTransactions(transactionViewModel.getTransactions());
    if (_viewModel
        .filterTransactions(
            costFilter: TransactionCost.nothing,
            dateFilter: TransactionDate.nothing)
        .isEmpty) {
      return Text(
          "No Transactions Found"); // TODO: Refactor to split between loading state and having no data
    } else {
      return Padding(
        padding: EdgeInsets.all(8),
        child: Column(children: [
          Row(
            children: [
              Expanded(
                flex: 15,
                child: TextField(
                  textInputAction: TextInputAction.next,
                  controller: _textFilterController,
                  decoration: const InputDecoration(
                      hintText: "Filter by Category or Notes"),
                ),
              ),
            ],
          ),
          Expanded(child:           ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: _viewModel
                .filterTransactions(
                    textInput: _textFilterController.text,
                    costFilter: _viewModel.costFilterState,
                    costAmount: _costFilterController.text,
                    dateFilter: _viewModel.dateFilterState)
                .length,
            itemBuilder: (ctx, index) => Dismissible(
              key: ValueKey(_viewModel.filterTransactions(
                  textInput: _textFilterController.text,
                  costFilter: _viewModel.costFilterState,
                  costAmount: _costFilterController.text,
                  dateFilter: _viewModel.dateFilterState)[index]),
              background: Container(
                color: Colors.red,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.delete,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              child: TransactionView(_viewModel.filterTransactions(
                  textInput: _textFilterController.text,
                  costFilter: _viewModel.costFilterState,
                  costAmount: _costFilterController.text,
                  dateFilter: _viewModel.dateFilterState)[index]),
              direction: DismissDirection.endToStart,
              onDismissed: (direction) {
                transactionViewModel.deleteTransaction(
                    _viewModel.filterTransactions(
                        textInput: _textFilterController.text,
                        costFilter: _viewModel.costFilterState,
                        costAmount: _costFilterController.text,
                        dateFilter: _viewModel.dateFilterState)[index]);
              },
            ),
          ))

        ]),
      );
    }
  }
}
