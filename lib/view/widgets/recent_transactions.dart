import 'package:flutter/material.dart';

class RecentTransactionsWidget extends StatefulWidget {
  final Icon icon;
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
  Icon get icon => widget.icon;
  String get title => widget.title;
  String get description => widget.description;

  @override
  Widget build(BuildContext context) {
    return const Row(children: [Text('Test')]);
  }
}
