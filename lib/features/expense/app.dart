import 'dart:developer';

import 'package:expense_tracker/features/auth/domain/entity/auth_entities.dart';
import 'package:expense_tracker/features/expense/presentation/screens/account/account_screen.dart';
import 'package:expense_tracker/features/expense/presentation/screens/home/home_screen.dart';
import 'package:expense_tracker/features/expense/presentation/screens/transactions/transactions_screen.dart';
import 'package:flutter/material.dart';

class ExpenseTrackerApp extends StatefulWidget {
  const ExpenseTrackerApp(
      {super.key,
      required this.initialIndex,
      required this.authUser});
  final AuthEntities authUser;
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
    log('from main screen ${widget.authUser.toString()}');
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
            Icons.account_balance_wallet,
            color: Colors.blueAccent,
          ),
          icon: Icon(
            Icons.account_balance_wallet_outlined,
          ),
          label: 'Account')
    ];

    return Scaffold(
      body: SafeArea(
          child: IndexedStack(
        index: currentPageIndex,
        children: [
          HomeScreen(authUser: widget.authUser),
          TransactionsScreen(
            authUser: widget.authUser,
          ),
          const AccountScreen(),
        ],
      )),

      // bottom navigation bar
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) =>
            _handleNavigation(index, context),
        destinations: navButton,
        selectedIndex: currentPageIndex,
        indicatorColor: Colors.transparent,
        animationDuration: Duration.zero,
      ),
    );
  }
}
