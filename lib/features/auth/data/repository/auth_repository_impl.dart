import 'package:expense_tracker/features/auth/data/data_source/auth_api_service.dart';

import 'package:expense_tracker/features/auth/domain/repository/auth_repository.dart';

// TODO implement auth repository
class AuthRepositoryImpl extends AuthRepository {
  final AuthApiService _authApiService;
  AuthRepositoryImpl(this._authApiService);
}
