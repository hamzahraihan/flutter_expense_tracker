import 'package:equatable/equatable.dart';

enum WalletType { paypal, jago, bca, mandiri }

extension WalletTypeExtension on WalletType {
  String toShortString() {
    return toString().split('.').last;
  }

  static WalletType fromString(String value) {
    return WalletType.values
        .firstWhere((e) => e.toShortString() == value);
  }
}

class AccountWalletEntities extends Equatable {
  final String uid;
  final String balance;
  final WalletType walletType;

  const AccountWalletEntities({
    required this.uid,
    required this.balance,
    required this.walletType,
  });

  @override
  List<Object?> get props => [
        uid,
        balance,
        walletType,
      ];
}
