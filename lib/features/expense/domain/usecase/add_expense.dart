import 'package:expense_tracker/features/auth/domain/entity/auth_user_entities.dart';
import 'package:expense_tracker/features/expense/data/repository/transaction_repository_impl.dart';

class AddExpenseUseCase {
  final TransactionRepositoryImpl _transactionRepositoryImpl;
  AddExpenseUseCase(this._transactionRepositoryImpl);

  Future<void> execute(String walletId, AuthUserEntities authUser,
      Map<String, dynamic> transaction) async {
    return await _transactionRepositoryImpl.addExpenseTransaction(
        walletId, authUser, transaction);
  }
}
