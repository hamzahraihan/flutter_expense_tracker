import 'dart:async';

import 'package:expense_tracker/features/auth/data/repository/auth_repository_impl.dart';
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
    emit(state.copyWith(authStatus: AuthStatusX.loading));
    try {
      // cancel any existing subscription
      _authSubscription?.cancel();

      _authRepositoryImpl.authUser.listen((authState) {
        if (authState is Authenticated) {
          return emit(state.copyWith(user: authState.user));
        }
        if (authState is Unauthenticated && authState is AuthError) {
          return emit(state.copyWith(
              authStatus: AuthStatusX.unauthenticated));
        }
      });
    } catch (e) {
      emit(state.copyWith(authStatus: AuthStatusX.unauthenticated));
    }
  }
}
