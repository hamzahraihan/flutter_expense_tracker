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

  const TransactionFirebaseState(
      {this.status = TransactionStatus.initial,
      List<TransactionsModel>? transactions})
      : transactions = transactions ?? const [];

  TransactionFirebaseState copyWith({
    TransactionStatus? status,
    List<TransactionsModel>? transactions,
  }) {
    return TransactionFirebaseState(
        status: status ?? this.status,
        transactions: transactions ?? this.transactions);
  }

  @override
  List<Object?> get props => [status, transactions];
}
