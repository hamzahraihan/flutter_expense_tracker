import 'package:expense_tracker/features/expense/data/model/account_wallet_model.dart';
import 'package:expense_tracker/features/expense/data/repository/transaction_repository_impl.dart';

class GetAccountWalletUseCase {
  final TransactionRepositoryImpl _transactionRepositoryImpl;
  GetAccountWalletUseCase(this._transactionRepositoryImpl);

  Future<List<AccountWalletModel>> execute() {
    return _transactionRepositoryImpl.getAccountWallet();
  }
}
