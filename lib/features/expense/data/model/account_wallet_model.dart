import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_tracker/features/expense/domain/entity/account_wallet_entities.dart';

class AccountWalletModel extends AccountWalletEntities {
  const AccountWalletModel(
      {required super.balance, required super.walletType});

  factory AccountWalletModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final Map<String, dynamic>? data = snapshot.data();
    return AccountWalletModel(
      balance: data?['balance'],
      walletType:
          WalletTypeExtension.fromString(data?['expenseType']),
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      "balance": balance,
      "walletType": WalletTypeExtension(walletType).toShortString(),
    };
  }
}
