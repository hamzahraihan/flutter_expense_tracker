import 'package:expense_tracker/view/screens/add_expense/add_expense_screen.dart';
import 'package:expense_tracker/view/screens/home/home_screen.dart';
import 'package:expense_tracker/view/screens/transactions/transactions_screen.dart';

import 'package:flutter/material.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';

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

  void _handleExpandableNavigation(BuildContext context, screen) {
    setState(() {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => screen));
    });
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
        onDestinationSelected: (int index) =>
            _handleNavigation(index, context),
        destinations: navButton,
        selectedIndex: currentPageIndex,
        indicatorColor: Colors.white24,
        animationDuration: Duration.zero,
      ),
      floatingActionButtonLocation: ExpandableFab.location,
      floatingActionButton: ExpandableFab(
          openButtonBuilder: RotateFloatingActionButtonBuilder(
            child: const Icon(Icons.add),
            fabSize: ExpandableFabSize.regular,
            foregroundColor: Colors.white,
            backgroundColor: Colors.blueAccent,
            shape: const CircleBorder(),
          ),
          closeButtonBuilder: RotateFloatingActionButtonBuilder(
            child: const Icon(Icons.close),
            fabSize: ExpandableFabSize.regular,
            foregroundColor: Colors.white,
            backgroundColor: Colors.blueAccent,
            shape: const CircleBorder(),
          ),
          distance: 80,
          children: [
            FloatingActionButton.small(
              heroTag: 'expense button',
              tooltip: 'expense',
              foregroundColor: Colors.white,
              backgroundColor: Colors.red.shade500,
              shape: const CircleBorder(),
              onPressed: () => _handleExpandableNavigation(
                  context, const AddExpenseScreen()),
              child: const Icon(Icons.trending_down),
            ),
            FloatingActionButton.small(
              heroTag: 'income button',
              tooltip: 'income',
              foregroundColor: Colors.white,
              backgroundColor: Colors.green.shade500,
              shape: const CircleBorder(),
              // TODO MAKE AN ADD INCOME SCREEN
              onPressed: () => _handleExpandableNavigation(
                  context, const Placeholder()),
              child: const Icon(Icons.trending_up),
            ),
          ]),
    );
  }
}
