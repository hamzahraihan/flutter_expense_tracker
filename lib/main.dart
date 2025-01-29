import 'dart:developer';

import 'package:expense_tracker/features/auth/data/data_source/auth_api_service.dart';
import 'package:expense_tracker/features/auth/data/repository/auth_repository_impl.dart';
import 'package:expense_tracker/features/auth/domain/entity/auth_entities.dart';
import 'package:expense_tracker/features/auth/domain/usecase/sign_in_credential.dart';
import 'package:expense_tracker/features/auth/domain/usecase/sign_in_google.dart';
import 'package:expense_tracker/features/auth/presentation/bloc/auth/auth_bloc.dart';
import 'package:expense_tracker/features/auth/presentation/bloc/auth/auth_event.dart';
import 'package:expense_tracker/features/auth/presentation/bloc/auth/auth_state.dart';
import 'package:expense_tracker/features/auth/presentation/bloc/sign_in/sign_in_bloc.dart';
import 'package:expense_tracker/features/auth/presentation/screens/sign_in_screen.dart';
import 'package:expense_tracker/features/expense/app.dart';
import 'package:expense_tracker/features/expense/data/data_source/transactions_api_service.dart';
import 'package:expense_tracker/features/expense/data/repository/transaction_repository_impl.dart';
import 'package:expense_tracker/features/expense/domain/usecase/get_transactions.dart';
import 'package:expense_tracker/features/expense/presentation/bloc/add_transaction/add_transaction_bloc.dart';
import 'package:expense_tracker/features/expense/presentation/bloc/transaction/firebase/transaction_firebase_bloc.dart';
import 'package:expense_tracker/features/expense/presentation/bloc/transaction/firebase/transaction_firebase_event.dart';
import 'package:expense_tracker/features/expense/presentation/screens/account/account_screen.dart';
import 'package:expense_tracker/features/expense/presentation/screens/transactions/transactions_screen.dart';
import 'package:expense_tracker/features/expense/presentation/screens/upload/add_expense_screen.dart';
import 'package:expense_tracker/firebase_options.dart';
import 'package:expense_tracker/widgets/loading.dart';
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

  // initialize dependencies
  final AuthApiService authApiService = AuthApiService();

  final TransactionsApiService transactionsApiService =
      TransactionsApiService();

  final TransactionRepositoryImpl transactionRepositoryImpl =
      TransactionRepositoryImpl(transactionsApiService);

  final AuthRepositoryImpl authRepositoryImpl =
      AuthRepositoryImpl(authApiService);

  final SignInWithCredentialUseCase signInWithCredentialUseCase =
      SignInWithCredentialUseCase(authRepositoryImpl);

  final SignInWithGoogleUseCase signInWithGoogle =
      SignInWithGoogleUseCase(authRepositoryImpl);

  final GetTransactionsUseCase getTransactionsUseCase =
      GetTransactionsUseCase(transactionRepositoryImpl);

  runApp(MyApp(
    authRepositoryImpl: authRepositoryImpl,
    signInWithCredentialUseCase: signInWithCredentialUseCase,
    signInWithGoogleUseCase: signInWithGoogle,
    getTransactionsUseCase: getTransactionsUseCase,
    transactionRepositoryImpl: transactionRepositoryImpl,
    authUser: await authRepositoryImpl.authUser.first,
  ));
}

class MyApp extends StatelessWidget {
  final AuthRepositoryImpl authRepositoryImpl;
  final SignInWithCredentialUseCase signInWithCredentialUseCase;
  final SignInWithGoogleUseCase signInWithGoogleUseCase;
  final GetTransactionsUseCase getTransactionsUseCase;
  final TransactionRepositoryImpl transactionRepositoryImpl;
  final AuthEntities? authUser;

  const MyApp(
      {super.key,
      required this.authUser,
      required this.authRepositoryImpl,
      required this.getTransactionsUseCase,
      required this.signInWithCredentialUseCase,
      required this.signInWithGoogleUseCase,
      required this.transactionRepositoryImpl});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (context) => AuthBloc(authRepositoryImpl)
                ..add(Authenticated(authUser))),
          BlocProvider(
              create: (context) => SignInBloc(
                  signInWithCredentialUseCase,
                  signInWithGoogleUseCase)),
          BlocProvider(
            create: (context) =>
                TransactionFirebaseBloc(transactionRepositoryImpl)
                  ..add(const GetTransaction()),
          ),
          BlocProvider(
              create: (context) => AddTransactionBloc(
                  context.read<TransactionFirebaseBloc>(),
                  transactionRepositoryImpl))
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
          // home: ExpenseTrackerApp(
          //     authUser: authRepositoryImpl.authUser.first,
          //     initialIndex: 0),
          onGenerateRoute: (RouteSettings routeSettings) {
            return MaterialPageRoute(
                builder: (BuildContext context) {
                  return BlocBuilder<AuthBloc, AuthState>(builder:
                      (BuildContext context, AuthState state) {
                    log("${state.authStatus}");
                    log("${state.user}");
                    switch (state.authStatus) {
                      case AuthStatus.loading:
                        return const Loading();
                      case AuthStatus.unauthenticated:
                        return const SignInScreen();
                      case AuthStatus.authenticated:
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
                            initialIndex = 0;
                            break;
                        }

                        return ExpenseTrackerApp(
                            authUser: authUser,
                            initialIndex: initialIndex);
                      default:
                        return const SignInScreen();
                    }
                  });
                },
                settings: routeSettings);
          },
        ));
  }
}
