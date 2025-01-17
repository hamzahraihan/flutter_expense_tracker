import 'package:expense_tracker/features/expense/presentation/widgets/recent_transactions.dart';
import 'package:expense_tracker/model/transactions_model.dart';
import 'package:flutter/material.dart';

class TransactionsList extends StatefulWidget {
  final List<TransactionsModel> transactionData;
  final String dateTitle;
  const TransactionsList(
      {super.key,
      required this.transactionData,
      required this.dateTitle});
  @override
  State<TransactionsList> createState() => _TransactionsListState();
}

class _TransactionsListState extends State<TransactionsList> {
  String get title => widget.dateTitle;
  List<TransactionsModel> get transactions => widget.transactionData;

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: transactions.isNotEmpty
            ? [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(
                    title,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                Column(
                    children: transactions.map((item) {
                  return Padding(
                      padding:
                          const EdgeInsets.symmetric(vertical: 4.0),
                      child: RecentTransactionsWidget(
                        title: item.title,
                        description: item.description,
                        expenseType: item.expenseType,
                        date: item.date,
                        amount: item.amount,
                        category: item.category,
                      ));
                }).toList()),
              ]
            : []);
  }
}
