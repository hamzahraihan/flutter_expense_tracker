import 'package:expense_tracker/features/auth/domain/repository/auth_repository.dart';

class SignInWithGoogleUseCase {
  final AuthRepository _authRepository;
  SignInWithGoogleUseCase(this._authRepository);

  Future<void> execute() async {
    try {
      return await _authRepository.signInWithGoogle();
    } catch (e) {
      throw Exception(e);
    }
  }
}
