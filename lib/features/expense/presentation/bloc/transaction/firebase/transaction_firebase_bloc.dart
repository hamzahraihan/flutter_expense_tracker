import 'package:bloc/bloc.dart';
import 'package:expense_tracker/features/expense/data/model/transactions_model.dart';
import 'package:expense_tracker/features/expense/data/repository/transaction_repository_impl.dart';
import 'package:expense_tracker/features/expense/domain/usecase/add_expense.dart';
import 'package:expense_tracker/features/expense/domain/usecase/get_transactions.dart';
import 'package:expense_tracker/features/expense/presentation/bloc/transaction/firebase/transaction_firebase_event.dart';
import 'package:expense_tracker/features/expense/presentation/bloc/transaction/firebase/transaction_firebase_state.dart';

class TransactionFirebaseBloc
    extends Bloc<TransactionFirebaseEvent, TransactionFirebaseState> {
  final TransactionRepositoryImpl _transactionRepository;

  late final GetTransactionsUseCase _getTransactionsUseCase =
      GetTransactionsUseCase(_transactionRepository);

  late final AddExpenseUseCase _addExpenseUseCase =
      AddExpenseUseCase(_transactionRepository);

  TransactionFirebaseBloc(
    this._transactionRepository,
  ) : super(const TransactionFirebaseState()) {
    on<GetTransaction>(_onFetchTransactions);
    on<AddExpenseTransaction>(_onAddExpenseTransaction);
  }

  void _onFetchTransactions(GetTransaction event,
      Emitter<TransactionFirebaseState> emit) async {
    emit(state.copyWith(status: TransactionStatus.loading));
    final transactions = await _getTransactionsUseCase.execute();
    final GroupedTransactions groupedTransactions =
        Transactions.filterTransactionsByDate(transactions);
    try {
      if (transactions.isNotEmpty) {
        emit(state.copyWith(
            status: TransactionStatus.success,
            transactions: transactions,
            todayTransactions: groupedTransactions.today,
            yesterdayTransactions: groupedTransactions.yesterady,
            thisWeekTransactions: groupedTransactions.thisWeek,
            thisMonthTransaction: groupedTransactions.thisMonth,
            olderTransactions: groupedTransactions.older));
      } else {
        emit(state.copyWith(
            status: TransactionStatus.success, transactions: []));
      }
    } catch (e) {
      emit(state.copyWith(
        status: TransactionStatus.failure,
      ));
    }
  }

  void _onAddExpenseTransaction(AddExpenseTransaction event,
      Emitter<TransactionFirebaseState> emit) async {
    emit(state.copyWith(status: TransactionStatus.loading));
    try {
      await _addExpenseUseCase.execute(event.transaction);

      add(const GetTransaction());

      emit(state.copyWith(status: TransactionStatus.success));
    } catch (e) {
      emit(state.copyWith(status: TransactionStatus.failure));
    }
  }
}
