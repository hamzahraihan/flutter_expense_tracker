import 'package:flutter/material.dart';

class ExpensesColor {
  final String expenseTitle;

  const ExpensesColor({required this.expenseTitle});

  Color getColor() {
    Color color = Colors.white;
    switch (expenseTitle) {
      case 'Shopping':
        color = Colors.red;
      case 'Food':
        color = Colors.green;
      case 'Subscription':
        color = Colors.blue;
    }
    return color;
  }
}
