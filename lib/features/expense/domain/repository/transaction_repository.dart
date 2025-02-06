import 'package:expense_tracker/features/expense/data/model/account_wallet_model.dart';
import 'package:expense_tracker/features/expense/data/model/transactions_model.dart';

abstract class TransactionRepository {
  Future<List<TransactionsModel>> getTransactions(authUser);

  Future<List<AccountWalletModel>> getAccountWallet();

  // Future<void> savedTransaction(String id);

  Future<void> deleteTransaction(String id);

  Future<void> addExpenseTransaction(
      Map<String, dynamic> transaction);

  Future<void> addAccountWallet(Map<String, dynamic> accountWallet);
}
