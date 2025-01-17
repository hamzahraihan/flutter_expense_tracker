import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_tracker/features/expense/data/model/transactions_model.dart';

FirebaseFirestore db = FirebaseFirestore.instance;

abstract class TransactionsApiService {
  Future<List<TransactionsModel>> getTransactions() async {
    final snapshot = await db.collection('transactions').get();
    return snapshot.docs
        .map((doc) => TransactionsModel.fromFirestore(doc, null))
        .toList();
  }

  Future<void> deleteTransctions(String id);
  Future<void> editTransaction(String id);
}
