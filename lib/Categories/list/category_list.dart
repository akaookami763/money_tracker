import 'package:flutter/material.dart';
import 'package:money_tracker/Categories/item/category_view.dart';
import 'package:money_tracker/Categories/list/category_list_view_viewmodel.dart';
import 'package:money_tracker/Categories/list/category_list_view_viewmodel_abstract.dart';
import 'package:money_tracker/DataCentral/financial_category_model.dart';
import 'package:money_tracker/TopLevel/transaction_viewmodel.dart';
import 'package:money_tracker/Utils/DateUtils/date_picker_params.dart';
import 'package:provider/provider.dart';

import '../../TopLevel/transaction_viewmodelimpl.dart';
import '../../Utils/DateUtils/date_formatter.dart';

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
  final CategoryListViewViewModel _viewModel = CategoryListViewViewModelImpl();

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
                    Navigator.pop(context);
                  },
                  child: const Text("Add Notes")),
            ],
          );
        });
  }

  void _showDatePicker() {
    final params = getPickerDates(_viewModel.currentDate);

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
    print("SELFLOG: Start Init on Category List");
    setState(() {});
    _searchController.addListener(() {
      setState(() {
        _viewModel.getSuggestedCategories(_searchController.text);
      });
    });
  }

  void updateTransactionsAndCategories(TransactionViewModel tVM) async {
    print(
        "SELFLOG: Added transaction, so updating the top level state transactions and categories");
    tVM.addTransaction(_searchController.text, _transactionController.text,
        _viewModel.currentDate, _notesController.text);
    setState(() {
      _searchController.text = "";
      _transactionController.text = "";
      _notesController.text = "";
      _viewModel.currentDate = DateTime.now();
    });
  }

  void setLocalCategoriesAndTransactions(TransactionViewModel tVM) {
    _viewModel.updateCategories(tVM.getCategories(), tVM.getTransactions());
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TransactionViewModelImpl>(
        builder: (context, transactionViewModel, child) {
      setLocalCategoriesAndTransactions(transactionViewModel);
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
                TextButton.icon(
                  onPressed: _showDatePicker,
                  icon: Icon(Icons.calendar_month),
                  label: Text(dateFormatter.format(_viewModel.currentDate)),
                ),
                ElevatedButton(
                    onPressed: () async {
                      _openNotesModal();
                    },
                    child: const Text("Notes")),
                ElevatedButton(
                    onPressed: () =>
                        updateTransactionsAndCategories(transactionViewModel),
                    child: const Text("Add Transaction")),
              ],
            ),
            (_viewModel.getSuggestedCategories(_searchController.text).isEmpty)
                ? Text("No Categories Yet.  Make One By Adding a Transaction!")
                : Expanded(
                    child: GridView.count(
                    crossAxisCount: 3,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: 1.5,
                    children: _viewModel
                        .getSuggestedCategories(_searchController.text)
                        .entries
                        .map((value) {
                      return CategoryView(
                          value.key, value.value, updateCategoryText);
                    }).toList(),
                  ))
          ]),
        ),
      );
    });
  }
}
