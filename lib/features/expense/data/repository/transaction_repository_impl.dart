import 'package:expense_tracker/features/expense/data/data_source/transactions_api_service.dart';
import 'package:expense_tracker/features/expense/data/model/transactions_model.dart';
import 'package:expense_tracker/features/expense/domain/repository/transaction_repository.dart';

class TransactionRepositoryImpl extends TransactionRepository {
  final TransactionsApiService _transactionsApiService;
  TransactionRepositoryImpl(this._transactionsApiService);

  @override
  Future<void> addIncomeTransaction(transaction) async {
    try {
      await _transactionsApiService.addIncomeTransaction(transaction);
    } catch (e) {
      //handle error
    }
  }

  @override
  Future<void> addExpenseTransaction(transaction) async {
    try {
      await _transactionsApiService
          .addExpenseTransaction(transaction);
    } catch (e) {
      //handle error
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
  Future<List<TransactionsModel>> getTransactions() async {
    return await _transactionsApiService.getTransactions();
  }
}
