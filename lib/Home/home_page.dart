import 'package:flutter/material.dart';

import '../Categories/category_list.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Money Tracker"),
      ),
      body: CategoryListView(),
    );
  }
}
