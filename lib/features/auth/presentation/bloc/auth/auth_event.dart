import 'package:equatable/equatable.dart';
import 'package:expense_tracker/features/auth/domain/entity/auth_user_entities.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

final class Authenticated extends AuthEvent {
  final Stream<AuthUserEntities?> user;
  const Authenticated(this.user);

  @override
  List<Object?> get props => [user];
}

final class Unauthenticated extends AuthEvent {
  const Unauthenticated();
}

final class SignOutPressed extends AuthEvent {
  const SignOutPressed();
}
