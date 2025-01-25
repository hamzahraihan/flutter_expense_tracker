import 'package:expense_tracker/features/auth/domain/entity/auth_entities.dart';
import 'package:expense_tracker/features/auth/domain/repository/auth_repository.dart';
import 'package:expense_tracker/features/auth/domain/value_object/email.dart';
import 'package:expense_tracker/features/auth/domain/value_object/password.dart';

class SignUpUseCase {
  final AuthRepository _authRepository;
  SignUpUseCase(this._authRepository);

  Future<AuthEntities> execute(SignUpParams params) async {
    try {
      return await _authRepository.signUpWithEmailAndPassword(
          email: params.email.value, password: params.password.value);
    } catch (e) {
      throw Exception(e);
    }
  }
}

class SignUpParams {
  final Email email;
  final Password password;
  SignUpParams({required this.email, required this.password});
}
