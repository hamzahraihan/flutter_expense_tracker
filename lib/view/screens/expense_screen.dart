import 'package:expense_tracker/model/transactions_model.dart';
import 'package:expense_tracker/view/widgets/recent_transactions.dart';
import 'package:flutter/material.dart';

class ExpenseScreen extends StatelessWidget {
  const ExpenseScreen({super.key});
  static const String routeName = '/expense';

  @override
  Widget build(BuildContext context) {
    List<TransactionsData> transactions = transactionsDataList;

    return Scaffold(
        body: ListView(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      children: [
        Column(
            children: transactions.map((item) {
          return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: RecentTransactionsWidget(
                  icon: Icons.shopping_bag,
                  title: item.title,
                  description: item.description,
                  expenseType: item.expenseType,
                  date: item.date,
                  amount: item.amount));
        }).toList()),
      ],
    ));
  }
}
