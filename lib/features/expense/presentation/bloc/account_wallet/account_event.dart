import 'package:equatable/equatable.dart';

sealed class AccountEvent extends Equatable {
  const AccountEvent();
  @override
  List<Object?> get props => [];
}

final class GetAccountWallet extends AccountEvent {
  const GetAccountWallet();
}

final class AddAccountWalletSubmitted extends AccountEvent {
  const AddAccountWalletSubmitted();
}

final class AccountNameChanged extends AccountEvent {
  final String walletName;
  const AccountNameChanged(this.walletName);

  @override
  List<Object?> get props => [walletName];
}

final class AccountBalanceChanged extends AccountEvent {
  final int balance;
  const AccountBalanceChanged(this.balance);
  @override
  List<Object?> get props => [balance];
}

final class AccountTypeChanged extends AccountEvent {
  final String accountWalletType;
  const AccountTypeChanged(this.accountWalletType);

  @override
  List<Object?> get props => [accountWalletType];
}
