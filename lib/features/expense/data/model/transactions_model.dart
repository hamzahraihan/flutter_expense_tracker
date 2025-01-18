import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_tracker/features/expense/domain/entitiy/transaction_entities.dart';

extension ExpenseTypeExtension on ExpenseType {
  String toShortString() {
    return toString().split('.').last;
  }

  static ExpenseType fromString(String value) {
    return ExpenseType.values.firstWhere((ExpenseType e) =>
        ExpenseTypeExtension(e).toShortString() == value);
  }
}

class TransactionsModel extends TransactionEntities {
  const TransactionsModel(
      {required super.title,
      required super.amount,
      required super.date,
      required super.description,
      required super.expenseType,
      required super.category});

  factory TransactionsModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return TransactionsModel(
        title: data?['title'],
        amount: data?['amount'],
        date: (data?['date'] as Timestamp).toDate(),
        description: data?['description'],
        expenseType:
            ExpenseTypeExtension.fromString(data?['expenseType']),
        category: data?['category']);
  }

  Map<String, dynamic> toFirestore() {
    return {
      "title": title,
      "amount": amount,
      "date": date,
      "description": description,
      "expenseType":
          ExpenseTypeExtension(expenseType).toShortString(),
      "category": category
    };
  }
}

class GroupedTransactions {
  final List<TransactionsModel> today;
  final List<TransactionsModel> yesterady;
  final List<TransactionsModel> thisWeek;
  final List<TransactionsModel> thisMonth;
  final List<TransactionsModel> older;

  GroupedTransactions(
      {required this.today,
      required this.yesterady,
      required this.thisWeek,
      required this.thisMonth,
      required this.older});
}

class Transactions {
  static GroupedTransactions filterTransactionsByDate(
      List<TransactionsModel> transactions) {
    transactions.sort((a, b) {
      return -a.date.compareTo(b.date);
    });
    final DateTime now = DateTime.now();

    final DateTime today = DateTime(now.year, now.month, now.day);

    final DateTime yesterday =
        today.subtract(const Duration(days: 1));

    final DateTime thisWeek =
        today.subtract(Duration(days: today.weekday - 1));
    final DateTime thisMonth = DateTime(today.year, today.month, 1);

    final List<TransactionsModel> todayTransactions = [];
    final List<TransactionsModel> yesterdayTransactions = [];
    final List<TransactionsModel> thisWeekTransactions = [];
    final List<TransactionsModel> thisMonthTransaction = [];
    final List<TransactionsModel> olderTransactions = [];

    for (final TransactionsModel transaction in transactions) {
      final DateTime transactionDate = DateTime(transaction.date.year,
          transaction.date.month, transaction.date.day);

      // push today transaction to todayTransactions List
      if (transactionDate == today) {
        todayTransactions.add(transaction);
      }

      // push yesterday transaction to yesterdayTransactions List
      if (transactionDate == yesterday) {
        yesterdayTransactions.add(transaction);
      }

      // push week transaction to weekTransactions List
      if (transactionDate.isAfter(thisWeek)) {
        thisWeekTransactions.add(transaction);
      }

      // push month transaction to monthTransactions List
      if (transactionDate.isAfter(thisMonth)) {
        thisMonthTransaction.add(transaction);
      }

      // push older transaction to olderTransactions List
      olderTransactions.add(transaction);
    }
    return GroupedTransactions(
        today: todayTransactions,
        yesterady: yesterdayTransactions,
        thisWeek: thisWeekTransactions,
        thisMonth: thisMonthTransaction,
        older: olderTransactions);
  }
}


// List<TransactionsModel> transactionsDataList = [
//   TransactionsModel(
//       id: 1,
//       title: 'Coffee',
//       amount: 35000,
//       date: DateTime(2025, 1, 8, 9, 30), // Today
//       description: 'Morning coffee at Starbucks',
//       expenseType: ExpenseType.expense),
//   TransactionsModel(
//       id: 2,
//       title: 'Lunch',
//       amount: 75000,
//       date: DateTime(2025, 1, 8, 12, 45), // Today
//       description: 'Lunch with colleagues',
//       expenseType: ExpenseType.expense),
//   TransactionsModel(
//       id: 3,
//       title: 'Taxi',
//       amount: 50000,
//       date: DateTime(2025, 1, 7, 18, 30), // Yesterday
//       description: 'Taxi ride home from office',
//       expenseType: ExpenseType.expense),
//   TransactionsModel(
//       id: 4,
//       title: 'Groceries',
//       amount: 250000,
//       date: DateTime(2025, 1, 7, 14, 20), // Yesterday
//       description: 'Weekly grocery shopping',
//       expenseType: ExpenseType.expense),
//   TransactionsModel(
//       id: 5,
//       title: 'Movie Tickets',
//       amount: 100000,
//       date: DateTime(2025, 1, 6, 19, 00), // 2 days ago
//       description: 'Weekend movie with friends',
//       expenseType: ExpenseType.expense),
//   TransactionsModel(
//       id: 6,
//       title: 'Salary',
//       amount: 8000000,
//       date: DateTime(2025, 1, 5, 10, 00), // 3 days ago
//       description: 'Monthly salary deposit',
//       expenseType: ExpenseType.income),
//   TransactionsModel(
//       id: 7,
//       title: 'Internet Bill',
//       amount: 400000,
//       date: DateTime(2025, 1, 4, 15, 30), // 4 days ago
//       description: 'Monthly internet subscription',
//       expenseType: ExpenseType.expense),
//   TransactionsModel(
//       id: 8,
//       title: 'Gym',
//       amount: 350000,
//       date: DateTime(2025, 1, 3, 8, 00), // 5 days ago
//       description: 'Monthly gym membership',
//       expenseType: ExpenseType.expense),
//   TransactionsModel(
//       id: 9,
//       title: 'Online Shopping',
//       amount: 450000,
//       date: DateTime(2025, 1, 2, 13, 15), // 6 days ago
//       description: 'Clothes from online store',
//       expenseType: ExpenseType.expense),
//   TransactionsModel(
//       id: 10,
//       title: 'Phone Bill',
//       amount: 200000,
//       date: DateTime(2025, 1, 1, 11, 30), // 7 days ago
//       description: 'Monthly phone bill payment',
//       expenseType: ExpenseType.expense),
// ];
