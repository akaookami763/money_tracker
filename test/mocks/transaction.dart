import 'package:flutter/foundation.dart';
import 'package:money_tracker/DataCentral/transaction_model.dart';

import 'category.dart';

List<Transaction> sampleTransactions() => [
      Transaction(
          tag: UniqueKey().hashCode,
          category: sampleCategories().elementAt(0),
          date: DateTime(2017, 9, 7, 17, 30),
          cost: 42.35,
          extraNotes: ""),
      Transaction(
          tag: UniqueKey().hashCode,
          category: sampleCategories().elementAt(0),
          date: DateTime(2017, 9, 7, 17, 30),
          cost: 3.45,
          extraNotes: ""),
      Transaction(
          tag: UniqueKey().hashCode,
          category: sampleCategories().elementAt(0),
          date: DateTime(2017, 9, 7, 17, 30),
          cost: 100.34,
          extraNotes: ""),
      Transaction(
          tag: UniqueKey().hashCode,
          category: sampleCategories().elementAt(0),
          date: DateTime(2023, 12, 25, 0, 0),
          cost: 24.11,
          extraNotes: "Random Notes"),
      Transaction(
          tag: UniqueKey().hashCode,
          category: sampleCategories().elementAt(1),
          date: DateTime(2018, 9, 7, 17, 30),
          cost: 48372.32,
          extraNotes: ""),
      Transaction(
          tag: UniqueKey().hashCode,
          category: sampleCategories().elementAt(1),
          date: DateTime(2022, 9, 7, 17, 30),
          cost: 48.835,
          extraNotes: ""),
      Transaction(
          tag: UniqueKey().hashCode,
          category: sampleCategories().elementAt(2),
          date: DateTime(2024, 9, 7, 17, 30),
          cost: 102.48,
          extraNotes: ""),
      Transaction(
          tag: UniqueKey().hashCode,
          category: sampleCategories().elementAt(3),
          date: DateTime(2024, 6, 10, 0, 0),
          cost: 0.54,
          extraNotes: ""),
    ];
