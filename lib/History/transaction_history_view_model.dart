import 'package:money_tracker/DataCentral/transaction_model.dart';

abstract class TransactionHistoryViewModel {
  late List<Transaction> allTransactions;
  TransactionCost costFilterState = TransactionCost.nothing;
  TransactionDate dateFilterState = TransactionDate.nothing;
  void updateTransactions(List<Transaction> transactions);
  List<Transaction> filterTransactions(
      {String? textInput,
      String? costAmount,
      DateTime? dateValue,
      required TransactionCost costFilter,
      required TransactionDate dateFilter});
}

enum TransactionCost { greaterThanOrEqual, lessThanOrEqual, nothing }

enum TransactionDate { beforeOrOn, afterOrOn, nothing }

// MARK: Actual Implementation

class TransactionHistoryViewModelImpl extends TransactionHistoryViewModel {
  List<Transaction> _transactions = [];

  @override
  List<Transaction> get allTransactions => _transactions;

  TransactionHistoryViewModelImpl(this._transactions);

  @override
  void updateTransactions(List<Transaction> transactions) {
    _transactions = transactions;
  }

  @override
  List<Transaction> filterTransactions(
      {String? textInput,
      String? costAmount,
      DateTime? dateValue,
      required TransactionCost costFilter,
      required TransactionDate dateFilter}) {
    List<Transaction> filteredTransactions = _transactions;
    costFilterState = costFilter;
    dateFilterState = dateFilter;

    // Check cost filter first
    if (costAmount != null) {
      double doubleCost = double.tryParse(costAmount) ?? -1;
      if (doubleCost != -1) {
        switch (costFilter) {
          case TransactionCost.greaterThanOrEqual:
            filteredTransactions = filteredTransactions
                .where((element) => element.getCost() >= (doubleCost))
                .toList();
            break;
          case TransactionCost.lessThanOrEqual:
            filteredTransactions = filteredTransactions
                .where((element) => element.getCost() <= (doubleCost))
                .toList();
            break;
          case TransactionCost.nothing:
            break;
        }
      }
    }
    // check date filter second
    if (dateValue != null) {
      filteredTransactions = filteredTransactions
          .where((element) =>
              _compareDates(element.getDate(), dateValue, dateFilter))
          .toList();
    }
    // Check category name and notes last
    filteredTransactions = filteredTransactions
        .where((element) => (element
                .getCategoryName()
                .toLowerCase()
                .contains((textInput ?? "").toLowerCase()) ||
            element
                .getNotes()
                .toLowerCase()
                .contains((textInput ?? "").toLowerCase())))
        .toList();

    return filteredTransactions;
  }

  bool _compareDates(
      DateTime transactionDate, DateTime dateValue, TransactionDate operator) {
    switch (operator) {
      case TransactionDate.afterOrOn:
        DateTime updateValue = dateValue.subtract(const Duration(days: 1));
        return transactionDate.isAfter(updateValue);
      case TransactionDate.beforeOrOn:
        DateTime updateValue = dateValue.add(const Duration(days: 1));
        return transactionDate.isBefore(updateValue);
      case TransactionDate.nothing:
        // Default to true if there is some random problem.  Should never happen
        return true;
    }
  }
}
