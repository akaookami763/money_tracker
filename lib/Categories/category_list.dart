import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:money_tracker/Categories/category_list_view_viewmodel.dart';
import 'package:money_tracker/Categories/category_view.dart';
import 'package:money_tracker/DataCentral/financial_category_model.dart';
import 'package:money_tracker/History/weekly_chart.dart';
import 'package:money_tracker/services/category_worker.dart';
import 'package:money_tracker/services/transaction_worker.dart';

import '../Utils/DateUtils/date_formatter.dart';

class CategoryListView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _CategoryListViewState();
  }
}

class _CategoryListViewState extends State<CategoryListView> {
  final _searchController = TextEditingController();
  final _transactionController = TextEditingController();
  final _notesController = TextEditingController();
  final CategoryListViewViewModelImpl _viewModel =
      CategoryListViewViewModelImpl(CategoryWorker(), TransactionWorker());

  void updateCategoryText(FinancialCategory categoryName) {
    _searchController.text = categoryName.name;
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
                    _viewModel.notes = _notesController.text;
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
                _viewModel.currentDate = value ?? DateTime.now();
              })
            });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _transactionController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _viewModel.initialAction().then((value) {
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
        padding: EdgeInsets.all(8),
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
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextButton.icon( onPressed: _showDatePicker, icon: Icon(Icons.calendar_month), label: Text(dateFormatter.format(_viewModel.currentDate)),),
              ElevatedButton(
                  onPressed: () async {
                    _openNotesModal();
                  },
                  child: const Text("Notes")),
              ElevatedButton(
                  onPressed: () async {
                    await _viewModel.addTransaction(
                        _searchController.text, _transactionController.text);
                    setState(() {
                      _searchController.text = "";
                      _transactionController.text = "";
                      _notesController.text = "";
                    });
                  },
                  child: const Text("Add Transaction")),
            ],
          ),
          (_viewModel.allCategories.isEmpty)
              ? Text("No Categories Yet.  Make One By Adding a Transaction!")
              : Expanded(
                  child: GridView.count(
                  crossAxisCount: 3,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 1.5,
                  children: _viewModel.allSuggestions.entries.map((value) {
                    return CategoryView(
                        value.key, value.value, updateCategoryText);
                  }).toList(),
                )),
        ]),
      ),
    );
  }
}
