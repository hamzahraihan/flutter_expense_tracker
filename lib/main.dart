import 'package:expense_tracker/features/auth/data/data_source/auth_api_service.dart';
import 'package:expense_tracker/features/auth/data/repository/auth_repository_impl.dart';
import 'package:expense_tracker/features/expense/app.dart';
import 'package:expense_tracker/features/expense/data/data_source/transactions_api_service.dart';
import 'package:expense_tracker/features/expense/data/repository/transaction_repository_impl.dart';
import 'package:expense_tracker/features/expense/presentation/bloc/add_transaction/add_transaction_bloc.dart';
import 'package:expense_tracker/features/expense/presentation/bloc/transaction/firebase/transaction_firebase_bloc.dart';
import 'package:expense_tracker/features/expense/presentation/bloc/transaction/firebase/transaction_firebase_event.dart';
import 'package:expense_tracker/features/expense/presentation/screens/account/account_screen.dart';
import 'package:expense_tracker/features/expense/presentation/screens/transactions/transactions_screen.dart';
import 'package:expense_tracker/features/expense/presentation/screens/upload/add_expense_screen.dart';
import 'package:expense_tracker/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
    final TransactionsApiService transactionsApiService =
        TransactionsApiService();

    final AuthApiService authApiService = AuthApiService();

    final TransactionRepositoryImpl transactionRepository =
        TransactionRepositoryImpl(transactionsApiService);

    final AuthRepositoryImpl authRepository =
        AuthRepositoryImpl(authApiService);

    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) =>
                TransactionFirebaseBloc(transactionRepository)
                  ..add(const GetTransaction()),
          ),
          BlocProvider(
              create: (context) => AddTransactionBloc(
                  context.read<TransactionFirebaseBloc>(),
                  transactionRepository))
        ],
        child: MaterialApp(
          title: 'My Expense',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(
                seedColor: Colors.white,
                brightness: Brightness.light),
            fontFamily: GoogleFonts.inter().fontFamily,
            useMaterial3: true,
          ),
          initialRoute: '/',
          home: ExpenseTrackerApp(
              authUser: authRepository.authUser.first,
              initialIndex: 0),
          onGenerateRoute: (RouteSettings routeSettings) {
            int initialIndex = 0;
            switch (routeSettings.name) {
              case TransactionsScreen.routeName:
                initialIndex = 1;
                break;
              case AddExpenseScreen.routeName:
                initialIndex = 2;
                break;
              case AccountScreen.routeName:
                initialIndex = 3;
                break;
              default:
                initialIndex = 1;
                break;
            }
            return MaterialPageRoute(
                builder: (BuildContext context) => ExpenseTrackerApp(
                    authUser: authRepository.authUser.first,
                    initialIndex: initialIndex),
                settings: routeSettings);
          },
        ));
  }
}
