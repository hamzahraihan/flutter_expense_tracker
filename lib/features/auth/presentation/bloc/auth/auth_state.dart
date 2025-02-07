import 'package:equatable/equatable.dart';
import 'package:expense_tracker/features/auth/domain/entity/auth_user_entities.dart';

enum AuthStatus { authenticated, unauthenticated, loading, failure }

extension AuthStatusX on AuthStatus {
  bool get isAuthenticated => this == AuthStatus.authenticated;
  bool get isLoading => this == AuthStatus.loading;
  bool get isUnauthenticated => this == AuthStatus.unauthenticated;
  bool get isFailure => this == AuthStatus.failure;
}

class AuthState extends Equatable {
  const AuthState({AuthUserEntities user = AuthUserEntities.empty})
      : this._(
          authStatus: user == AuthUserEntities.empty
              ? AuthStatus.unauthenticated
              : AuthStatus.authenticated,
          user: user,
        );

  const AuthState._(
      {this.user = AuthUserEntities.empty, required this.authStatus});

  final AuthUserEntities user;
  final AuthStatus authStatus;

  @override
  List<Object?> get props => [user, authStatus];
}
