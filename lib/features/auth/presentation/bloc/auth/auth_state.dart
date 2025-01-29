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
  const AuthState({AuthEntities user = AuthEntities.empty})
      : this._(
          authStatus: user == AuthEntities.empty
              ? AuthStatus.unauthenticated
              : AuthStatus.authenticated,
          user: user,
        );

  const AuthState._(
      {this.user = AuthEntities.empty, required this.authStatus});

  final AuthEntities user;
  final AuthStatus authStatus;

  @override
  List<Object?> get props => [user, authStatus];
}
