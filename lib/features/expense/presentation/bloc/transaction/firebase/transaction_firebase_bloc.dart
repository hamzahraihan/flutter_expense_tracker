import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:expense_tracker/features/auth/domain/entity/auth_user_entities.dart';
import 'package:expense_tracker/features/expense/data/model/transactions_model.dart';
import 'package:expense_tracker/features/expense/data/repository/transaction_repository_impl.dart';
import 'package:expense_tracker/features/expense/domain/usecase/add_expense.dart';
import 'package:expense_tracker/features/expense/domain/usecase/get_transactions.dart';
import 'package:expense_tracker/features/expense/presentation/bloc/transaction/firebase/transaction_firebase_event.dart';
import 'package:expense_tracker/features/expense/presentation/bloc/transaction/firebase/transaction_firebase_state.dart';

class TransactionFirebaseBloc
    extends Bloc<TransactionFirebaseEvent, TransactionFirebaseState> {
  final TransactionRepositoryImpl _transactionRepositoryImpl;

  // get user id
  final Stream<AuthUserEntities> authUser;
  late AuthUserEntities _currentUser;
  late final StreamSubscription<AuthUserEntities>
      _authUserSubscription;

  late final GetTransactionsUseCase _getTransactionsUseCase =
      GetTransactionsUseCase(_transactionRepositoryImpl);

  late final AddExpenseUseCase _addExpenseUseCase =
      AddExpenseUseCase(_transactionRepositoryImpl);

  TransactionFirebaseBloc(
      this._transactionRepositoryImpl, this.authUser)
      : super(const TransactionFirebaseState()) {
    // handle the Stream of AuthUserEntities authUser
    _authUserSubscription = authUser.listen((AuthUserEntities user) {
      log('listening to user stream $user');
      _currentUser = user;
      add(const GetTransaction()); // refresh data when user changes
    });
    on<GetTransaction>(_onFetchTransactions);
    on<AddExpenseTransaction>(_onAddExpenseTransaction);
    on<ClearTransactions>(_onClearTransactionData);
  }

  @override
  Future<void> close() {
    _authUserSubscription.cancel();
    return super.close();
  }

  void _onFetchTransactions(GetTransaction event,
      Emitter<TransactionFirebaseState> emit) async {
    log('from fetch transaction bloc ${_currentUser.toString()}');

    emit(state.copyWith(status: TransactionStatus.loading));

// First check if we have a valid user
    if (_currentUser.isEmpty) {
      emit(state.copyWith(
          status: TransactionStatus.success,
          transactions: [],
          todayTransactions: [],
          yesterdayTransactions: [],
          thisWeekTransactions: [],
          thisMonthTransaction: [],
          olderTransactions: []));
      return;
    }

    emit(state.copyWith(status: TransactionStatus.loading));
    try {
      final List<TransactionsModel> transactions =
          await _getTransactionsUseCase.execute(_currentUser);
      final GroupedTransactions groupedTransactions =
          Transactions.filterTransactionsByDate(transactions);

      if (transactions.isEmpty) {
        emit(state.copyWith(
            status: TransactionStatus.success,
            transactions: [],
            todayTransactions: [],
            yesterdayTransactions: [],
            thisWeekTransactions: [],
            thisMonthTransaction: [],
            olderTransactions: []));
        return;
      }

      emit(state.copyWith(
          status: TransactionStatus.success,
          transactions: transactions,
          todayTransactions: groupedTransactions.today,
          yesterdayTransactions: groupedTransactions.yesterady,
          thisWeekTransactions: groupedTransactions.thisWeek,
          thisMonthTransaction: groupedTransactions.thisMonth,
          olderTransactions: groupedTransactions.older));
    } catch (e) {
      log('Error fetching transactions: $e');
      emit(state.copyWith(
          status: TransactionStatus.failure,
          transactions: [],
          todayTransactions: [],
          yesterdayTransactions: [],
          thisWeekTransactions: [],
          thisMonthTransaction: [],
          olderTransactions: []));
    }
  }

  void _onClearTransactionData(ClearTransactions event,
      Emitter<TransactionFirebaseState> emit) {
    log('transaction cleared');
    emit(state.copyWith(transactions: []));
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
