import 'package:flutter/material.dart';
import 'package:money_tracker/Categories/category_list_view_viewmodel.dart';
import 'package:money_tracker/Categories/category_view.dart';

class CategoryListView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _CategoryListViewState();
  }
}

class _CategoryListViewState extends State<CategoryListView> {
  final _searchController = TextEditingController();
  final CategoryListViewViewModel _viewModel = CategoryListViewViewModel();

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() {
      setState(() {
        print("Changed text");
        _viewModel.updateSuggestions(_searchController.text);
      });
    });
    _viewModel.initialActions().then((value) => setState(() => {}));
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      TextField(
        controller: _searchController,
      ),
      ElevatedButton(
          onPressed: () {
            print("Adding Category");
          },
          child: Text("Add Category")),
      ..._viewModel.getCategories().map((category) {
        return CategoryView(category);
      }).toList()
    ]);
  }
}
