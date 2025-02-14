import 'package:expense_tracker/features/auth/domain/entity/auth_user_entities.dart';
import 'package:expense_tracker/features/expense/data/model/account_wallet_model.dart';
import 'package:expense_tracker/features/expense/data/model/transactions_model.dart';

abstract class TransactionRepository {
  Future<List<TransactionsModel>> getTransactions(
      AuthUserEntities authUser);

  Future<List<AccountWalletModel>> getAccountWallet(
      String walletId, AuthUserEntities authUser);

  // Future<void> savedTransaction(String id);

  Future<void> deleteTransaction(String id);

  Future<void> addExpenseTransaction(String walletId,
      AuthUserEntities authUser, Map<String, dynamic> transaction);

  Future<void> addAccountWallet(Map<String, dynamic> accountWallet);
  Future<void> editAccountWallet(String id, dynamic accountWallet);
}
