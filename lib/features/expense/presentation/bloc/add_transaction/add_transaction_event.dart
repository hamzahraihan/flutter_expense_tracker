import 'package:equatable/equatable.dart';

sealed class AddTransactionEvent extends Equatable {
  const AddTransactionEvent();

  @override
  List<Object?> get props => [];
}

final class RefreshTransaction extends AddTransactionEvent {
  const RefreshTransaction();
}

final class AddTransactionTitleChanged extends AddTransactionEvent {
  final String titleValue;
  const AddTransactionTitleChanged(this.titleValue);

  @override
  List<Object?> get props => [titleValue];
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

final class AddTransactionSubmitted extends AddTransactionEvent {
  final Map<String, dynamic> transaction;
  const AddTransactionSubmitted(this.transaction);

  @override
  List<Object?> get props => [transaction];
}
