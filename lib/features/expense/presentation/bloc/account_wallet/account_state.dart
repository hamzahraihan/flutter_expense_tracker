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
  final AccountWalletStatus status;
  final String? walletName;
  final int? balance;
  final String? walletType;
  final AccountWalletStatus walletTypeStatus;
  final List<AccountWalletModel>? accountWallet;

  const AccountState(
      {this.walletName,
      this.status = AccountWalletStatus.initial,
      this.balance,
      this.walletType,
      this.walletTypeStatus = AccountWalletStatus.initial,
      List<AccountWalletModel>? accountWallet})
      : accountWallet = accountWallet ?? const [];

  AccountState copyWith({
    AccountWalletStatus? status,
    String? walletName,
    int? balance,
    String? walletType,
    AccountWalletStatus? walletTypeStatus,
    List<AccountWalletModel>? accountWallet,
  }) {
    return AccountState(
        walletName: walletName ?? this.walletName,
        status: status ?? this.status,
        balance: balance ?? this.balance,
        walletType: walletType ?? this.walletType,
        accountWallet: accountWallet ?? this.accountWallet,
        walletTypeStatus: walletTypeStatus ?? this.walletTypeStatus);
  }

  @override
  List<Object?> get props => [
        status,
        walletName,
        balance,
        walletType,
        accountWallet,
        walletTypeStatus
      ];
}
