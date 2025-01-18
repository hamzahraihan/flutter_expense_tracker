import 'package:equatable/equatable.dart';

enum ExpenseType { expense, income }

extension ExpenseTypeExtension on ExpenseType {
  String toShortString() {
    return toString().split('.').last;
  }

  static ExpenseType fromString(String value) {
    return ExpenseType.values
        .firstWhere((e) => e.toShortString() == value);
  }
}

class TransactionEntities extends Equatable {
  final String title;
  final int amount;
  final DateTime date;
  final String description;
  final ExpenseType expenseType;
  final String category;

  const TransactionEntities(
      {required this.title,
      required this.amount,
      required this.date,
      required this.description,
      required this.expenseType,
      required this.category});

  @override
  List<Object?> get props =>
      [title, amount, date, description, expenseType, category];
}
