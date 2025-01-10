import 'package:expense_tracker/view/screens/home/home_screen.dart';
import 'package:expense_tracker/view/screens/transactions/transactions_screen.dart';

import 'package:flutter/material.dart';

class ExpenseTrackerApp extends StatefulWidget {
  const ExpenseTrackerApp({super.key, required this.initialIndex});
  final int initialIndex;
  @override
  State<ExpenseTrackerApp> createState() => _ExpenseTrackerAppState();
}

class _ExpenseTrackerAppState extends State<ExpenseTrackerApp> {
  late int currentPageIndex = 0;

  // final List<String> _routes = ['/', '/expense', '/budget'];

  void _handleNavigation(int index, BuildContext context) {
    setState(() {
      currentPageIndex = index;
    });

    // Navigator.of(context).pushReplacementNamed(_routes[index]);
  }

  @override
  void initState() {
    super.initState();
    currentPageIndex = widget.initialIndex;
  }

  @override
  Widget build(BuildContext context) {
    final List<NavigationDestination> navButton = [
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
            Icons.pie_chart,
            color: Colors.blueAccent,
          ),
          icon: Icon(
            Icons.pie_chart_outline,
          ),
          label: 'Budget')
    ];

    return Scaffold(
      body: SafeArea(
          child: IndexedStack(
        index: currentPageIndex,
        children: const [
          HomeScreen(),
          TransactionsScreen(),
          Placeholder(), // Budget screen placeholder
        ],
      )),

      // bottom navigation bar
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) => _handleNavigation(index, context),
        destinations: navButton,
        selectedIndex: currentPageIndex,
        indicatorColor: Colors.white24,
        animationDuration: Duration.zero,
      ),
    );
  }
}
