import 'package:equatable/equatable.dart';
import 'package:expense_tracker/features/auth/domain/entity/auth_entities.dart';

enum AuthStatus { authenticated, unauthenticated, loading, failure }

extension AuthStatusX on AuthStatus {
  bool get isAuthenticated => this == AuthStatus.authenticated;
  bool get isLoading => this == AuthStatus.loading;
  bool get isUnauthenticated => this == AuthStatus.unauthenticated;
  bool get isFailure => this == AuthStatus.failure;
}

class AuthState extends Equatable {
  final AuthEntities? user;
  final String? message;
  final AuthStatus? authStatus;

  const AuthState(
      {this.user,
      this.message,
      this.authStatus = AuthStatus.unauthenticated});

  AuthState copyWith(
      {AuthEntities? user, String? message, AuthStatus? authStatus}) {
    return AuthState(
        user: user ?? this.user,
        message: message ?? this.message,
        authStatus: authStatus ?? this.authStatus);
  }

  @override
  List<Object?> get props => [user, message, authStatus];
}
