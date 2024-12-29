import 'package:flutter/material.dart';

class RecentTransactionsWidget extends StatefulWidget {
  final IconData icon;
  final String title;
  final String description;
  const RecentTransactionsWidget(
      {super.key,
      required this.icon,
      required this.title,
      required this.description});

  @override
  State<RecentTransactionsWidget> createState() => _RecentTransactionState();
}

class _RecentTransactionState extends State<RecentTransactionsWidget> {
  IconData get icon => widget.icon;
  String get title => widget.title;
  String get description => widget.description;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
        color: Colors.grey.shade100,
      ),
      padding: const EdgeInsets.all(16.0),
      width: double.infinity,
      height: 100,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.0),
              color: Colors.white,
            ),
            padding: const EdgeInsets.all(16.0),
            child: Icon(icon),
          ),
          const SizedBox(width: 10,),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.0),
                color: Colors.white,
              ),
              padding: const EdgeInsets.all(16.0),
              child: Icon(icon),
            ),
          )
        ],
      ),
    );
  }
}
