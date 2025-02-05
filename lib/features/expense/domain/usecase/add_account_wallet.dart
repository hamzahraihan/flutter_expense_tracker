import 'package:expense_tracker/features/expense/domain/repository/transaction_repository.dart';

class AddAccountWallet {
  final TransactionRepository _transactionRepository;
  AddAccountWallet(this._transactionRepository);

  Future<void> execute() {
    return _transactionRepository.getAccountWallet();
  }
}
