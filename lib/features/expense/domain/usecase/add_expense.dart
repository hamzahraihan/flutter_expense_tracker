import 'package:expense_tracker/features/expense/domain/repository/transaction_repository.dart';

class AddExpenseUseCase {
  final TransactionRepository _transactionRepository;
  AddExpenseUseCase(this._transactionRepository);

  Future<void> execute(Map<String, dynamic> transaction) {
    return _transactionRepository.addExpenseTransaction(transaction);
  }
}
