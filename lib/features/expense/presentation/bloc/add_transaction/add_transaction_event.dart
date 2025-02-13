import 'package:equatable/equatable.dart';

sealed class AddTransactionEvent extends Equatable {
  const AddTransactionEvent();

  @override
  List<Object?> get props => [];
}

final class RefreshTransaction extends AddTransactionEvent {
  const RefreshTransaction();
}

final class AddTransactionDescriptionChanged
    extends AddTransactionEvent {
  final String descriptionValue;
  const AddTransactionDescriptionChanged(this.descriptionValue);

  @override
  List<Object?> get props => [descriptionValue];
}

final class AddTransactionCategoryChanged
    extends AddTransactionEvent {
  final String categoryValue;
  const AddTransactionCategoryChanged(this.categoryValue);

  @override
  List<Object?> get props => [categoryValue];
}

final class AddTransactionAmountChanged extends AddTransactionEvent {
  final int amountValue;
  const AddTransactionAmountChanged(this.amountValue);

  @override
  List<Object?> get props => [amountValue];
}

final class AddTransactionExpenseTypeChanged
    extends AddTransactionEvent {
  final String expenseType;
  const AddTransactionExpenseTypeChanged(this.expenseType);

  @override
  List<Object?> get props => [expenseType];
}

final class AddTransactionWalletIdChanged
    extends AddTransactionEvent {
  final String walletId;
  const AddTransactionWalletIdChanged(this.walletId);

  @override
  List<Object?> get props => [walletId];
}

final class AddTransactionSubmitted extends AddTransactionEvent {
  const AddTransactionSubmitted();
}
