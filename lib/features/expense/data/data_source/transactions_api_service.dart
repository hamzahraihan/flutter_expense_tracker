import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_tracker/model/transactions_model.dart';

FirebaseFirestore db = FirebaseFirestore.instance;

abstract class TransactionsApiService {
  Future<List<TransactionsModel>> getTransactions() async {
    final snapshot = await db.collection('transactions').get();
    return snapshot.docs
        .map((doc) => TransactionsModel.fromFirestore(doc, null))
        .toList();
  }
}
