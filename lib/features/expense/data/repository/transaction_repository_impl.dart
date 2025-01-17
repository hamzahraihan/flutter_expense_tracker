import 'package:expense_tracker/features/expense/data/data_source/transactions_api_service.dart';
import 'package:expense_tracker/features/expense/data/model/transactions_model.dart';
import 'package:expense_tracker/features/expense/domain/repository/transaction_repository.dart';

class TransactionRepositoryImpl extends TransactionRepository {
  final TransactionsApiService _transactionsApiService;
  TransactionRepositoryImpl(this._transactionsApiService);

  @override
  Future<List<TransactionsModel>> getTransactions() async {
    try {
      final response =
          await _transactionsApiService.getTransactions();
      return response;
    } catch (e) {
      
    }
  }
}
