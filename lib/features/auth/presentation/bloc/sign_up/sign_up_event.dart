import 'package:equatable/equatable.dart';

class SignUpEvent extends Equatable {
  const SignUpEvent();
  @override
  List<Object?> get props => [];
}

final class SignUpWithEmailAndPassword extends SignUpEvent {
  final String email;
  final String password;

  const SignUpWithEmailAndPassword(
      {required this.email, required this.password});

  @override
  List<Object?> get props => [email, password];
}
