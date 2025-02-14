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
  final String? id;
  final String? walletName;
  final int? balance;
  final String? walletType;

  final List<AccountWalletModel>? accountWallet;

  const AccountState(
      {this.id,
      this.walletName,
      this.status = AccountWalletStatus.initial,
      this.balance,
      this.walletType,
      List<AccountWalletModel>? accountWallet})
      : accountWallet = accountWallet ?? const [];

  AccountState copyWith({
    AccountWalletStatus? status,
    String? id,
    String? walletName,
    int? balance,
    String? walletType,
    List<AccountWalletModel>? accountWallet,
  }) {
    return AccountState(
      id: id ?? this.id,
      walletName: walletName ?? this.walletName,
      status: status ?? this.status,
      balance: balance ?? this.balance,
      walletType: walletType ?? this.walletType,
      accountWallet: accountWallet ?? this.accountWallet,
    );
  }

  @override
  List<Object?> get props => [
        id,
        status,
        walletName,
        balance,
        walletType,
        accountWallet,
      ];
}
