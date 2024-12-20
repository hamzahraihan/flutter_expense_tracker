import 'package:flutter/material.dart';

class IncomeExpensesCardWidget extends StatefulWidget {
  final String title;
  final int amount;

  const IncomeExpensesCardWidget(
      {super.key, required this.title, required this.amount});

  @override
  State<IncomeExpensesCardWidget> createState() => _IncomeExpensesCardWidget();
}

class _IncomeExpensesCardWidget extends State<IncomeExpensesCardWidget> {
  String get title => widget.title;
  int get amount => widget.amount;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: double.infinity,
      child: Card(
          color: Colors.teal[100],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(
                flex: 1,
                child: Container(
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Colors.white,
                  ),
                  child: const Icon(Icons.monetization_on),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(fontSize: 14.0),
                  ),
                  Text(
                    '\$${amount.toString()}',
                    style: const TextStyle(
                        fontSize: 18.0, fontWeight: FontWeight.w800),
                  )
                ],
              ),
            ],
          )),
    );
  }
}
