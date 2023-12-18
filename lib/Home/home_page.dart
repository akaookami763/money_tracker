import 'package:flutter/material.dart';
import 'package:money_tracker/History/transaction_history.dart';

import '../Categories/list/category_list.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(length: 3, child: Scaffold(appBar: AppBar(
      title: const Text("Money Tracker"),
      bottom: const TabBar(tabs: [
        Tab(icon: Icon(Icons.home)),
        Tab(icon: Icon(Icons.list)),
        Tab(icon: Icon(Icons.star_outline_sharp))
      ]),
      ),
      body: TabBarView(children: [
        CategoryListView(),
        TransactionHistory(),
        Tab(child: Text("Budget Feature Coming Soon!")),
      ]),));

    // return Scaffold(
    //   appBar: AppBar(
    //     title: const Text("Money Tracker"),
    //   ),
    //   body: CategoryListView(),
    // );
  }
}
