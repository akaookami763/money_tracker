import 'package:flutter/material.dart';
import 'package:money_tracker/Home/home_page.dart';
import 'package:money_tracker/TopLevel/transaction_viewmodelimpl.dart';
import 'package:money_tracker/repositories/category_repository.dart';
import 'package:money_tracker/repositories/transaction_repository.dart';
import 'package:money_tracker/services/category_worker.dart';
import 'package:money_tracker/services/transaction_worker.dart';
import 'package:provider/provider.dart';

import 'category_viewmodelimpl.dart';

class MTProvider extends StatelessWidget {
  const MTProvider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      // TODO: Setup Budget worker
      ChangeNotifierProvider(
          create: (context) => CategoryViewModelImpl(
              CategoryWorker(FinancialCategoryRepositoryImpl()))),
      ChangeNotifierProvider(
          create: (context) => TransactionViewModelImpl(
              TransactionWorker(TransactionRepositoryImpl()),
              CategoryWorker(FinancialCategoryRepositoryImpl())))
    ], child: HomePage());
  }
}
