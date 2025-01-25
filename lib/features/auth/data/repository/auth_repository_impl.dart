import 'package:expense_tracker/features/auth/data/data_source/auth_api_service.dart';
import 'package:expense_tracker/features/auth/domain/entity/auth_entities.dart';

import 'package:expense_tracker/features/auth/domain/repository/auth_repository.dart';

class AuthRepositoryImpl extends AuthRepository {
  final AuthApiService _authApiService;
  AuthRepositoryImpl(this._authApiService);

  @override
  Stream<AuthEntities> get authUser {
    return _authApiService.user.map((userModel) => userModel == null
        ? AuthEntities.empty
        : userModel.toEntity());
  }

  @override
  Future<AuthEntities> signUpWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      return await _authApiService.signUpWithEmailAndPassword(
          email: email, password: password);
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<AuthEntities> signInWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      return await _authApiService.signInWithEmailAndPassword(
          email: email, password: password);
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await _authApiService.signOut();
    } catch (e) {
      throw Exception(e);
    }
  }
}
