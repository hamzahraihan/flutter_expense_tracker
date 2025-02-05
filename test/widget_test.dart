// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:expense_tracker/features/auth/data/data_source/auth_api_service.dart';
import 'package:expense_tracker/features/auth/data/repository/auth_repository_impl.dart';
import 'package:expense_tracker/features/auth/domain/usecase/sign_in.dart';
import 'package:expense_tracker/features/auth/domain/usecase/sign_up.dart';
import 'package:expense_tracker/features/expense/data/data_source/transactions_api_service.dart';
import 'package:expense_tracker/features/expense/data/repository/transaction_repository_impl.dart';
import 'package:expense_tracker/features/expense/domain/usecase/add_account_wallet.dart';
import 'package:expense_tracker/features/expense/domain/usecase/get_account_wallet.dart';
import 'package:expense_tracker/features/expense/domain/usecase/get_transactions.dart';
import 'package:expense_tracker/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final AuthApiService authApiService = AuthApiService();

  final TransactionsApiService transactionsApiService =
      TransactionsApiService();

  final TransactionRepositoryImpl transactionRepositoryImpl =
      TransactionRepositoryImpl(transactionsApiService);

  final AuthRepositoryImpl authRepositoryImpl =
      AuthRepositoryImpl(authApiService);

  final SignInUseCase signInUseCase =
      SignInUseCase(authRepositoryImpl);

  final SignUpUseCase signUpUseCase =
      SignUpUseCase(authRepositoryImpl);

  final GetTransactionsUseCase getTransactionsUseCase =
      GetTransactionsUseCase(transactionRepositoryImpl);

  final GetAccountWalletUseCase getAccountWalletUseCase =
      GetAccountWalletUseCase(transactionRepositoryImpl);

  final AddAccountWalletUseCase addAccountWalletUseCase =
      AddAccountWalletUseCase(transactionRepositoryImpl);
  testWidgets('Counter increments smoke test',
      (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MyApp(
        authUser: await authRepositoryImpl.authUser.first,
        authRepositoryImpl: authRepositoryImpl,
        getTransactionsUseCase: getTransactionsUseCase,
        signInUseCase: signInUseCase,
        signUpUseCase: signUpUseCase,
        getAccountWalletUseCase: getAccountWalletUseCase,
        addAccountWalletUseCase: addAccountWalletUseCase,
        transactionRepositoryImpl: transactionRepositoryImpl));

    // Verify that our counter starts at 0.
    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    // Tap the '+' icon and trigger a frame.
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    // Verify that our counter has incremented.
    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);
  });
}
