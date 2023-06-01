import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:money_tracker/Categories/category_list_view_viewmodel.dart';
import 'package:money_tracker/Categories/category_view.dart';
import 'package:money_tracker/DataCentral/financial_category_model.dart';
import 'package:money_tracker/History/weekly_chart.dart';
import 'package:money_tracker/services/category_service.dart';
import 'package:money_tracker/services/transaction_service.dart';

class CategoryListView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _CategoryListViewState();
  }
}

class _CategoryListViewState extends State<CategoryListView> {
  final _searchController = TextEditingController();
  final _transactionController = TextEditingController();
  final CategoryListViewViewModelImpl _viewModel =
      CategoryListViewViewModelImpl(CategoryWorker(), TransactionWorker());

  void updateCategoryText(FinancialCategory categoryName) {
    _searchController.text = categoryName.name;
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
    return Column(children: [
      TextField(
        controller: _searchController,
        decoration: const InputDecoration(hintText: "Find or Add Category"),
      ),
      Row(
        children: [
          Expanded(
            child: TextField(
              controller: _transactionController,
              decoration:
                  const InputDecoration(hintText: "How Much Money Was Used?"),
            ),
          ),
          Column(
            children: [
              IconButton(
                  onPressed: _showDatePicker,
                  icon: const Icon(Icons.calendar_month)),
              Text(DateFormat.yMd()
                  .format(_viewModel.currentDate)),
            ],
          )
        ],
      ),
      ElevatedButton(
          onPressed: () async {
            await _viewModel.addTransaction(
                _searchController.text, _transactionController.text);
            setState(() {
              _searchController.text = "";
              _transactionController.text = "";
            });
          },
          child: const Text("Add Transaction")),
      if (_viewModel.recentTransactions.isNotEmpty)
        WeeklyChart(_viewModel.recentTransactions),
      (_viewModel.allCategories.isEmpty)
          ? Text("No Categories Yet.  Make One By Adding a Transaction!")
          : Expanded(
              child: GridView.count(
              crossAxisCount: 2,
              children: _viewModel.allSuggestions.entries.map((value) {
                return CategoryView(value.key, value.value, updateCategoryText);
              }).toList(),
            ))
    ]);
  }
}
