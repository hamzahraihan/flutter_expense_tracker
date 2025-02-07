import 'package:expense_tracker/features/auth/domain/entity/auth_user_entities.dart';
import 'package:expense_tracker/features/expense/data/data_source/transactions_api_service.dart';
import 'package:expense_tracker/features/expense/data/model/account_wallet_model.dart';
import 'package:expense_tracker/features/expense/data/model/transactions_model.dart';
import 'package:expense_tracker/features/expense/domain/repository/transaction_repository.dart';

class TransactionRepositoryImpl extends TransactionRepository {
  final TransactionsApiService _transactionsApiService;
  TransactionRepositoryImpl(this._transactionsApiService);

  @override
  Future<void> addExpenseTransaction(
      Map<String, dynamic> transaction) async {
    try {
      await _transactionsApiService
          .addExpenseTransaction(transaction);
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<void> addAccountWallet(
      Map<String, dynamic> accountWallet) async {
    try {
      await _transactionsApiService.addAccountWallet(accountWallet);
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<void> deleteTransaction(String id) async {
    try {
      await _transactionsApiService.deleteTransctions(id);
    } catch (e) {
      // Handle error
    }
  }

  Future<void> editTransaction(String id) async {
    try {
      await _transactionsApiService.editTransaction(id);
    } catch (e) {
      // Handle error
    }
  }

  @override
  Future<List<TransactionsModel>> getTransactions(
      AuthUserEntities authUser) async {
    return await _transactionsApiService.getTransactions(authUser);
  }

  @override
  Future<List<AccountWalletModel>> getAccountWallet() async {
    return await _transactionsApiService.getAccountWallet();
  }
}
