import 'package:flutter/material.dart';

class ExpensesColor {
  final String expenseTitle;

  const ExpensesColor({required this.expenseTitle});

  Color getColorBackground() {
    Color colorBackground = Colors.white;
    switch (expenseTitle) {
      case 'Shopping':
        colorBackground = Colors.yellow.shade100;
      case 'Food':
        colorBackground = Colors.red.shade100;
      case 'Subscription':
        colorBackground = Colors.blue.shade100;
    }
    return colorBackground;
  }

  Color getColorIcon() {
    Color colorIcon = Colors.white;
    switch (expenseTitle) {
      case 'Shopping':
        colorIcon = Colors.yellow.shade700;
      case 'Food':
        colorIcon = Colors.red.shade700;
      case 'Subscription':
        colorIcon = Colors.blue.shade700;
    }
    return colorIcon;
  }
}
