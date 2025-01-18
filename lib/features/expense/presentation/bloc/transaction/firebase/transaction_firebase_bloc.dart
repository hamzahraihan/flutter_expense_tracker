import 'package:bloc/bloc.dart';
import 'package:expense_tracker/features/expense/domain/usecase/get_transactions.dart';
import 'package:expense_tracker/features/expense/presentation/bloc/transaction/firebase/transaction_firebase_event.dart';
import 'package:expense_tracker/features/expense/presentation/bloc/transaction/firebase/transaction_firebase_state.dart';

class TransactionFirebaseBloc
    extends Bloc<TransactionFirebaseEvent, TransactionFirebaseState> {
  final GetTransactionsUseCase _getTransactionsUseCase;

  TransactionFirebaseBloc(this._getTransactionsUseCase)
      : super(const TransactionFirebaseState()) {
    on<GetTransaction>(onfetchTransactions);
  }

  void onfetchTransactions(GetTransaction event,
      Emitter<TransactionFirebaseState> emit) async {
    final dataState = await _getTransactionsUseCase.execute();

    emit(state.copyWith(status: TransactionStatus.loading));
    try {
      if (dataState.isNotEmpty) {
        emit(state.copyWith(
            status: TransactionStatus.success,
            transactions: dataState));
      }
    } catch (e) {
      throw Exception(
          state.copyWith(status: TransactionStatus.failure));
    }
  }
}
