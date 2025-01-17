import 'package:expense_tracker/model/transactions_model.dart';

abstract class TransactionRepository {
  Future<List<TransactionsModel>> getTransactions();

  Future<void> savedTransaction();

  Future<void> deleteTransaction();
}
