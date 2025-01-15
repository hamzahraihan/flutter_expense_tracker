import 'package:flutter/material.dart';

class IconSelection {
  final String category;
  final Color? color;
  final IconData? icon;
  final Color? colorBackground;

  const IconSelection(
      {required this.category,
      this.color,
      this.icon,
      this.colorBackground});

  IconSelection getColorIcon() {
    Color colorIcon = Colors.white;
    IconData icon = Icons.shopping_bag;
    Color colorBackground = Colors.yellow.shade100;

    switch (category) {
      case 'Shopping':
        icon = Icons.shopping_bag;
        colorIcon = Colors.yellow.shade700;
        colorBackground = Colors.yellow.shade100;
        break;
      case 'Food':
        icon = Icons.lunch_dining_rounded;
        colorIcon = Colors.red.shade700;
        colorBackground = Colors.red.shade100;
        break;
      case 'Subscription':
        icon = Icons.subscriptions;
        colorIcon = Colors.blue.shade700;
        colorBackground = Colors.blue.shade100;
        break;
      case 'Transportation':
        icon = Icons.emoji_transportation_rounded;
        colorIcon = Colors.greenAccent.shade700;
        colorBackground = Colors.greenAccent.shade100;
        break;
    }
    return IconSelection(
        category: category,
        color: colorIcon,
        icon: icon,
        colorBackground: colorBackground);
  }
}
