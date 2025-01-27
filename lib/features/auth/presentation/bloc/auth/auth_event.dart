import 'package:equatable/equatable.dart';
import 'package:expense_tracker/features/auth/domain/entity/auth_entities.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

final class Authenticated extends AuthEvent {
  final AuthEntities? user;
  const Authenticated(this.user);

  @override
  List<Object?> get props => [user];
}

final class Unauthenticated extends AuthEvent {
  const Unauthenticated();
}

final class AuthLoading extends AuthEvent {
  const AuthLoading();
}

final class AuthError extends AuthEvent {
  final String message;
  const AuthError(this.message);

  @override
  List<Object?> get props => [message];
}
