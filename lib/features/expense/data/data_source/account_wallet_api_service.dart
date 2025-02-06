import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_tracker/core/constants/constants.dart';
import 'package:expense_tracker/features/expense/data/model/account_wallet_model.dart';
import 'package:expense_tracker/services/firebase.dart';

class AccountWalletApiService {
  Future<List<AccountWalletModel>> getAccountWallet() async {
    try {
      final QuerySnapshot<Map<String, dynamic>> snapshot =
          await db.collection(accountWalletCollectionPath).get();
      return snapshot.docs
          .map((doc) => AccountWalletModel.fromFirestore(doc, null))
          .toList();
    } catch (e) {
      throw Exception('Error fetching transaction: $e');
    }
  }

  Future<void> addAccountWallet(
      Map<String, dynamic> accountWallet) async {
    try {
      await db
          .collection(accountWalletCollectionPath)
          .doc()
          .set(accountWallet);
    } catch (e) {
      throw Exception('Error fetching transaction: $e');
    }
  }
}
