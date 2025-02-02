import 'package:expense_tracker/features/auth/domain/entity/auth_entities.dart';
import 'package:expense_tracker/features/auth/domain/repository/auth_repository.dart';
import 'package:expense_tracker/features/auth/domain/value_object/email.dart';
import 'package:expense_tracker/features/auth/domain/value_object/password.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignInUseCase {
  final AuthRepository _authRepository;
  SignInUseCase(this._authRepository);

  Future<AuthEntities> withCredential(SignInParams params) async {
    try {
      return await _authRepository.signInWithEmailAndPassword(
          email: params.email.value, password: params.password.value);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw Exception('user-not-found');
      } else if (e.code == 'wrong-password') {
        throw Exception('wrong-password');
      }
      throw Exception('Sign in failed: $e');
    }
  }

  Future<void> withGoogle() async {
    return await _authRepository.signInWithGoogle();
  }
}

class SignInParams {
  final Email email;
  final Password password;

  SignInParams({required this.email, required this.password});
}
