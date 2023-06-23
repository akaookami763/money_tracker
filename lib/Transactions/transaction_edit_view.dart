import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:money_tracker/Transactions/transaction_edit_view_viewModel.dart';
import 'package:money_tracker/Transactions/transaction_edit_view_viewmodelimpl.dart';
import 'package:money_tracker/services/category_worker.dart';
import 'package:money_tracker/services/transaction_worker.dart';

import '../Categories/category_name_view.dart';
import '../DataCentral/transaction_model.dart';
import '../Utils/DateUtils/date_formatter.dart';

class TransactionEditView extends StatefulWidget {
  Transaction transaction;
  Function onFinish;

  TransactionEditView(this.transaction, this.onFinish);
  @override
  State<StatefulWidget> createState() {
    return _TransactionEditViewState();
  }
}

class _TransactionEditViewState extends State<TransactionEditView> {
  final _searchController = TextEditingController();
  final _transactionController = TextEditingController();
  final _notesController = TextEditingController();
  late TransactionEditViewViewModel _viewModel;

  void updateCategoryText(String categoryName) {
    _searchController.text = categoryName;
  }

  void _openNotesModal() {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Column(
            children: [
              TextField(
                maxLength: 30,
                decoration: const InputDecoration(label: Text("Add Notes")),
                controller: _notesController,
              ),
              ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("Add Notes")),
            ],
          );
        });
  }

  void _showDatePicker() {
    final params = _viewModel.getPickerDates();

    showDatePicker(
            context: context,
            initialDate: params.initialDate,
            firstDate: params.firstDate,
            lastDate: params.lastDate)
        .then((value) => {
              setState(() {
                _viewModel.transaction.editDate(value ?? DateTime.now());
              })
            });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _transactionController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _viewModel = TransactionEditViewViewModelImpl(
        widget.transaction, CategoryWorker(), TransactionWorker());
    _viewModel.initialAction().then((value) {
      _notesController.text = _viewModel.transaction.getNotes();
      _searchController.text = _viewModel.transaction.getCategoryName();
      _transactionController.text =
          _viewModel.transaction.getCost().toStringAsFixed(2);
      setState(() {});
    });
    _searchController.addListener(() {
      setState(() {
        _viewModel.updateSuggestions(_searchController.text);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Padding(
        padding: EdgeInsets.fromLTRB(8, 48, 8, 8),
        child: Column(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 15,
                child: TextField(
                  textInputAction: TextInputAction.next,
                  controller: _searchController,
                  decoration:
                      const InputDecoration(hintText: "Find or Add Category"),
                ),
              ),
              Spacer(
                flex: 1,
              ),
              Expanded(
                flex: 15,
                child: TextField(
                  controller: _transactionController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(hintText: "How Much?"),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  IconButton(
                      onPressed: _showDatePicker,
                      icon: const Icon(Icons.calendar_month)),
                  Text(dateFormatter.format(_viewModel.transaction.getDate())),
                ],
              ),
              ElevatedButton(
                  onPressed: () async {
                    _openNotesModal();
                  },
                  child: const Text("Notes")),
              ElevatedButton(
                  onPressed: () async {
                    bool editSuccess = await _viewModel.editTransaction(
                        _searchController.text,
                        _transactionController.text,
                        _viewModel.transaction.getDate(),
                        _notesController.text);
                    if (editSuccess) {
                      widget.onFinish();
                      Navigator.pop(context);
                    }
                  },
                  child: const Text("Finish Edit")),
            ],
          ),
          (_viewModel.allCategories.isEmpty)
              ? Text("No Categories Yet.  Make One By Adding a Transaction!")
              : Expanded(
                  child: GridView.count(
                  crossAxisCount: 2,
                  children: _viewModel.allSuggestions.map((value) {
                    return CategoryNameView(value.name, updateCategoryText);
                  }).toList(),
                )),
        ]),
      ),
    );
  }
}
