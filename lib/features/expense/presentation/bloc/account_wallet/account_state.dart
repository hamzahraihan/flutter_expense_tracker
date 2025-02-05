import 'package:equatable/equatable.dart';
import 'package:expense_tracker/features/expense/data/model/account_wallet_model.dart';

enum AddAccountWalletStatus { initial, loading, success, failure }

extension AddAccountWalletStatusX on AddAccountWalletStatus {
  bool get isInitial => this == AddAccountWalletStatus.initial;
  bool get isLoading => this == AddAccountWalletStatus.loading;
  bool get isSuccess => this == AddAccountWalletStatus.success;
  bool get isFailure => this == AddAccountWalletStatus.failure;
}

class AccountState extends Equatable {
  final AddAccountWalletStatus? status;
  final int? balance;
  final String? walletType;
  final List<AccountWalletModel>? accountWallet;

  const AccountState(
      {this.status = AddAccountWalletStatus.initial,
      this.balance,
      this.walletType,
      List<AccountWalletModel>? accountWallet})
      : accountWallet = accountWallet ?? const [];

  AccountState copyWith({
    AddAccountWalletStatus? status,
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
