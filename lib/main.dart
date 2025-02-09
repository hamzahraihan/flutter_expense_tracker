import 'dart:developer';

import 'package:expense_tracker/features/auth/data/data_source/auth_api_service.dart';
import 'package:expense_tracker/features/auth/data/repository/auth_repository_impl.dart';
import 'package:expense_tracker/features/auth/domain/entity/auth_user_entities.dart';
import 'package:expense_tracker/features/auth/domain/usecase/sign_in.dart';
import 'package:expense_tracker/features/auth/domain/usecase/sign_up.dart';
import 'package:expense_tracker/features/auth/presentation/bloc/auth/auth_bloc.dart';
import 'package:expense_tracker/features/auth/presentation/bloc/auth/auth_event.dart';
import 'package:expense_tracker/features/auth/presentation/bloc/auth/auth_state.dart';
import 'package:expense_tracker/features/auth/presentation/bloc/sign_in/sign_in_bloc.dart';
import 'package:expense_tracker/features/auth/presentation/bloc/sign_up/sign_up_bloc.dart';
import 'package:expense_tracker/features/auth/presentation/screens/onboarding_screen.dart';
import 'package:expense_tracker/features/auth/presentation/screens/sign_in_screen.dart';
import 'package:expense_tracker/features/auth/presentation/screens/sign_up_screen.dart';
import 'package:expense_tracker/features/expense/app.dart';
import 'package:expense_tracker/features/expense/data/data_source/transactions_api_service.dart';
import 'package:expense_tracker/features/expense/data/repository/transaction_repository_impl.dart';
import 'package:expense_tracker/features/expense/domain/usecase/add_account_wallet.dart';
import 'package:expense_tracker/features/expense/domain/usecase/add_expense.dart';
import 'package:expense_tracker/features/expense/domain/usecase/get_account_wallet.dart';
import 'package:expense_tracker/features/expense/domain/usecase/get_transactions.dart';
import 'package:expense_tracker/features/expense/presentation/bloc/account_wallet/account_bloc.dart';
import 'package:expense_tracker/features/expense/presentation/bloc/account_wallet/account_event.dart';
import 'package:expense_tracker/features/expense/presentation/bloc/add_transaction/add_transaction_bloc.dart';
import 'package:expense_tracker/features/expense/presentation/bloc/transaction/firebase/transaction_firebase_bloc.dart';
import 'package:expense_tracker/features/expense/presentation/bloc/transaction/firebase/transaction_firebase_event.dart';
import 'package:expense_tracker/features/expense/presentation/screens/account/account_screen.dart';
import 'package:expense_tracker/features/expense/presentation/screens/transactions/transactions_screen.dart';
import 'package:expense_tracker/features/expense/presentation/screens/upload/add_expense_screen.dart';
import 'package:expense_tracker/features/expense/presentation/screens/upload/add_income_screen.dart';
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

  final AddExpenseUseCase addExpenseUseCase =
      AddExpenseUseCase(transactionRepositoryImpl);

  final AuthRepositoryImpl authRepositoryImpl =
      AuthRepositoryImpl(authApiService);

  final SignInUseCase signInUseCase =
      SignInUseCase(authRepositoryImpl);

  final SignUpUseCase signUpUseCase =
      SignUpUseCase(authRepositoryImpl);

  final AddAccountWalletUseCase addAccountWalletUseCase =
      AddAccountWalletUseCase(transactionRepositoryImpl);

  final GetAccountWalletUseCase getAccountWalletUseCase =
      GetAccountWalletUseCase(transactionRepositoryImpl);

  final GetTransactionsUseCase getTransactionsUseCase =
      GetTransactionsUseCase(transactionRepositoryImpl);

  runApp(MyApp(
      authRepositoryImpl: authRepositoryImpl,
      signInUseCase: signInUseCase,
      signUpUseCase: signUpUseCase,
      getTransactionsUseCase: getTransactionsUseCase,
      addAccountWalletUseCase: addAccountWalletUseCase,
      getAccountWalletUseCase: getAccountWalletUseCase,
      transactionRepositoryImpl: transactionRepositoryImpl,
      addExpenseUseCase: addExpenseUseCase,
      authUser: authRepositoryImpl.authUser));
}

class MyApp extends StatelessWidget {
  final AuthRepositoryImpl authRepositoryImpl;
  final SignInUseCase signInUseCase;
  final SignUpUseCase signUpUseCase;
  final AddExpenseUseCase addExpenseUseCase;
  final GetTransactionsUseCase getTransactionsUseCase;
  final TransactionRepositoryImpl transactionRepositoryImpl;
  final AddAccountWalletUseCase addAccountWalletUseCase;
  final GetAccountWalletUseCase getAccountWalletUseCase;
  final Stream<AuthUserEntities> authUser;

  const MyApp(
      {super.key,
      required this.authUser,
      required this.authRepositoryImpl,
      required this.getTransactionsUseCase,
      required this.getAccountWalletUseCase,
      required this.addAccountWalletUseCase,
      required this.signInUseCase,
      required this.signUpUseCase,
      required this.addExpenseUseCase,
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
                    signInUseCase,
                  )),
          BlocProvider(
              create: (context) => SignUpBloc(
                    signUpUseCase,
                  )),
          BlocProvider(
            create: (context) => TransactionFirebaseBloc(
                transactionRepositoryImpl, authUser)
              ..add(const GetTransaction()),
          ),
          BlocProvider(
            create: (context) {
              // create authStream variable to addTransactionBloc because somehow passing authUser doesn't work.
              final authStream = authRepositoryImpl.authUser;

              return AddTransactionBloc(
                context.read<TransactionFirebaseBloc>(),
                addExpenseUseCase,
                authStream,
              );
            },
          ),
          BlocProvider(
              create: (context) => AccountBloc(
                  addAccountWalletUseCase, getAccountWalletUseCase)
                ..add(const GetAccountWallet()))
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
                    log("from auth state staus ${state.authStatus}");
                    log("from auth state ${state.user}");
                    switch (state.authStatus) {
                      case AuthStatus.loading:
                        return const Loading();
                      case AuthStatus.unauthenticated:
                        switch (routeSettings.name) {
                          case SignUpScreen.routeName:
                            return const SignUpScreen();
                          case SignInScreen.routeName:
                            return const SignInScreen();
                          default:
                            return const OnboardingScreen();
                        }
                      case AuthStatus.authenticated:
                        int initialIndex = 0;
                        switch (routeSettings.name) {
                          case TransactionsScreen.routeName:
                            initialIndex = 1;
                            break;
                          case AccountScreen.routeName:
                            initialIndex = 2;
                            break;
                          case AddExpenseScreen.routeName:
                            return const AddExpenseScreen();
                          case AddIncomeScreen.routeName:
                            return const AddIncomeScreen();
                          default:
                            initialIndex = 0;
                            break;
                        }

                        return ExpenseTrackerApp(
                            authUser: state.user,
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
