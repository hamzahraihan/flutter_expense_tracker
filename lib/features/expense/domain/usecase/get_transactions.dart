import 'package:expense_tracker/features/expense/data/model/transactions_model.dart';
import 'package:expense_tracker/features/expense/domain/repository/transaction_repository.dart';

class GetTransactionsUseCase {
  final TransactionRepository _transactionRepository;
  GetTransactionsUseCase(this._transactionRepository);

  Future<List<TransactionsModel>> execute() {
    return _transactionRepository.getTransactions();
  }
}
