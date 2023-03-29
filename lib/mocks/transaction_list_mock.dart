import 'package:money_tracker/DataCentral/transaction_model.dart';
import 'package:money_tracker/mocks/category_list_mock.dart';

List<Transaction> transactionListMock = [
    Transaction(
        category: categoryListMock.where((element) => element.name == "Water").toList()[0],
        date: DateTime.now(),
        cost: 42.35,
        extraNotes: ""),
    Transaction(
        category: categoryListMock.where((element) => element.name == "Health").toList()[0],
        date: DateTime.now(),
        cost: 3.45,
        extraNotes: ""),
    Transaction(
        category: categoryListMock.where((element) => element.name == "Cards").toList()[0],
        date: DateTime.now(),
        cost: 100.34,
        extraNotes: ""),
    Transaction(
        category: categoryListMock.where((element) => element.name == "Groceries").toList()[0],
        date: DateTime.now(),
        cost: 24.11,
        extraNotes: ""),
    Transaction(
        category: categoryListMock.where((element) => element.name == "Mortgage Interest").toList()[0],
        date: DateTime.now(),
        cost: 48372.32,
        extraNotes: ""),
    Transaction(
        category: categoryListMock.where((element) => element.name == "Water").toList()[0],
        date: DateTime.now(),
        cost: 48.835,
        extraNotes: ""),
    Transaction(
        category: categoryListMock.where((element) => element.name == "Health").toList()[0],
        date: DateTime.now(),
        cost: 102.48,
        extraNotes: ""),
    Transaction(
        category: categoryListMock.where((element) => element.name == "Restaurants").toList()[0],
        date: DateTime.now(),
        cost: 0.54,
        extraNotes: ""),
  ];