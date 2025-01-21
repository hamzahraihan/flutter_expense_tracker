import 'package:expense_tracker/features/expense/data/repository/transaction_repository_impl.dart';
import 'package:expense_tracker/features/expense/domain/usecase/add_expense.dart';
import 'package:expense_tracker/features/expense/presentation/bloc/add_transaction/add_transaction_event.dart';
import 'package:expense_tracker/features/expense/presentation/bloc/add_transaction/add_transaction_state.dart';
import 'package:expense_tracker/features/expense/presentation/bloc/transaction/firebase/transaction_firebase_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddTransactionBloc
    extends Bloc<AddTransactionEvent, AddTransactionState> {
  final TransactionRepositoryImpl _transactionRepository;

  late final AddExpenseUseCase _addExpenseUseCase =
      AddExpenseUseCase(_transactionRepository);

  AddTransactionBloc(
    this._transactionRepository,
  ) : super(const AddTransactionState()) {
    on<AddTransactionTitleChanged>(_onAddTransactionTitleChanged);
    on<AddTransactionSubmitted>(_onAddExpenseTransaction);
  }

  void _onAddTransactionTitleChanged(AddTransactionTitleChanged event,
      Emitter<AddTransactionState> emit) {
    emit(state.copyWith(titleValue: event.titleValue));
  }

  void _onAddExpenseTransaction(AddTransactionSubmitted event,
      Emitter<AddTransactionState> emit) async {
    emit(state.copyWith(status: AddTransactionStatus.loading));
    try {
      await _addExpenseUseCase.execute(event.transaction);

      add(const GetTransaction());

      emit(state.copyWith(status: AddTransactionStatus.success));
    } catch (e) {
      emit(state.copyWith(status: AddTransactionStatus.failure));
    }
  }
}
