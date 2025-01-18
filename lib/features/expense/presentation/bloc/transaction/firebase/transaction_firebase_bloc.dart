import 'package:bloc/bloc.dart';
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

    try {
      if (transactions.isNotEmpty) {
        emit(state.copyWith(
            status: TransactionStatus.success,
            transactions: transactions));
      }
    } catch (e) {
      emit(state.copyWith(
        status: TransactionStatus.failure,
      ));
    }
  }
}
