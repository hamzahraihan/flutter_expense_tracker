import 'package:expense_tracker/features/expense/data/model/transactions_model.dart';

abstract class TransactionRepository {
  Future<List<TransactionsModel>> getTransactions();

  // Future<void> savedTransaction(String id);

  Future<void> deleteTransaction(String id);

  Future<void> addExpenseTransaction(
      Map<String, dynamic> transaction);
}
