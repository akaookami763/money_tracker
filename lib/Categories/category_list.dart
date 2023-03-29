import 'package:flutter/material.dart';
import 'package:money_tracker/Categories/category_list_view_viewmodel.dart';
import 'package:money_tracker/Categories/category_view.dart';
import 'package:money_tracker/DataCentral/financial_category_model.dart';
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
  final CategoryListViewViewModel _viewModel = CategoryListViewViewModelImpl(CategoryServiceMock(), TransactionServiceMock());

  void updateCategoryText(FinancialCategory categoryName) {
    _searchController.text = categoryName.name;
  }

  @override
  void initState() {
    super.initState();
    _viewModel.initialAction().then((value) {
      print("Starting with new details");
      setState(() {
      });
    });
    _searchController.addListener(() {
      setState(() {
        _viewModel.updateSuggestions(_searchController.text);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    print("Rebuilding");
    return Column(children: [
      TextField(
        controller: _searchController,
      ),
      TextField(controller: _transactionController,),
      ElevatedButton(
          onPressed: () async {
            await _viewModel.addTransaction(_searchController.text, _transactionController.text);
            setState(() {
              _searchController.text = "";
              _transactionController.text = "";
            });
          },
          child: const Text("Add Transaction")),
      ..._viewModel.allSuggestions.entries.map((value) {
          return CategoryView(value.key, value.value, updateCategoryText);
      }).toList()
    ]);
  }
}
