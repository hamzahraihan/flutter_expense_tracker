import 'dart:async';

import 'package:expense_tracker/features/auth/domain/entity/auth_user_entities.dart';
import 'package:expense_tracker/features/expense/data/model/account_wallet_model.dart';
import 'package:expense_tracker/features/expense/domain/usecase/add_account_wallet.dart';
import 'package:expense_tracker/features/expense/domain/usecase/get_account_wallet.dart';
import 'package:expense_tracker/features/expense/presentation/bloc/account_wallet/account_event.dart';
import 'package:expense_tracker/features/expense/presentation/bloc/account_wallet/account_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AccountBloc extends Bloc<AccountEvent, AccountState> {
  final AddAccountWalletUseCase _addAccountWalletUseCase;
  final GetAccountWalletUseCase _getAccountWalletUseCase;

  late AuthUserEntities _currentUser;
  late final StreamSubscription<AuthUserEntities>
      _authUserSubscription;

  AccountBloc(
      this._addAccountWalletUseCase,
      this._getAccountWalletUseCase,
      Stream<AuthUserEntities> authUser)
      : super(const AccountState()) {
    _authUserSubscription = authUser.listen(
      (AuthUserEntities user) {
        _currentUser = user;
        add(const GetAccountWallet());
      },
    );
    on<GetAccountWallet>(_onFetchAccountWallets);
    on<AccountNameChanged>(_onAccountWalletNameChanged);
    on<AccountBalanceChanged>(_onAddAccountBalanceChanged);
    on<AccountTypeChanged>(_onAddAccountWalletTypeChanged);
    on<AddAccountWalletSubmitted>(_onAddAccountWallet);
  }

  @override
  Future<void> close() {
    _authUserSubscription.cancel();
    return super.close();
  }

  Future<void> _onFetchAccountWallets(
      GetAccountWallet event, Emitter<AccountState> emit) async {
    emit(state.copyWith(status: AccountWalletStatus.loading));
    if (_currentUser.isEmpty) {
      emit(state.copyWith(
          status: AccountWalletStatus.success, accountWallet: []));
      return;
    }
    try {
      final List<AccountWalletModel> accountWallet =
          await _getAccountWalletUseCase.execute(
              state.id, _currentUser);

      if (accountWallet.isEmpty) {
        emit(state.copyWith(
            status: AccountWalletStatus.success, accountWallet: []));
        return;
      }

      emit(state.copyWith(
          accountWallet: accountWallet,
          status: AccountWalletStatus.success));
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

  void _onAddAccountWalletTypeChanged(
      AccountTypeChanged event, Emitter<AccountState> emit) {
    if (event.walletType.isNotEmpty) {
      emit(state.copyWith(
          walletType: event.walletType,
          status: AccountWalletStatus.success));
    } else {
      emit(state.copyWith(status: AccountWalletStatus.failure));
    }
  }

  Future<void> _onAddAccountWallet(AddAccountWalletSubmitted event,
      Emitter<AccountState> emit) async {
    emit(state.copyWith(status: AccountWalletStatus.loading));
    try {
      final Map<String, dynamic> accountWallet = {
        'uid': _currentUser.uid,
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
