import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:money_tracker/Categories/category_view_viewmodel.dart';
import 'package:money_tracker/DataCentral/financial_category_model.dart';

class CategoryView extends StatefulWidget {
  final FinancialCategory category;

  CategoryView(this.category);

  @override
  State<StatefulWidget> createState() {
    return _CategoryViewState();
  }
}

class _CategoryViewState extends State<CategoryView> {
  final _controller = TextEditingController();

  late CategoryViewViewModel _viewModel;
  @override
  void initState() {
    super.initState();
    _viewModel = CategoryViewViewModel(widget.category);
    _viewModel.initialActions().then((value) => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    if(_viewModel.transactions.isEmpty) {
      //TODO: This is a workaround to avoid an exception when we have no transactions loaded yet
      return const SizedBox();
    }
    return Column(
      children: [
        Text(widget.category.name),
        Row(
          children: [
            Expanded(child: Text(_viewModel.updateSum().toStringAsFixed(2))),
            Expanded(
                child: TextField(
                    controller: _controller,
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'[\d.]'))
                    ],
                    decoration: InputDecoration(
                      hintText: "Amount",
                    ))),
            ElevatedButton(
              child: Text("-"),
              onPressed: () {
                _viewModel.costDecrease(
                    "", _controller.text, DateTime.now(), "");
                setState(() {
                  _controller.clear();
                });
                print("Tapped Minus");
              },
            ),
            ElevatedButton(
              child: Text("+"),
              onPressed: () {
                _viewModel.costIncrease(_controller.text, DateTime.now(), "");
                setState(() {
                  _controller.clear();
                });
                print("Tapped Plus");
              },
            )
          ],
        ),
      ],
    );
  }
}
