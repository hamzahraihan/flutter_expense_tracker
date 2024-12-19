import 'package:flutter/material.dart';

class IncomeExpensesCardWidget extends StatefulWidget {
  final String title;
  final double amount;

  const IncomeExpensesCardWidget(
      {super.key, required this.title, required this.amount});

  @override
  State<IncomeExpensesCardWidget> createState() => _IncomeExpensesCardWidget();
}

class _IncomeExpensesCardWidget extends State<IncomeExpensesCardWidget> {
  String get title => widget.title;
  double get amount => widget.amount;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: Card(
          color: Colors.teal[100],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Colors.white,
                ),
                child: const Icon(Icons.monetization_on),
              ),
              Container(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [Text(title), Text(amount.toString())],
                ),
              ),
            ],
          )),
    );
  }
}
