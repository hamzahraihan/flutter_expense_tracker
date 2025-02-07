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
      } else {
        return snapshot.docs
            .map((doc) => TransactionsModel.fromFirestore(doc, null))
            .toList();
      }
    } catch (e) {
      log('Error: $e');
      throw Exception('Error fetching transaction: $e');
    }
  }

  Future<List<AccountWalletModel>> getAccountWallet() async {
    try {
      final QuerySnapshot<Map<String, dynamic>> snapshot =
          await db.collection(accountWalletCollectionPath).get();
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
      Map<String, dynamic> transaction) async {
    try {
      await db
          .collection(transactionCollectionPath)
          .doc()
          .set(transaction);
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
      throw Exception(e);
    }
  }
}
