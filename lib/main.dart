import 'package:expense_tracker/features/expense/app.dart';
import 'package:expense_tracker/features/expense/presentation/screens/transactions/transactions_screen.dart';
import 'package:expense_tracker/features/expense/presentation/screens/upload/add_expense_screen.dart';
import 'package:expense_tracker/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: '.env.local');
  await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform);

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
          case AddExpenseScreen.routeName:
            initialIndex = 3;
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
