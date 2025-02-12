import 'package:expense_tracker/features/auth/domain/entity/auth_user_entities.dart';
import 'package:expense_tracker/features/expense/data/model/account_wallet_model.dart';
import 'package:expense_tracker/features/expense/data/repository/transaction_repository_impl.dart';

class GetAccountWalletUseCase {
  final TransactionRepositoryImpl _transactionRepositoryImpl;
  GetAccountWalletUseCase(this._transactionRepositoryImpl);

  Future<List<AccountWalletModel>> execute(
      AuthUserEntities authUser) {
    return _transactionRepositoryImpl.getAccountWallet(authUser);
  }
}
