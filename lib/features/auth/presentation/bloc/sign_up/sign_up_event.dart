import 'package:equatable/equatable.dart';

sealed class SignUpEvent extends Equatable {
  const SignUpEvent();

  @override
  List<Object?> get props => [];
}

final class UsernameChanged extends SignUpEvent {
  final String? name;
  const UsernameChanged(this.name);

  @override
  List<Object?> get props => [name];
}

final class EmailChanged extends SignUpEvent {
  final String? email;
  const EmailChanged(this.email);

  @override
  List<Object?> get props => [email];
}

final class PasswordChanged extends SignUpEvent {
  final String password;
  const PasswordChanged(this.password);

  @override
  List<Object?> get props => [password];
}

final class SignUpWithEmailAndPassword extends SignUpEvent {
  const SignUpWithEmailAndPassword();
}

final class SignUpWithGoogle extends SignUpEvent {
  const SignUpWithGoogle();
}
