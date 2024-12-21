import 'package:flutter/material.dart';

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
  State<IncomeExpensesCardWidget> createState() => _IncomeExpensesCardWidget();
}

class _IncomeExpensesCardWidget extends State<IncomeExpensesCardWidget> {
  String get title => widget.title;
  int get amount => widget.amount;
  IconData get icon => widget.icon;
  Color get color => widget.color;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: double.infinity,
      child: Card(
          color: color,
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
                  padding: const EdgeInsets.all(4.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14.0),
                    color: Colors.white,
                  ),
                  child: Icon(icon, size: 42.0),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(fontSize: 14.0, color: Colors.white),
                  ),
                  Text(
                    '\$${amount.toString()}',
                    style: const TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w800,
                        color: Colors.white),
                  )
                ],
              ),
            ],
          )),
    );
  }
}
