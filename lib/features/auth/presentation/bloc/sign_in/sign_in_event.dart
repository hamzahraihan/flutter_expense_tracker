import 'package:equatable/equatable.dart';

sealed class SignInEvent extends Equatable {
  const SignInEvent();

  @override
  List<Object?> get props => [];
}

final class EmailChanged extends SignInEvent {
  final String email;
  const EmailChanged(this.email);

  @override
  List<Object?> get props => [email];
}

final class PasswordChanged extends SignInEvent {
  final String password;
  const PasswordChanged(this.password);

  @override
  List<Object?> get props => [password];
}

final class SignInWithEmailAndPassword extends SignInEvent {
  const SignInWithEmailAndPassword();
}

final class SignUpWithEmailAndPassword extends SignInEvent {
  final String email;
  final String password;

  const SignUpWithEmailAndPassword(
      {required this.email, required this.password});

  @override
  List<Object?> get props => [email, password];
}
