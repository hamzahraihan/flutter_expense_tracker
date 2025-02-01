import 'package:expense_tracker/features/auth/domain/entity/auth_entities.dart';
import 'package:expense_tracker/features/auth/domain/repository/auth_repository.dart';
import 'package:expense_tracker/features/auth/domain/value_object/email.dart';
import 'package:expense_tracker/features/auth/domain/value_object/password.dart';

class SignInUseCase {
  final AuthRepository _authRepository;
  SignInUseCase(this._authRepository);

  Future<AuthEntities> withCredential(SignInParams params) async {
    try {
      return await _authRepository.signInWithEmailAndPassword(
          email: params.email.value, password: params.password.value);
    } catch (e) {
      throw Exception(e);
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
