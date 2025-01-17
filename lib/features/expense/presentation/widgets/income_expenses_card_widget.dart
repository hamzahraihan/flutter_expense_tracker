import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class IncomeExpensesCardWidget extends StatefulWidget {
  final String title;
  final int amount;
  final IconData icon;
  final Color color;
  const IncomeExpensesCardWidget(
      {super.key,
      required this.title,
      required this.amount,
      required this.icon,
      required this.color});

  @override
  State<IncomeExpensesCardWidget> createState() =>
      _IncomeExpensesCardWidget();
}

class _IncomeExpensesCardWidget
    extends State<IncomeExpensesCardWidget> {
  String get title => widget.title;
  int get amount => widget.amount;
  IconData get icon => widget.icon;
  Color get color => widget.color;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24.0),
        color: color,
      ),
      width: double.infinity,
      child: Container(
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: Colors.white10,
            borderRadius: BorderRadius.circular(18)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                  fontSize: 14.0, color: Colors.white),
            ),
            Text(
              NumberFormat.currency(
                      decimalDigits: 0,
                      locale: 'id-ID',
                      symbol: 'Rp.')
                  .format(amount),
              style: const TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w800,
                  color: Colors.white),
            )
          ],
        ),
      ),
    );
  }
}
