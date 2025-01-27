import 'dart:async';

import 'package:expense_tracker/features/auth/data/repository/auth_repository_impl.dart';
import 'package:expense_tracker/features/auth/domain/entity/auth_entities.dart';
import 'package:expense_tracker/features/auth/presentation/bloc/auth/auth_event.dart';
import 'package:expense_tracker/features/auth/presentation/bloc/auth/auth_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepositoryImpl _authRepositoryImpl;
  StreamSubscription? _authSubscription;

  AuthBloc(this._authRepositoryImpl) : super(const AuthState()) {
    on<Authenticated>(_onAuthenticateRequest);
  }

  void _onAuthenticateRequest(
      Authenticated event, Emitter<AuthState> emit) async {
    emit(state.copyWith(authStatus: AuthStatus.loading));
    try {
      // cancel any existing subscription
      _authSubscription?.cancel();

      final AuthEntities? authUser =
          await _authRepositoryImpl.authUser.first;

      if (authUser == null) {
        emit(state.copyWith(authStatus: AuthStatus.authenticated));
      } else {
        emit(state.copyWith(
            user: authUser, authStatus: AuthStatus.authenticated));
      }
    } catch (e) {
      emit(state.copyWith(authStatus: AuthStatus.unauthenticated));
    }
  }
}
