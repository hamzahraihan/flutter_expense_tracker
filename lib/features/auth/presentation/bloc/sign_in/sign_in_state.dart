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

extension ErrorStatusX on ErrorStatus {
  bool get initial => this == ErrorStatus.initial;
  bool get wrongPassword => this == ErrorStatus.wrongPassword;
  bool get userNotFound => this == ErrorStatus.userNotFound;
}

class SignInState extends Equatable {
  final String? name;
  final Email? email;
  final Password? password;
  final EmailStatus emailStatus;
  final FormStatus formStatus;
  final PasswordStatus passwordStatus;
  final ErrorStatus errorType;

  const SignInState(
      {this.name,
      this.email,
      this.password,
      this.emailStatus = EmailStatus.unknown,
      this.passwordStatus = PasswordStatus.unknown,
      this.formStatus = FormStatus.initial,
      this.errorType = ErrorStatus.initial});

  SignInState copyWith(
      {String? name,
      Email? email,
      Password? password,
      EmailStatus? emailStatus,
      PasswordStatus? passwordStatus,
      FormStatus? formStatus,
      ErrorStatus? errorType}) {
    return SignInState(
        name: name ?? this.name,
        email: email ?? this.email,
        password: password ?? this.password,
        emailStatus: emailStatus ?? this.emailStatus,
        passwordStatus: passwordStatus ?? this.passwordStatus,
        formStatus: formStatus ?? this.formStatus,
        errorType: errorType ?? this.errorType);
  }

  @override
  List<Object?> get props => [
        name,
        email,
        password,
        emailStatus,
        passwordStatus,
        formStatus,
        errorType
      ];
}
