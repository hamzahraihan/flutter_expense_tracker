import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_tracker/features/expense/data/model/transactions_model.dart';
import 'package:expense_tracker/features/expense/domain/entity/transaction_entities.dart';

FirebaseFirestore db = FirebaseFirestore.instance;

class TransactionsApiService {
  Future<List<TransactionsModel>> getTransactions() async {
    try {
      final QuerySnapshot<Map<String, dynamic>> snapshot =
          await db.collection('transactions').get();
      return snapshot.docs
          .map((doc) => TransactionsModel.fromFirestore(doc, null))
          .toList();
    } catch (e) {
      throw Exception('Error fetching transaction: $e');
    }
  }

  Iterable<TransactionsModel> filteredThisWeekExpenses(
      ExpenseType expenseType,
      List<TransactionsModel> thisWeekTransactions) {
    if (thisWeekTransactions.isNotEmpty) {
      return thisWeekTransactions.where((TransactionsModel element) =>
          element.expenseType == expenseType);
    }
    return <TransactionsModel>[];
  }

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
      await db.collection("transactions").doc().set(transaction);
    } catch (e) {
      throw Exception('Error fetching transaction: $e');
    }
  }
}
