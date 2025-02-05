import 'package:expense_tracker/features/expense/data/repository/transaction_repository_impl.dart';

class AddAccountWalletUseCase {
  final TransactionRepositoryImpl _transactionRepositoryImpl;
  AddAccountWalletUseCase(this._transactionRepositoryImpl);

  Future<void> execute(Map<String, dynamic> accountWallet) {
    return _transactionRepositoryImpl.addAccountWallet(accountWallet);
  }
}
