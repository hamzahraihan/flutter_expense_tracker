import 'package:expense_tracker/features/expense/data/repository/transaction_repository_impl.dart';

class AddExpenseUseCase {
  final TransactionRepositoryImpl _transactionRepositoryImpl;
  AddExpenseUseCase(this._transactionRepositoryImpl);

  Future<void> execute(Map<String, dynamic> transaction) async {
    print('usecase initialized');
    return await _transactionRepositoryImpl
        .addExpenseTransaction(transaction);
  }
}
