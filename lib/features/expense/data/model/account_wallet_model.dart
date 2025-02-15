import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_tracker/features/expense/domain/entity/account_wallet_entities.dart';

class AccountWalletModel extends AccountWalletEntities {
  const AccountWalletModel({
    required super.docId,
    required super.uid,
    required super.walletName,
    required super.balance,
    required super.walletType,
  });

  factory AccountWalletModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final Map<String, dynamic>? data = snapshot.data();
    return AccountWalletModel(
        docId: snapshot.id,
        uid: data?['uid'],
        walletName: data?['walletName'],
        balance: data?['balance'],
        walletType: data?['walletType']);
  }

  Map<String, dynamic> toFirestore() {
    return {
      "uid": uid,
      "walletName": walletName,
      "balance": balance,
      "walletType": walletType
    };
  }
}
