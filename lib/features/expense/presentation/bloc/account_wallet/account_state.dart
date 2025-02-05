import 'package:equatable/equatable.dart';
import 'package:expense_tracker/features/expense/data/model/account_wallet_model.dart';

enum AccountWalletStatus { initial, loading, success, failure }

extension AccountWalletStatusX on AccountWalletStatus {
  bool get isInitial => this == AccountWalletStatus.initial;
  bool get isLoading => this == AccountWalletStatus.loading;
  bool get isSuccess => this == AccountWalletStatus.success;
  bool get isFailure => this == AccountWalletStatus.failure;
}

class AccountState extends Equatable {
  final AccountWalletStatus? status;
  final int? balance;
  final String? walletType;
  final List<AccountWalletModel>? accountWallet;

  const AccountState(
      {this.status = AccountWalletStatus.initial,
      this.balance,
      this.walletType,
      List<AccountWalletModel>? accountWallet})
      : accountWallet = accountWallet ?? const [];

  AccountState copyWith({
    AccountWalletStatus? status,
    final int? balance,
    final String? walletType,
    final List<AccountWalletModel>? accountWallet,
  }) {
    return AccountState(
        status: status ?? status,
        balance: balance ?? this.balance,
        walletType: walletType ?? this.walletType,
        accountWallet: accountWallet ?? this.accountWallet);
  }

  @override
  List<Object?> get props =>
      [status, balance, walletType, accountWallet];
}
