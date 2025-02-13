import 'dart:async';

import 'package:expense_tracker/features/auth/domain/entity/auth_user_entities.dart';
import 'package:expense_tracker/features/expense/data/repository/transaction_repository_impl.dart';
import 'package:expense_tracker/features/expense/domain/usecase/add_expense.dart';
import 'package:expense_tracker/features/expense/presentation/bloc/add_transaction/add_transaction_event.dart';
import 'package:expense_tracker/features/expense/presentation/bloc/add_transaction/add_transaction_state.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class AddTransactionBloc
    extends Bloc<AddTransactionEvent, AddTransactionState> {
  final TransactionRepositoryImpl _transactionRepositoryImpl;

  late AuthUserEntities _currentUser;
  final AddExpenseUseCase _addExpenseUseCase;
  late final StreamSubscription<AuthUserEntities>
      _authUserSubscription;

  AddTransactionBloc(this._transactionRepositoryImpl,
      this._addExpenseUseCase, Stream<AuthUserEntities> authUser)
      : super(const AddTransactionState()) {
    _authUserSubscription = authUser.listen(
      (user) {
        _currentUser = user;
      },
    );

    on<AddTransactionDescriptionChanged>(
        _onAddTransactionDescriptionChanged);
    on<AddTransactionCategoryChanged>(
        _onAddTransactionCategoryChanged);
    on<AddTransactionAmountChanged>(_onAddTransactionAmountChanged);
    on<AddTransactionExpenseTypeChanged>(
        _onAddTransactionExpenseTypeChanged);
    on<AddTransactionWalletChanged>(
        _onAddTransactionWalletTypeChanged);
    on<AddTransactionSubmitted>(_onAddExpenseTransaction);
  }

  @override
  Future<void> close() {
    _authUserSubscription.cancel();
    return super.close();
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

  void _onAddTransactionWalletTypeChanged(
      AddTransactionWalletChanged event,
      Emitter<AddTransactionState> emit) {
    emit(state.copyWith(walletType: event.walletType));
  }

  void _onAddExpenseTransaction(AddTransactionSubmitted event,
      Emitter<AddTransactionState> emit) async {
    emit(state.copyWith(status: AddTransactionStatus.loading));

    try {
      final Map<String, dynamic> transaction = {
        'uid': _currentUser.uid,
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
      _transactionRepositoryImpl.getTransactions(_currentUser);

      emit(state.copyWith(status: AddTransactionStatus.success));
    } catch (e) {
      emit(state.copyWith(status: AddTransactionStatus.failure));
    }
  }
}
