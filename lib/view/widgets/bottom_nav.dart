import 'package:flutter/material.dart';

class BottomNavigationBarWidget extends StatefulWidget {
  const BottomNavigationBarWidget({super.key});

  @override
  State<BottomNavigationBarWidget> createState() => _BottomNavigationState();
}

class NavButton {
  final IconData icon;
  final String label;

  NavButton({required this.icon, required this.label});
}

class _BottomNavigationState extends State<BottomNavigationBarWidget> {
  int _selectedIndex = 0;
  final List<NavButton> _navButton = [
    NavButton(icon: Icons.home, label: 'Home'),
    NavButton(icon: Icons.payments, label: 'Transactions'),
    NavButton(icon: Icons.pie_chart, label: 'Budget')
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: _navButton.map((item) {
        return BottomNavigationBarItem(
            icon: Icon(item.icon), label: item.label);
      }).toList(),
      currentIndex: _selectedIndex,
      selectedItemColor: Colors.blueAccent.shade200,
      onTap: _onItemTapped,
    );
  }
}
