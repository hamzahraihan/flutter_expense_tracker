import 'package:expense_tracker/features/expense/data/repository/transaction_repository_impl.dart';
import 'package:expense_tracker/features/expense/domain/usecase/add_expense.dart';
import 'package:expense_tracker/features/expense/presentation/bloc/add_transaction/add_transaction_event.dart';
import 'package:expense_tracker/features/expense/presentation/bloc/add_transaction/add_transaction_state.dart';
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
    on<AddTransactionDescriptionChanged>(
        _onAddTransactionDescriptionChanged);
    on<AddTransactionCategoryChanged>(
        _onAddTransactionCategoryChanged);
    on<AddTransactionAmountChanged>(_onAddTransactionAmountChanged);
    on<AddTransactionSubmitted>(_onAddExpenseTransaction);
  }

  void _onAddTransactionTitleChanged(AddTransactionTitleChanged event,
      Emitter<AddTransactionState> emit) {
    emit(state.copyWith(titleValue: event.titleValue));
  }

  void _onAddTransactionDescriptionChanged(
      AddTransactionDescriptionChanged event,
      Emitter<AddTransactionState> emit) {
    emit(state.copyWith(descriptionValue: event.descriptionValue));
  }

  void _onAddTransactionCategoryChanged(
      AddTransactionCategoryChanged event,
      Emitter<AddTransactionState> emit) {
    emit(state.copyWith(categoryValue: event.categoryValue));
  }

  void _onAddTransactionAmountChanged(
      AddTransactionAmountChanged event,
      Emitter<AddTransactionState> emit) {
    if (state.amountValue != event.amountValue) {
      emit(state.copyWith(amountValue: event.amountValue));
    }
  }

  void _onAddExpenseTransaction(AddTransactionSubmitted event,
      Emitter<AddTransactionState> emit) async {
    emit(state.copyWith(status: AddTransactionStatus.loading));
    try {
      final Map<String, dynamic> transaction = {
        'titleValue': state.titleValue,
        'descriptionValue': state.descriptionValue,
        'categoryValue': state.categoryValue,
        'amountValue': state.amountValue,
      };
      await _addExpenseUseCase.execute(transaction);

      add(const RefreshTransaction());

      emit(state.copyWith(status: AddTransactionStatus.success));
    } catch (e) {
      emit(state.copyWith(status: AddTransactionStatus.failure));
    }
  }
}
