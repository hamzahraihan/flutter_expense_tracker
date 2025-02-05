import 'package:expense_tracker/features/expense/domain/repository/transaction_repository.dart';

class AddAccountWalletUseCase {
  final TransactionRepository _transactionRepository;
  AddAccountWalletUseCase(this._transactionRepository);

  Future<void> execute(Map<String, dynamic> accountWallet) {
    return _transactionRepository.addAccountWallet(accountWallet);
  }
}
