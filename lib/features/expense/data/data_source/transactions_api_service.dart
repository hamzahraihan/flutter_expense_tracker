import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_tracker/core/constants/constants.dart';
import 'package:expense_tracker/features/auth/domain/entity/auth_user_entities.dart';
import 'package:expense_tracker/features/expense/data/model/account_wallet_model.dart';
import 'package:expense_tracker/features/expense/data/model/transactions_model.dart';
import 'package:expense_tracker/services/firebase.dart';

class TransactionsApiService {
  Future<List<TransactionsModel>> getTransactions(
      AuthUserEntities authUser) async {
    try {
      log('User ID: ${authUser.uid}');

      final query = db
          .collection(transactionCollectionPath)
          .where('uid', isEqualTo: authUser.uid);

      log('Query: ${query.parameters}');

      final snapshot = await query.get();
      log('Documents found: ${snapshot.docs.length}');

      if (snapshot.docs.isEmpty) {
        log('No documents found for user ${authUser.uid}');
        return [];
      }
      return snapshot.docs
          .map((doc) => TransactionsModel.fromFirestore(doc, null))
          .toList();
    } catch (e) {
      log('Error: $e');
      throw Exception('Error fetching transaction: $e');
    }
  }

  Future<List<AccountWalletModel>> getAccountWallet(
      String? walletId, AuthUserEntities authUser) async {
    try {
      final collection = db.collection(accountWalletCollectionPath);

      final Query<Map<String, dynamic>> query = walletId!.isNotEmpty
          ? collection.where('id', isEqualTo: walletId)
          : collection.where('uid', isEqualTo: authUser.uid);

      final QuerySnapshot<Map<String, dynamic>> snapshot =
          await query.get();

      if (snapshot.docs.isEmpty) {
        log('No documents found for user ${authUser.uid}');
        return [];
      }

      return snapshot.docs
          .map((doc) => AccountWalletModel.fromFirestore(doc, null))
          .toList();
    } catch (e) {
      throw Exception('Error fetching user account wallet: $e');
    }
  }

  // Iterable<TransactionsModel> filteredThisWeekExpenses(
  //     ExpenseType expenseType,
  //     List<TransactionsModel> thisWeekTransactions) {
  //   if (thisWeekTransactions.isNotEmpty) {
  //     return thisWeekTransactions.where((TransactionsModel element) =>
  //         element.expenseType == expenseType);
  //   }
  //   return <TransactionsModel>[];
  // }

  Future<void> deleteTransctions(String id) {
    // TODO: implement deleteTransctions
    throw UnimplementedError();
  }

  Future<void> editTransaction(String id) {
    // TODO: implement editTransaction
    throw UnimplementedError();
  }

  Future<void> addExpenseTransaction(
      String walletId,
      AuthUserEntities authUser,
      Map<String, dynamic> transaction) async {
    try {
      final List<AccountWalletModel> accountDoc =
          await getAccountWallet(walletId, authUser);

      if (accountDoc.isEmpty) {
        throw Exception("No account wallet found for this user.");
      }

      final currentBalance = accountDoc.first.balance as num;
      final expenseAmount = transaction['amount'] as num;
      final newBalance = currentBalance - expenseAmount;

      if (newBalance < 0) {
        throw Exception("Insufficient balance.");
      }

      final docRef = db
          .collection(transactionCollectionPath)
          .doc(); // Generate new doc ID

      log('Generated document ID: ${docRef.id}');

      await docRef
          .set(transaction)
          .onError((e, _) => print("Error writing document: $e"));

      await editAccountWallet(walletId, {
        'balance': newBalance,
      });

      log('Transaction successfully uploaded to Firebase');
    } catch (e) {
      log('Firebase upload error: $e');
      throw Exception('Failed to add transaction: $e');
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
      throw Exception(e);
    }
  }

  Future<void> editAccountWallet(
      String walletId, dynamic accountWallet) async {
    try {
      final snapshot = await db
          .collection(accountWalletCollectionPath)
          .where('id', isEqualTo: walletId)
          .get();

      if (snapshot.docs.isEmpty) {
        throw Exception("No account wallet found for the given UID");
      }

      return await db
          .collection(accountWalletCollectionPath)
          .doc()
          .update(accountWallet);
    } catch (e) {
      throw Exception(e);
    }
  }
}
