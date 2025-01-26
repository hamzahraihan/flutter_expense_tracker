import 'package:expense_tracker/features/auth/data/repository/auth_repository_impl.dart';
import 'package:expense_tracker/features/auth/domain/value_object/email.dart';
import 'package:expense_tracker/features/auth/domain/value_object/password.dart';
import 'package:expense_tracker/features/auth/presentation/bloc/sign_in/sign_in_event.dart';
import 'package:expense_tracker/features/auth/presentation/bloc/sign_in/sign_in_state.dart';
import 'package:expense_tracker/features/auth/presentation/bloc/status.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  final AuthRepositoryImpl _authRepository;

  SignInBloc(this._authRepository) : super(const SignInState()) {
    on<SignInWithEmailAndPassword>(_onSignIn);
    on<EmailChanged>(_onFormEmailChanged);
    on<PasswordChanged>(_onFormPasswordChanged);
  }

  void _onFormEmailChanged(
      EmailChanged event, Emitter<SignInState> emit) {
    try {
      Email email = Email((email) => email..value = event.email);
      emit(state.copyWith(
          email: email, emailStatus: EmailStatus.valid));
    } catch (e) {
      emit(state.copyWith(emailStatus: EmailStatus.invalid));
    }
  }

  void _onFormPasswordChanged(
      PasswordChanged event, Emitter<SignInState> emit) {
    try {
      Password password =
          Password((password) => password..value = event.password);
      emit(state.copyWith(
          password: password, passwordStatus: PasswordStatus.valid));
    } catch (e) {
      emit(state.copyWith(passwordStatus: PasswordStatus.invalid));
    }
  }

  void _onSignIn(SignInWithEmailAndPassword event,
      Emitter<SignInState> emit) async {
    emit(state.copyWith());
  }
}
