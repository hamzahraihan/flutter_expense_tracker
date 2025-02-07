import 'dart:developer';

import 'package:expense_tracker/features/auth/data/data_source/auth_api_service.dart';
import 'package:expense_tracker/features/auth/data/model/auth_user_model.dart';
import 'package:expense_tracker/features/auth/domain/entity/auth_user_entities.dart';

import 'package:expense_tracker/features/auth/domain/repository/auth_repository.dart';

class AuthRepositoryImpl extends AuthRepository {
  final AuthApiService _authApiService;
  AuthRepositoryImpl(this._authApiService);

  @override
  Stream<AuthUserEntities> get authUser {
    return _authApiService.user.map((AuthUserModel? authUserModel) {
      log("Auth Repository: User Changed -> ${authUserModel?.email}");
      return authUserModel == null
          ? AuthUserEntities.empty
          : authUserModel.toEntity();
    });
  }

  @override
  Future<AuthUserEntities> signUpWithEmailAndPassword(
      {required String name,
      required String email,
      required String password}) async {
    try {
      return await _authApiService.signUpWithEmailAndPassword(
          name: name, email: email, password: password);
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<AuthUserEntities> signInWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      return await _authApiService.signInWithEmailAndPassword(
          email: email, password: password);
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<void> signInWithGoogle() async {
    try {
      return await _authApiService.signInWithGoogle();
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
