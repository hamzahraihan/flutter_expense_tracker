import 'package:flutter/material.dart';

class IconSelection {
  final String category;
  final Color? color;
  final IconData? icon;

  const IconSelection(
      {required this.category, this.color, this.icon});

  Color getColorBackground() {
    Color colorBackground = Colors.white;
    switch (category) {
      case 'Shopping':
        colorBackground = Colors.yellow.shade100;
      case 'Food':
        colorBackground = Colors.red.shade100;
      case 'Subscription':
        colorBackground = Colors.blue.shade100;
    }
    return colorBackground;
  }

  IconSelection getColorIcon() {
    Color colorIcon = Colors.white;
    IconData icon = Icons.shopping_bag;
    switch (category) {
      case 'Shopping':
        icon = Icons.shopping_bag;
        colorIcon = Colors.yellow.shade700;
        break;
      case 'Food':
        icon = Icons.lunch_dining_rounded;
        colorIcon = Colors.red.shade700;
        break;
      case 'Subscription':
        icon = Icons.subscriptions;
        colorIcon = Colors.blue.shade700;
        break;
    }
    return IconSelection(
        category: category, color: colorIcon, icon: icon);
  }
}
