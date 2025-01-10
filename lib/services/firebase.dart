import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_tracker/model/transactions_model.dart';

Future<List<TransactionsModel>> transactionsDataList() async {
  final snapshot = await FirebaseFirestore.instance
      .collection('transactions')
      .get();
  return snapshot.docs
      .map((doc) => TransactionsModel.fromFirestore(doc, null))
      .toList();
}
