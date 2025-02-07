import 'package:expense_tracker/features/auth/domain/entity/auth_user_entities.dart';
import 'package:expense_tracker/features/expense/data/model/account_wallet_model.dart';
import 'package:expense_tracker/features/expense/data/model/transactions_model.dart';

abstract class TransactionRepository {
  Future<List<TransactionsModel>> getTransactions(
      AuthUserEntities authUser);

  Future<List<AccountWalletModel>> getAccountWallet();

  // Future<void> savedTransaction(String id);

  Future<void> deleteTransaction(String id);

  Future<void> addExpenseTransaction(
      Map<String, dynamic> transaction);

  Future<void> addAccountWallet(Map<String, dynamic> accountWallet);
}
