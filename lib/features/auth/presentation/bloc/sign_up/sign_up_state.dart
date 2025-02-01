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
  final String? name;
  final Email? email;
  final Password? password;
  final EmailStatus emailStatus;
  final UsernameStatus usernameStatus;
  final FormStatus formStatus;
  final PasswordStatus passwordStatus;

  const SignUpState({
    this.name,
    this.email,
    this.password,
    this.usernameStatus = UsernameStatus.unknown,
    this.emailStatus = EmailStatus.unknown,
    this.passwordStatus = PasswordStatus.unknown,
    this.formStatus = FormStatus.initial,
  });

  SignUpState copyWith({
    String? name,
    Email? email,
    Password? password,
    UsernameStatus? usernameStatus,
    EmailStatus? emailStatus,
    PasswordStatus? passwordStatus,
    FormStatus? formStatus,
  }) {
    return SignUpState(
        name: name ?? this.name,
        email: email ?? this.email,
        password: password ?? this.password,
        usernameStatus: usernameStatus ?? this.usernameStatus,
        emailStatus: emailStatus ?? this.emailStatus,
        passwordStatus: passwordStatus ?? this.passwordStatus,
        formStatus: formStatus ?? this.formStatus);
  }

  @override
  List<Object?> get props => [
        name,
        email,
        password,
        usernameStatus,
        emailStatus,
        passwordStatus,
        formStatus
      ];
}
