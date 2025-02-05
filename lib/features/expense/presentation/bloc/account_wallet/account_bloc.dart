import 'package:expense_tracker/features/expense/data/model/account_wallet_model.dart';
import 'package:expense_tracker/features/expense/domain/usecase/add_account_wallet.dart';
import 'package:expense_tracker/features/expense/domain/usecase/get_account_wallet.dart';
import 'package:expense_tracker/features/expense/presentation/bloc/account_wallet/account_event.dart';
import 'package:expense_tracker/features/expense/presentation/bloc/account_wallet/account_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AccountBloc extends Bloc<AccountEvent, AccountState> {
  final AddAccountWalletUseCase _addAccountWalletUseCase;
  final GetAccountWalletUseCase _getAccountWalletUseCase;
  AccountBloc(
      this._addAccountWalletUseCase, this._getAccountWalletUseCase)
      : super(const AccountState()) {
    on<GetAccountWallet>(_onFetchAccountWallets);
    on<AccountNameChanged>(_onAccountWalletNameChanged);
    on<AccountBalanceChanged>(_onAddAccountBalanceChanged);
    on<AddAccountWalletSubmitted>(_onAddAccountWallet);
  }

  Future<void> _onFetchAccountWallets(
      GetAccountWallet event, Emitter<AccountState> emit) async {
    emit(state.copyWith(status: AccountWalletStatus.loading));
    try {
      final List<AccountWalletModel> accountWallet =
          await _getAccountWalletUseCase.execute();
      emit(state.copyWith(accountWallet: accountWallet));
    } catch (e) {
      emit(state.copyWith(status: AccountWalletStatus.failure));
    }
  }

  void _onAccountWalletNameChanged(
      AccountNameChanged event, Emitter<AccountState> emit) async {
    emit(state.copyWith(
      walletName: event.walletName,
    ));
  }

  void _onAddAccountBalanceChanged(
      AccountBalanceChanged event, Emitter<AccountState> emit) {
    emit(state.copyWith(
      balance: event.balance,
    ));
  }

  Future<void> _onAddAccountWallet(AddAccountWalletSubmitted event,
      Emitter<AccountState> emit) async {
    emit(state.copyWith(status: AccountWalletStatus.loading));
    try {
      final Map<String, dynamic> accountWallet = {
        'walletName': state.walletName,
        'balance': state.balance,
        'walletType': state.walletType
      };

      await _addAccountWalletUseCase.execute(accountWallet);

      add(const GetAccountWallet());

      emit(state.copyWith(status: AccountWalletStatus.success));
    } catch (e) {
      emit(state.copyWith(status: AccountWalletStatus.failure));
    }
  }
}
