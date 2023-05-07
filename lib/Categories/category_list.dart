import 'package:flutter/material.dart';
import 'package:money_tracker/Categories/category_list_view_viewmodel.dart';
import 'package:money_tracker/Categories/category_view.dart';
import 'package:money_tracker/DataCentral/financial_category_model.dart';
import 'package:money_tracker/History/weekly_chart.dart';
import 'package:money_tracker/services/category_service.dart';
import 'package:money_tracker/services/transaction_service.dart';

import 'category_list_view_viewmodel_abstract.dart';

class CategoryListView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _CategoryListViewState();
  }
}

class _CategoryListViewState extends State<CategoryListView> {
  final _searchController = TextEditingController();
  final _transactionController = TextEditingController();
  final CategoryListViewViewModel _viewModel = CategoryListViewViewModelImpl(
      CategoryWorker(), TransactionWorker());

  void updateCategoryText(FinancialCategory categoryName) {
    _searchController.text = categoryName.name;
  }

  @override
  void initState() {
    super.initState();
    _viewModel.initialAction().then((value) {
      print("Starting with new details");
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
        decoration: InputDecoration(hintText: "Find or Add Category"),
      ),
      TextField(
        controller: _transactionController,
        decoration: InputDecoration(hintText: "How Much Money Was Used?"),
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
          if(_viewModel.recentTransactions.isNotEmpty) WeeklyChart(_viewModel.recentTransactions),
      Expanded(
          child: GridView.count(
        crossAxisCount: 2,
        children: _viewModel.allSuggestions.entries.map((value) {
          return CategoryView(value.key, value.value, updateCategoryText);
        }).toList(),
      ))
    ]);
  }
}
