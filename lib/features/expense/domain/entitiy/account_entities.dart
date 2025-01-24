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

class AccountEntities extends Equatable {
  final String balance;
  final WalletType walletType;

  const AccountEntities({
    required this.balance,
    required this.walletType,
  });

  @override
  List<Object?> get props => [
        balance,
        walletType,
      ];
}
