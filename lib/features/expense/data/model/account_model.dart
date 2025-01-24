import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_tracker/features/expense/domain/entitiy/account_entities.dart';

class AccountModel extends AccountEntities {
  const AccountModel(
      {required super.balance, required super.walletType});

  factory AccountModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final Map<String, dynamic>? data = snapshot.data();
    return AccountModel(
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
