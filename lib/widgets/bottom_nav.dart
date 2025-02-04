import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BottomNavigationBarWidget extends StatefulWidget {
  const BottomNavigationBarWidget({super.key});

  @override
  State<BottomNavigationBarWidget> createState() =>
      _BottomNavigationState();
}

class _BottomNavigationState
    extends State<BottomNavigationBarWidget> {
  int currentPageIndex = 0;
  final List<NavigationDestination> _navButton = [
    const NavigationDestination(
        selectedIcon: Icon(
          Icons.home,
          color: Colors.blueAccent,
        ),
        icon: Icon(Icons.home_outlined),
        label: 'Home'),
    const NavigationDestination(
      selectedIcon: Icon(
        Icons.payments,
        color: Colors.blueAccent,
      ),
      icon: Icon(Icons.payments_outlined),
      label: 'Transactions',
    ),
    const NavigationDestination(
        selectedIcon: Icon(
          FontAwesomeIcons.chartPie,
          color: Colors.blueAccent,
        ),
        icon: Icon(
          FontAwesomeIcons.chartPie,
        ),
        label: 'Budget')
  ];

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      onDestinationSelected: (int index) {
        setState(() {
          currentPageIndex = index;
        });
      },
      destinations: _navButton,
      selectedIndex: currentPageIndex,
      indicatorColor: Colors.white24,
    );
  }
}
