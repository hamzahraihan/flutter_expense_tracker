import 'package:equatable/equatable.dart';
import 'package:expense_tracker/features/auth/domain/entity/auth_entities.dart';

sealed class TransactionFirebaseEvent extends Equatable {
  const TransactionFirebaseEvent();

  @override
  List<Object?> get props => [];
}

final class GetTransaction extends TransactionFirebaseEvent {
  final AuthEntities authUser;
  const GetTransaction(
    this.authUser,
  );

  @override
  List<Object?> get props => [
        authUser,
      ];
}

final class AddExpenseTransaction extends TransactionFirebaseEvent {
  final Map<String, dynamic> transaction;
  const AddExpenseTransaction(this.transaction);

  @override
  List<Object?> get props => [transaction];
}
