import 'package:equatable/equatable.dart';
import 'package:expense_tracker/features/auth/domain/entity/auth_entities.dart';

enum AuthStatusX { authenticated, unauthenticated, loading }

class AuthState extends Equatable {
  final AuthEntities? user;
  final String? message;
  final AuthStatusX? authStatus;

  const AuthState({this.user, this.message, this.authStatus});

  AuthState copyWith(
      {AuthEntities? user,
      String? message,
      AuthStatusX? authStatus}) {
    return AuthState(
        user: user ?? this.user,
        message: message ?? this.message,
        authStatus: authStatus ?? this.authStatus);
  }

  @override
  List<Object?> get props => [user, message, authStatus];
}
