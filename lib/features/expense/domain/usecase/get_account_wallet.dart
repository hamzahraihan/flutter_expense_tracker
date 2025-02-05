import 'package:expense_tracker/features/expense/data/model/account_wallet_model.dart';
import 'package:expense_tracker/features/expense/domain/repository/transaction_repository.dart';

class GetAccountWalletUseCase {
  final TransactionRepository _transactionRepository;
  GetAccountWalletUseCase(this._transactionRepository);

  Future<List<AccountWalletModel>> execute() {
    return _transactionRepository.getAccountWallet();
  }
}
