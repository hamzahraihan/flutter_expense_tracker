import 'package:expense_tracker/features/auth/data/repository/auth_repository_impl.dart';
import 'package:expense_tracker/features/auth/domain/entity/auth_entities.dart';
import 'package:expense_tracker/features/auth/presentation/bloc/auth/auth_event.dart';
import 'package:expense_tracker/features/auth/presentation/bloc/auth/auth_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepositoryImpl _authRepositoryImpl;

  AuthBloc(this._authRepositoryImpl) : super(AuthState()) {
    on<Authenticated>(_onAuthenticateRequest);
  }

  Future<void> _onAuthenticateRequest(
      Authenticated event, Emitter<AuthState> emit) {
    return emit.onEach<AuthEntities>(_authRepositoryImpl.authUser,
        onData: (user) => emit(AuthState(user: user)),
        onError: addError);
  }
}
