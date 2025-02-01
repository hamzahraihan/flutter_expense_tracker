import 'package:expense_tracker/features/auth/domain/usecase/sign_in.dart';
import 'package:expense_tracker/features/auth/domain/value_object/email.dart';
import 'package:expense_tracker/features/auth/domain/value_object/password.dart';
import 'package:expense_tracker/features/auth/presentation/bloc/sign_in/sign_in_event.dart';
import 'package:expense_tracker/features/auth/presentation/bloc/sign_in/sign_in_state.dart';
import 'package:expense_tracker/features/auth/presentation/bloc/status.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  final SignInUseCase _signInUseCase;

  SignInBloc(
    this._signInUseCase,
  ) : super(const SignInState()) {
    on<SignInWithEmailAndPassword>(_onSignInWithCredential);
    on<SignInWithGoogle>(_onSignInWithGoogle);
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

  void _onSignInWithCredential(SignInWithEmailAndPassword event,
      Emitter<SignInState> emit) async {
    if (!(state.emailStatus == EmailStatus.valid) ||
        !(state.passwordStatus == PasswordStatus.valid)) {
      emit(state.copyWith(formStatus: FormStatus.invalid));
      emit(state.copyWith(formStatus: FormStatus.initial));
      return;
    }

    emit(state.copyWith(formStatus: FormStatus.submissionInProgress));

    try {
      await _signInUseCase.withCredential(SignInParams(
          email: state.email!, password: state.password!));

      emit(state.copyWith(formStatus: FormStatus.submissionSuccess));
    } catch (e) {
      emit(state.copyWith(formStatus: FormStatus.submissionFailure));
    }
  }

  void _onSignInWithGoogle(
      SignInWithGoogle event, Emitter<SignInState> emit) async {
    emit(state.copyWith(formStatus: FormStatus.submissionInProgress));
    try {
      await _signInUseCase.withGoogle();
      emit(state.copyWith(formStatus: FormStatus.submissionSuccess));
    } catch (e) {
      emit(state.copyWith(formStatus: FormStatus.invalid));
    }
  }
}
