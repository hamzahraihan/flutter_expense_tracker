import 'package:expense_tracker/features/expense/domain/repository/transaction_repository.dart';

class AddIncomeUseCase {
  final TransactionRepository _transactionRepository;
  AddIncomeUseCase(this._transactionRepository);

  Future<void> execute(Map<String, dynamic> transaction) {
    return _transactionRepository.addIncomeTransaction(transaction);
  }
}
