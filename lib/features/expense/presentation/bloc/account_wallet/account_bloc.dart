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
    on<AccountBalanceChanged>(_onAddAccountBalanceChanged);
    on<AddAccountWalletSubmitted>(_onAddAccountWallet);
  }

  Future<void> _onFetchAccountWallets(
      GetAccountWallet event, Emitter<AccountState> emit) async {
    emit(state.copyWith(status: AccountWalletStatus.loading));
    try {
      final accountWallet = await _getAccountWalletUseCase.execute();
      emit(state.copyWith(accountWallet: accountWallet));
    } catch (e) {
      emit(state.copyWith(status: AccountWalletStatus.failure));
    }
  }

  void _onAddAccountBalanceChanged(
      AccountBalanceChanged event, Emitter<AccountState> emit) {
    emit(state.copyWith(
        balance: event.balance, status: AccountWalletStatus.success));
  }

  Future<void> _onAddAccountWallet(AddAccountWalletSubmitted event,
      Emitter<AccountState> emit) async {
    emit(state.copyWith(status: AccountWalletStatus.loading));
    try {
      final Map<String, dynamic> accountWallet = {
        'balance': state.balance,
        'walletType': state.walletType
      };

      // Execute expense use case add transaction data
      await _addAccountWalletUseCase.execute(accountWallet);
      // Notify another bloc to fetch updated transactions

      emit(state.copyWith(status: AccountWalletStatus.success));
    } catch (e) {
      emit(state.copyWith(status: AccountWalletStatus.failure));
    }
  }
}
