import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_tracker/model/transactions_model.dart';

FirebaseFirestore db = FirebaseFirestore.instance;

Future<List<TransactionsModel>> transactionsDataList() async {
  final snapshot = await db.collection('transactions').get();
  return snapshot.docs
      .map((doc) => TransactionsModel.fromFirestore(doc, null))
      .toList();
}
