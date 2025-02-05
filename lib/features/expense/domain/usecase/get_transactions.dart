import 'package:expense_tracker/features/expense/data/model/transactions_model.dart';
import 'package:expense_tracker/features/expense/data/repository/transaction_repository_impl.dart';

class GetTransactionsUseCase {
  final TransactionRepositoryImpl _transactionRepositoryImpl;
  GetTransactionsUseCase(this._transactionRepositoryImpl);

  Future<List<TransactionsModel>> execute() {
    return _transactionRepositoryImpl.getTransactions();
  }
}
