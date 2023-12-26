import 'package:flutter/material.dart';
import 'package:money_tracker/DataCentral/transaction_model.dart';
import 'package:money_tracker/TopLevel/transaction_viewmodelimpl.dart';
import 'package:money_tracker/Transactions/transaction_edit_view.dart';
import 'package:money_tracker/Transactions/transaction_view_viewmodel.dart';
import 'package:provider/provider.dart';

import '../Utils/DateUtils/date_formatter.dart';

class TransactionView extends StatefulWidget {
  final Transaction transaction;

  const TransactionView(this.transaction, {Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _TransactionViewState();
  }
}

class _TransactionViewState extends State<TransactionView> {
  final TransactionViewViewModel _viewModel = TransactionViewViewModelImpl();

  void _finishEdit() {
    setState(() {});
  }

  void _editTransaction(TransactionViewModelImpl vm) {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: ((context) => ChangeNotifierProvider(
            create: (context) => vm,
            child: TransactionEditView(widget.transaction, _finishEdit))));
  }

  @override
  Widget build(BuildContext context) {
    Transaction transaction = this.widget.transaction;
    final transactionViewModel = context.watch<TransactionViewModelImpl>();

    return GestureDetector(
        onTap: () => setState(() {
              _viewModel.showNotes = !_viewModel.showNotes;
            }),
        onLongPress: () => _editTransaction(transactionViewModel),
        child: Card(
          color: Color.fromARGB(130, 161, 235, 95),
          shadowColor: Colors.purple,
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Text(transaction.getCategoryName()),
                          Text(dateFormatter.format(transaction.getDate())),
                        ],
                      ),
                      Text('\$${transaction.getCost().toString()}'),
                    ],
                  ),
                  if (_viewModel.showNotes)
                    Card(
                      color: Color.fromARGB(255, 255, 255, 255),
                      shadowColor: Colors.purple,
                      child: Text(transaction.getNotes()),
                    )
                ],
              )),
        ));
  }
}
