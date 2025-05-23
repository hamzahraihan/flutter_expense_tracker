import 'package:expense_tracker/features/auth/domain/entity/auth_user_entities.dart';
import 'package:expense_tracker/features/auth/domain/repository/auth_repository.dart';
import 'package:expense_tracker/features/auth/domain/value_object/email.dart';
import 'package:expense_tracker/features/auth/domain/value_object/password.dart';
import 'package:expense_tracker/services/firebase.dart';

class SignInUseCase {
  final AuthRepository _authRepository;
  SignInUseCase(this._authRepository);

  Future<AuthUserEntities> withCredential(SignInParams params) async {
    try {
      return await _authRepository.signInWithEmailAndPassword(
          email: params.email.value, password: params.password.value);
    } catch (e) {
      print('error from use case ${e}');
      throw SignInWithEmailAndPasswordFailure(e.toString());
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
