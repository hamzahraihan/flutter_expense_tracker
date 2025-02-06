import 'package:expense_tracker/features/auth/domain/entity/auth_entities.dart';
import 'package:expense_tracker/features/expense/domain/repository/transaction_repository.dart';
import 'package:expense_tracker/features/expense/domain/usecase/add_expense.dart';
import 'package:expense_tracker/features/expense/presentation/bloc/add_transaction/add_transaction_event.dart';
import 'package:expense_tracker/features/expense/presentation/bloc/add_transaction/add_transaction_state.dart';
import 'package:expense_tracker/features/expense/presentation/bloc/transaction/firebase/transaction_firebase_bloc.dart';
import 'package:expense_tracker/features/expense/presentation/bloc/transaction/firebase/transaction_firebase_event.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class AddTransactionBloc
    extends Bloc<AddTransactionEvent, AddTransactionState> {
  final TransactionRepository _transactionRepository;
  final TransactionFirebaseBloc _transactionBloc;
  final AuthEntities _authUser;
  late final AddExpenseUseCase _addExpenseUseCase =
      AddExpenseUseCase(_transactionRepository);

  AddTransactionBloc(this._transactionBloc,
      this._transactionRepository, this._authUser)
      : super(const AddTransactionState()) {
    on<AddTransactionDescriptionChanged>(
        _onAddTransactionDescriptionChanged);
    on<AddTransactionCategoryChanged>(
        _onAddTransactionCategoryChanged);
    on<AddTransactionAmountChanged>(_onAddTransactionAmountChanged);
    on<AddTransactionExpenseTypeChanged>(
        _onAddTransactionExpenseTypeChanged);
    on<AddTransactionSubmitted>(_onAddExpenseTransaction);
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

  void _onAddTransactionExpenseTypeChanged(
      AddTransactionExpenseTypeChanged event,
      Emitter<AddTransactionState> emit) {
    emit(state.copyWith(expenseType: event.expenseType));
  }

  void _onAddExpenseTransaction(AddTransactionSubmitted event,
      Emitter<AddTransactionState> emit) async {
    emit(state.copyWith(status: AddTransactionStatus.loading));
    try {
      final Map<String, dynamic> transaction = {
        'uid': _authUser.uid,
        'title': state.categoryValue,
        'category': state.categoryValue,
        'description': state.descriptionValue,
        'amount': state.amountValue,
        'date': DateTime.now(),
        'expenseType': state.expenseType
      };

      // Execute expense use case add transaction data
      await _addExpenseUseCase.execute(transaction);
      // Notify another bloc to fetch updated transactions
      _transactionBloc.add(GetTransaction(_authUser));

      emit(state.copyWith(status: AddTransactionStatus.success));
    } catch (e) {
      emit(state.copyWith(status: AddTransactionStatus.failure));
    }
  }
}
