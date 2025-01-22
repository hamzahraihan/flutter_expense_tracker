import 'package:equatable/equatable.dart';

enum AddTransactionStatus { initial, loading, success, failure }

extension AddTransactionStatusX on AddTransactionStatus {
  bool get isInitial => this == AddTransactionStatus.initial;
  bool get isLoading => this == AddTransactionStatus.loading;
  bool get isSuccess => this == AddTransactionStatus.success;
  bool get isFailure => this == AddTransactionStatus.failure;
}

class AddTransactionState extends Equatable {
  final AddTransactionStatus status;
  final String descriptionValue;
  final String categoryValue;
  final int amountValue;
  final String expenseType;

  const AddTransactionState(
      {this.status = AddTransactionStatus.initial,
      this.descriptionValue = '',
      this.amountValue = 0,
      this.categoryValue = '',
      this.expenseType = ''});

  AddTransactionState copyWith(
      {AddTransactionStatus? status,
      String? titleValue,
      String? descriptionValue,
      String? categoryValue,
      int? amountValue,
      String? expenseType}) {
    return AddTransactionState(
        status: status ?? this.status,
        descriptionValue: descriptionValue ?? this.descriptionValue,
        categoryValue: categoryValue ?? this.categoryValue,
        amountValue: amountValue ?? this.amountValue,
        expenseType: expenseType ?? this.expenseType);
  }

  @override
  List<Object?> get props => [
        status,
        descriptionValue,
        categoryValue,
        amountValue,
        expenseType
      ];
}
