import 'package:expense_tracker/features/expense/data/model/transactions_model.dart';
import 'package:expense_tracker/features/expense/domain/entitiy/transaction_entities.dart';

abstract class TransactionRepository {
  Future<List<TransactionsModel>> getTransactions();
  Iterable<TransactionsModel> filteredThisWeekExpenses(
      ExpenseType expenseType,
      List<TransactionsModel> thisWeekTransactions);
  // Future<void> savedTransaction(String id);

  Future<void> deleteTransaction(String id);

  Future<void> addExpenseTransaction(
      Map<String, dynamic> transaction);
  Future<void> addIncomeTransaction(transaction);
}
