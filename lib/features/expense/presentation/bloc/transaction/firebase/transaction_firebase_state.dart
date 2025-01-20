import 'package:equatable/equatable.dart';
import 'package:expense_tracker/features/expense/data/model/transactions_model.dart';

enum TransactionStatus { initial, loading, success, failure }

extension TransactionStatusX on TransactionStatus {
  bool get isInitial => this == TransactionStatus.initial;
  bool get isLoading => this == TransactionStatus.loading;
  bool get isSuccess => this == TransactionStatus.success;
  bool get isFailure => this == TransactionStatus.failure;
}

class TransactionFirebaseState extends Equatable {
  final TransactionStatus status;
  final List<TransactionsModel> transactions;
  final List<TransactionsModel> todayTransactions;
  final List<TransactionsModel> yesterdayTransactions;
  final List<TransactionsModel> thisWeekTransactions;
  final List<TransactionsModel> thisMonthTransaction;
  final List<TransactionsModel> olderTransactions;

  const TransactionFirebaseState({
    this.status = TransactionStatus.initial,
    List<TransactionsModel>? transactions,
    this.todayTransactions = const [],
    this.yesterdayTransactions = const [],
    this.thisWeekTransactions = const [],
    this.thisMonthTransaction = const [],
    this.olderTransactions = const [],
  }) : transactions = transactions ?? const [];

  TransactionFirebaseState copyWith({
    TransactionStatus? status,
    List<TransactionsModel>? transactions,
    List<TransactionsModel>? todayTransactions,
    List<TransactionsModel>? yesterdayTransactions,
    List<TransactionsModel>? thisWeekTransactions,
    List<TransactionsModel>? thisMonthTransaction,
    List<TransactionsModel>? olderTransactions,
  }) {
    return TransactionFirebaseState(
      status: status ?? this.status,
      transactions: transactions ?? this.transactions,
      todayTransactions: todayTransactions ?? this.todayTransactions,
      yesterdayTransactions:
          yesterdayTransactions ?? this.yesterdayTransactions,
      thisWeekTransactions:
          thisWeekTransactions ?? this.thisWeekTransactions,
      thisMonthTransaction:
          thisMonthTransaction ?? this.thisMonthTransaction,
      olderTransactions: olderTransactions ?? this.olderTransactions,
    );
  }

  @override
  List<Object?> get props => [
        status,
        transactions,
        todayTransactions,
        yesterdayTransactions,
        thisWeekTransactions,
        thisMonthTransaction,
        olderTransactions,
      ];
}
