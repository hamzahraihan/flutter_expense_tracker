import 'package:expense_tracker/model/transactions_model.dart';
import 'package:expense_tracker/view/util/expenses_color.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class RecentTransactionsWidget extends StatefulWidget {
  final IconData icon;
  final String title;
  final String description;
  final ExpenseType expenseType;
  final DateTime date;
  final int amount;

  const RecentTransactionsWidget(
      {super.key,
      required this.icon,
      required this.title,
      required this.description,
      required this.expenseType,
      required this.date,
      required this.amount});

  @override
  State<RecentTransactionsWidget> createState() => _RecentTransactionState();
}

class _RecentTransactionState extends State<RecentTransactionsWidget> {
  IconData get icon => widget.icon;
  String get title => widget.title;
  String get description => widget.description;
  ExpenseType get expenseType => widget.expenseType;
  int get amount => widget.amount;
  DateTime get date => widget.date;

  late String convertToIdr =
      NumberFormat.currency(locale: 'id', symbol: 'Rp', decimalDigits: 2)
          .format(amount);
  late String formattedTime = DateFormat.jm().format(date);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
        color: Colors.grey.shade200,
      ),
      padding: const EdgeInsets.all(13.0),
      width: double.infinity,
      height: 85,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Flexible(
            flex: 2,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.0),
                color: ExpensesColor(expenseTitle: title).getColorBackground(),
              ),
              width: 60,
              height: double.infinity,
              child: Icon(
                icon,
                color: ExpensesColor(expenseTitle: title).getColorIcon(),
              ),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            flex: 5,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(title, textAlign: TextAlign.start),
                  Text(description,
                      overflow: TextOverflow.ellipsis,
                      softWrap: true,
                      textAlign: TextAlign.start,
                      style:
                          const TextStyle(color: Colors.black38, fontSize: 12))
                ],
              ),
            ),
          ),
          Expanded(
              flex: 3,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    convertToIdr,
                    style: const TextStyle(fontSize: 12),
                  ),
                  Text(
                    formattedTime,
                    style: const TextStyle(color: Colors.black38, fontSize: 12),
                  )
                ],
              ))
        ],
      ),
    );
  }
}
