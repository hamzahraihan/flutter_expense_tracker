import 'package:equatable/equatable.dart';

sealed class TransactionFirebaseEvent extends Equatable {
  const TransactionFirebaseEvent();

  @override
  List<Object?> get props => [];
}

final class GetTransaction extends TransactionFirebaseEvent {
  const GetTransaction();
}

class ClearTransactions extends TransactionFirebaseEvent {
  const ClearTransactions();
}

final class AddExpenseTransaction extends TransactionFirebaseEvent {
  final Map<String, dynamic> transaction;
  const AddExpenseTransaction(this.transaction);

  @override
  List<Object?> get props => [transaction];
}
