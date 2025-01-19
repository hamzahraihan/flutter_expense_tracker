import 'package:equatable/equatable.dart';
import 'package:expense_tracker/features/expense/data/model/transactions_model.dart';

sealed class TransactionFirebaseEvent extends Equatable {
  const TransactionFirebaseEvent();

  @override
  List<Object?> get props => [];
}

final class GetTransaction extends TransactionFirebaseEvent {
  const GetTransaction();
}

final class AddExpenseTransaction extends TransactionFirebaseEvent {
  final Map<String, dynamic> transaction;
  const AddExpenseTransaction(this.transaction);

  @override
  List<Object?> get props => [transaction];
}
