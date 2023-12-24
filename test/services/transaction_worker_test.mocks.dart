// Mocks generated by Mockito 5.4.4 from annotations
// in money_tracker/test/services/transaction_worker_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;

import 'package:mockito/mockito.dart' as _i1;
import 'package:mockito/src/dummies.dart' as _i6;
import 'package:money_tracker/DataCentral/financial_category_model.dart' as _i2;
import 'package:money_tracker/DataCentral/transaction_model.dart' as _i5;
import 'package:money_tracker/repositories/transaction_repository_abstract.dart'
    as _i3;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: deprecated_member_use
// ignore_for_file: deprecated_member_use_from_same_package
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeFinancialCategory_0 extends _i1.SmartFake
    implements _i2.FinancialCategory {
  _FakeFinancialCategory_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeDateTime_1 extends _i1.SmartFake implements DateTime {
  _FakeDateTime_1(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [TransactionRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockTransactionRepository extends _i1.Mock
    implements _i3.TransactionRepository {
  MockTransactionRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<List<_i5.Transaction>> getAllTransactions() => (super.noSuchMethod(
        Invocation.method(
          #getAllTransactions,
          [],
        ),
        returnValue:
            _i4.Future<List<_i5.Transaction>>.value(<_i5.Transaction>[]),
      ) as _i4.Future<List<_i5.Transaction>>);

  @override
  _i4.Future<List<_i5.Transaction>> getAllTransactionsFor(
          _i2.FinancialCategory? category) =>
      (super.noSuchMethod(
        Invocation.method(
          #getAllTransactionsFor,
          [category],
        ),
        returnValue:
            _i4.Future<List<_i5.Transaction>>.value(<_i5.Transaction>[]),
      ) as _i4.Future<List<_i5.Transaction>>);

  @override
  _i4.Future<_i5.Transaction?> getTransactionByTag(int? tag) =>
      (super.noSuchMethod(
        Invocation.method(
          #getTransactionByTag,
          [tag],
        ),
        returnValue: _i4.Future<_i5.Transaction?>.value(),
      ) as _i4.Future<_i5.Transaction?>);

  @override
  _i4.Future<int> updateTransaction(_i5.Transaction? transaction) =>
      (super.noSuchMethod(
        Invocation.method(
          #updateTransaction,
          [transaction],
        ),
        returnValue: _i4.Future<int>.value(0),
      ) as _i4.Future<int>);

  @override
  _i4.Future<int> createTransaction(
    int? category,
    DateTime? date,
    double? cost,
    String? extraNotes,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #createTransaction,
          [
            category,
            date,
            cost,
            extraNotes,
          ],
        ),
        returnValue: _i4.Future<int>.value(0),
      ) as _i4.Future<int>);

  @override
  _i4.Future<int> removeTransaction(_i5.Transaction? transaction) =>
      (super.noSuchMethod(
        Invocation.method(
          #removeTransaction,
          [transaction],
        ),
        returnValue: _i4.Future<int>.value(0),
      ) as _i4.Future<int>);
}

/// A class which mocks [Transaction].
///
/// See the documentation for Mockito's code generation for more information.
class MockTransaction extends _i1.Mock implements _i5.Transaction {
  MockTransaction() {
    _i1.throwOnMissingStub(this);
  }

  @override
  int getTag() => (super.noSuchMethod(
        Invocation.method(
          #getTag,
          [],
        ),
        returnValue: 0,
      ) as int);

  @override
  _i2.FinancialCategory getCategory() => (super.noSuchMethod(
        Invocation.method(
          #getCategory,
          [],
        ),
        returnValue: _FakeFinancialCategory_0(
          this,
          Invocation.method(
            #getCategory,
            [],
          ),
        ),
      ) as _i2.FinancialCategory);

  @override
  String getCategoryName() => (super.noSuchMethod(
        Invocation.method(
          #getCategoryName,
          [],
        ),
        returnValue: _i6.dummyValue<String>(
          this,
          Invocation.method(
            #getCategoryName,
            [],
          ),
        ),
      ) as String);

  @override
  DateTime getDate() => (super.noSuchMethod(
        Invocation.method(
          #getDate,
          [],
        ),
        returnValue: _FakeDateTime_1(
          this,
          Invocation.method(
            #getDate,
            [],
          ),
        ),
      ) as DateTime);

  @override
  double getCost() => (super.noSuchMethod(
        Invocation.method(
          #getCost,
          [],
        ),
        returnValue: 0.0,
      ) as double);

  @override
  String getNotes() => (super.noSuchMethod(
        Invocation.method(
          #getNotes,
          [],
        ),
        returnValue: _i6.dummyValue<String>(
          this,
          Invocation.method(
            #getNotes,
            [],
          ),
        ),
      ) as String);

  @override
  void editNotes(String? notes) => super.noSuchMethod(
        Invocation.method(
          #editNotes,
          [notes],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void editDate(DateTime? date) => super.noSuchMethod(
        Invocation.method(
          #editDate,
          [date],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void editCategory(_i2.FinancialCategory? category) => super.noSuchMethod(
        Invocation.method(
          #editCategory,
          [category],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void editCost(double? cost) => super.noSuchMethod(
        Invocation.method(
          #editCost,
          [cost],
        ),
        returnValueForMissingStub: null,
      );
}
