import 'package:expense_tracker/features/expense/data/data_source/transactions_api_service.dart';
import 'package:expense_tracker/features/expense/data/model/transactions_model.dart';
import 'package:expense_tracker/features/expense/domain/repository/transaction_repository.dart';

class TransactionRepositoryImpl extends TransactionRepository {
  final TransactionsApiService _transactionsApiService;
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

  TransactionRepositoryImpl(this._transactionsApiService);

  @override
  Future<List<TransactionsModel>> getTransactions() async {
    try {
      final response =
          await _transactionsApiService.getTransactions();
      return response;
    } catch (e) {
      throw Error();
    }
  }
}
