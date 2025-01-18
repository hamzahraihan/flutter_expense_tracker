import 'package:bloc/bloc.dart';
import 'package:expense_tracker/features/expense/data/model/transactions_model.dart';
import 'package:expense_tracker/features/expense/domain/usecase/get_transactions.dart';
import 'package:expense_tracker/features/expense/presentation/bloc/transaction/firebase/transaction_firebase_event.dart';
import 'package:expense_tracker/features/expense/presentation/bloc/transaction/firebase/transaction_firebase_state.dart';

class TransactionFirebaseBloc
    extends Bloc<TransactionFirebaseEvent, TransactionFirebaseState> {
  final GetTransactionsUseCase _getTransactionsUseCase;

  TransactionFirebaseBloc(this._getTransactionsUseCase)
      : super(const TransactionFirebaseState()) {
    on<GetTransaction>(_onfetchTransactions);
  }

  void _onfetchTransactions(GetTransaction event,
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
      }
    } catch (e) {
      emit(state.copyWith(
        status: TransactionStatus.failure,
      ));
    }
  }
}
