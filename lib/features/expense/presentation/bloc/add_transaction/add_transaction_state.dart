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
  final String titleValue;
  final String descriptionValue;
  final String categoryValue;
  final int amountValue;

  const AddTransactionState(
      {this.status = AddTransactionStatus.initial,
      this.descriptionValue = '',
      this.titleValue = '',
      this.amountValue = 0,
      this.categoryValue = ''});

  AddTransactionState copyWith(
      {AddTransactionStatus? status,
      String? titleValue,
      String? descriptionValue,
      String? categoryValue,
      int? amountValue}) {
    return AddTransactionState(
      status: status ?? this.status,
      titleValue: titleValue ?? this.titleValue,
      descriptionValue: descriptionValue ?? this.descriptionValue,
      categoryValue: categoryValue ?? this.categoryValue,
      amountValue: amountValue ?? this.amountValue,
    );
  }

  @override
  List<Object?> get props => [
        status,
        titleValue,
        descriptionValue,
        categoryValue,
        amountValue
      ];
}
