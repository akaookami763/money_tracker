
  import 'package:flutter/foundation.dart';
import 'package:money_tracker/DataCentral/financial_category_model.dart';
import 'package:money_tracker/DataCentral/transaction_model.dart';

import 'category.dart';



List<Transaction> sampleTransactions() => [
        Transaction(
            tag: UniqueKey().hashCode,
            category: sampleCategories().elementAt(0),
            date: DateTime.now(),
            cost: 42.35,
            extraNotes: ""),
        Transaction(
            tag: UniqueKey().hashCode,
            category: sampleCategories().elementAt(0),
            date: DateTime.now(),
            cost: 3.45,
            extraNotes: ""),
        Transaction(
            tag: UniqueKey().hashCode,
            category: sampleCategories().elementAt(0),
            date: DateTime.now(),
            cost: 100.34,
            extraNotes: ""),
        Transaction(
            tag: UniqueKey().hashCode,
            category: sampleCategories().elementAt(0),
            date: DateTime.now(),
            cost: 24.11,
            extraNotes: ""),
        Transaction(
            tag: UniqueKey().hashCode,
            category: sampleCategories().elementAt(1),
            date: DateTime.now(),
            cost: 48372.32,
            extraNotes: ""),
        Transaction(
            tag: UniqueKey().hashCode,
            category: sampleCategories().elementAt(1),
            date: DateTime.now(),
            cost: 48.835,
            extraNotes: ""),
        Transaction(
            tag: UniqueKey().hashCode,
            category: sampleCategories().elementAt(2),
            date: DateTime.now(),
            cost: 102.48,
            extraNotes: ""),
        Transaction(
            tag: UniqueKey().hashCode,
            category: sampleCategories().elementAt(3),
            date: DateTime.now(),
            cost: 0.54,
            extraNotes: ""),
      ];