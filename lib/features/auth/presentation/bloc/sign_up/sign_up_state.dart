import 'package:equatable/equatable.dart';
import 'package:expense_tracker/features/auth/domain/value_object/email.dart';
import 'package:expense_tracker/features/auth/domain/value_object/password.dart';
import 'package:expense_tracker/features/auth/presentation/bloc/status.dart';

extension FormStatusX on FormStatus {
  bool get initial => this == FormStatus.initial;
  bool get invalid => this == FormStatus.invalid;
  bool get submissionInProgress =>
      this == FormStatus.submissionInProgress;
  bool get submissionSuccess => this == FormStatus.submissionSuccess;
  bool get submissionFailure => this == FormStatus.submissionFailure;
}

class SignUpState extends Equatable {
  final Email? email;
  final Password? password;
  final EmailStatus emailStatus;
  final FormStatus formStatus;
  final PasswordStatus passwordStatus;

  const SignUpState({
    this.email,
    this.password,
    this.emailStatus = EmailStatus.unknown,
    this.passwordStatus = PasswordStatus.unknown,
    this.formStatus = FormStatus.initial,
  });

  SignUpState copyWith({
    Email? email,
    Password? password,
    EmailStatus? emailStatus,
    PasswordStatus? passwordStatus,
    FormStatus? formStatus,
  }) {
    return SignUpState(
        email: email ?? this.email,
        password: password ?? this.password,
        emailStatus: emailStatus ?? this.emailStatus,
        passwordStatus: passwordStatus ?? this.passwordStatus,
        formStatus: formStatus ?? this.formStatus);
  }

  @override
  List<Object?> get props =>
      [email, password, emailStatus, passwordStatus, formStatus];
}
