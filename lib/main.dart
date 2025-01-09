import 'package:expense_tracker/view/screens/app.dart';
import 'package:expense_tracker/view/screens/transactions_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_strategy/url_strategy.dart';

void main() {
  setPathUrlStrategy();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Expense',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.white, brightness: Brightness.light),
        fontFamily: GoogleFonts.inter().fontFamily,
        useMaterial3: true,
      ),
      initialRoute: '/',
      home: const ExpenseTrackerApp(initialIndex: 0),
      onGenerateRoute: (RouteSettings routeSettings) {
        int initialIndex = 0;
        switch (routeSettings.name) {
          case TransactionsScreen.routeName:
            initialIndex = 1;
            break;
          case '/budget':
            initialIndex = 2;
            break;
          default:
            initialIndex = 0;
            break;
        }
        return MaterialPageRoute(
            builder: (BuildContext context) =>
                ExpenseTrackerApp(initialIndex: initialIndex),
            settings: routeSettings);
      },
    );
  }
}
