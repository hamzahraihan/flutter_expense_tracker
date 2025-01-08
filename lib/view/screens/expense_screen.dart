import 'package:expense_tracker/model/transactions_model.dart';
import 'package:expense_tracker/view/widgets/recent_transactions.dart';
import 'package:flutter/material.dart';

class ExpenseScreen extends StatelessWidget {
  const ExpenseScreen({super.key});
  static const String routeName = '/expense';

  @override
  Widget build(BuildContext context) {
    final List<TransactionsModel> todayTransactions =
        Transactions.filterTransactionsByDate(transactionsDataList).today;
    final List<TransactionsModel> yesterdayTransactions =
        Transactions.filterTransactionsByDate(transactionsDataList).yesterady;
    final List<TransactionsModel> thisWeekTransactions =
        Transactions.filterTransactionsByDate(transactionsDataList).thisWeek;
    final List<TransactionsModel> thisMonthTransaction =
        Transactions.filterTransactionsByDate(transactionsDataList).thisMonth;
    final List<TransactionsModel> olderTransactions =
        Transactions.filterTransactionsByDate(transactionsDataList).older;

    return Scaffold(
        body: SafeArea(
            child: ListView(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 8.0),
          child: Text(
            'Today',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        Column(
            children: todayTransactions.map((item) {
          return Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: RecentTransactionsWidget(
                  icon: Icons.shopping_bag,
                  title: item.title,
                  description: item.description,
                  expenseType: item.expenseType,
                  date: item.date,
                  amount: item.amount));
        }).toList()),
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 8.0),
          child: Text(
            'Yesterday',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        Column(
            children: yesterdayTransactions.map((item) {
          return Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: RecentTransactionsWidget(
                  icon: Icons.shopping_bag,
                  title: item.title,
                  description: item.description,
                  expenseType: item.expenseType,
                  date: item.date,
                  amount: item.amount));
        }).toList()),
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 8.0),
          child: Text(
            'This Week',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        Column(
            children: thisWeekTransactions.map((item) {
          return Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: RecentTransactionsWidget(
                  icon: Icons.shopping_bag,
                  title: item.title,
                  description: item.description,
                  expenseType: item.expenseType,
                  date: item.date,
                  amount: item.amount));
        }).toList()),
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 8.0),
          child: Text(
            'This Month',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        Column(
            children: thisMonthTransaction.map((item) {
          return Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: RecentTransactionsWidget(
                  icon: Icons.shopping_bag,
                  title: item.title,
                  description: item.description,
                  expenseType: item.expenseType,
                  date: item.date,
                  amount: item.amount));
        }).toList()),
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 8.0),
          child: Text(
            'Older',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        Column(
            children: olderTransactions.map((item) {
          return Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: RecentTransactionsWidget(
                  icon: Icons.shopping_bag,
                  title: item.title,
                  description: item.description,
                  expenseType: item.expenseType,
                  date: item.date,
                  amount: item.amount));
        }).toList()),
      ],
    )));
  }
}
