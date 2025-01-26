import 'package:expense_tracker/features/auth/domain/repository/auth_repository.dart';

class SignOutUseCase {
  final AuthRepository _authRepository;
  const SignOutUseCase(this._authRepository);

  Future<void> execute() async {
    try {
      return await _authRepository.signOut();
    } catch (e) {
      throw Exception(e);
    }
  }
}
