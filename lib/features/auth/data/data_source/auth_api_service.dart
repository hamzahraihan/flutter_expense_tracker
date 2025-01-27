import 'package:expense_tracker/features/auth/data/model/auth_model.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;

class AuthApiService {
  AuthApiService({firebase_auth.FirebaseAuth? firebaseAuth})
      : _firebaseAuth =
            firebaseAuth ?? firebase_auth.FirebaseAuth.instance;

  final firebase_auth.FirebaseAuth _firebaseAuth;

  Stream<AuthModel?> get user {
    return _firebaseAuth.authStateChanges().map((firebaseUser) {
      if (firebaseUser == null) {
        return null;
      }
      return AuthModel.fromFirebaseAuthUser(firebaseUser);
    });
  }

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

  Future<AuthModel> signInWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      firebase_auth.UserCredential credential =
          await _firebaseAuth.signInWithEmailAndPassword(
              email: email, password: password);

      if (credential.user == null) {
        throw Exception(
            'Sign in failed: The user is null after sign in.');
      }
      return AuthModel.fromFirebaseAuthUser(credential.user!);
    } catch (e) {
      throw Exception('An exception has occurred: $e');
    }
  }

  Future<void> signOut() async {
    try {
      await _firebaseAuth.signOut();
    } catch (e) {
      throw Exception('An exception has occurred: $e');
    }
  }
}
