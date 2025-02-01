import 'package:expense_tracker/features/auth/domain/usecase/sign_up.dart';
import 'package:expense_tracker/features/auth/domain/value_object/email.dart';
import 'package:expense_tracker/features/auth/domain/value_object/password.dart';
import 'package:expense_tracker/features/auth/presentation/bloc/sign_up/sign_up_event.dart';
import 'package:expense_tracker/features/auth/presentation/bloc/sign_up/sign_up_state.dart';
import 'package:expense_tracker/features/auth/presentation/bloc/status.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final SignUpUseCase _signUpUseCase;

  SignUpBloc(
    this._signUpUseCase,
  ) : super(const SignUpState()) {
    on<SignUpWithEmailAndPassword>(_onSignUpWithCredential);
    on<SignUpWithGoogle>(_onSignUpWithGoogle);
    on<EmailChanged>(_onFormEmailChanged);
    on<PasswordChanged>(_onFormPasswordChanged);
  }

  void _onFormEmailChanged(
      EmailChanged event, Emitter<SignUpState> emit) {
    try {
      Email email = Email((email) => email..value = event.email);
      emit(state.copyWith(
          email: email, emailStatus: EmailStatus.valid));
    } catch (e) {
      emit(state.copyWith(emailStatus: EmailStatus.invalid));
    }
  }

  void _onFormPasswordChanged(
      PasswordChanged event, Emitter<SignUpState> emit) {
    try {
      Password password =
          Password((password) => password..value = event.password);
      emit(state.copyWith(
          password: password, passwordStatus: PasswordStatus.valid));
    } catch (e) {
      emit(state.copyWith(passwordStatus: PasswordStatus.invalid));
    }
  }

  void _onSignUpWithCredential(SignUpWithEmailAndPassword event,
      Emitter<SignUpState> emit) async {
    if (!(state.emailStatus == EmailStatus.valid) ||
        !(state.passwordStatus == PasswordStatus.valid)) {
      emit(state.copyWith(formStatus: FormStatus.invalid));
      emit(state.copyWith(formStatus: FormStatus.initial));
      return;
    }

    emit(state.copyWith(formStatus: FormStatus.submissionInProgress));

    try {
      await _signUpUseCase.withCredential(SignUpParams(
          email: state.email!, password: state.password!));

      emit(state.copyWith(formStatus: FormStatus.submissionSuccess));
    } catch (e) {
      emit(state.copyWith(formStatus: FormStatus.submissionFailure));
    }
  }

  void _onSignUpWithGoogle(
      SignUpWithGoogle event, Emitter<SignUpState> emit) async {
    emit(state.copyWith(formStatus: FormStatus.submissionInProgress));
    try {
      await _signUpUseCase.withGoogle();
      emit(state.copyWith(formStatus: FormStatus.submissionSuccess));
    } catch (e) {
      emit(state.copyWith(formStatus: FormStatus.invalid));
    }
  }
}
