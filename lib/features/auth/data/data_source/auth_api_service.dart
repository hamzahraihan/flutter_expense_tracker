import 'package:expense_tracker/features/auth/data/model/auth_model.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;

// TODO make an auth api service

class AuthApiService {
  AuthApiService({firebase_auth.FirebaseAuth? firebaseAuth})
      : _firebaseAuth =
            firebaseAuth ?? firebase_auth.FirebaseAuth.instance;

  final firebase_auth.FirebaseAuth _firebaseAuth;

  Future<AuthModel> signUpWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      firebase_auth.UserCredential credential =
          await _firebaseAuth.createUserWithEmailAndPassword(
              email: email, password: password);

      if (credential.user == null) {
        throw Exception(
            'Sign up failed: The user is null after sign up.');
      }
      return AuthModel.fromFirebaseAuthUser(credential.user!);
    } catch (e) {
      throw Exception('An exception has occurred: $e');
    }
  }
}
