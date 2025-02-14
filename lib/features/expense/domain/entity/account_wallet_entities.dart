import 'package:equatable/equatable.dart';

class AccountWalletEntities extends Equatable {
  final String id;
  final String uid;
  final int balance;
  final String walletName;
  final String walletType;

  const AccountWalletEntities({
    required this.id,
    required this.uid,
    required this.balance,
    required this.walletName,
    required this.walletType,
  });

  @override
  List<Object?> get props => [
        id,
        uid,
        balance,
        walletName,
        walletType,
      ];
}
