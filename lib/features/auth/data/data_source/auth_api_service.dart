import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_tracker/features/auth/data/model/auth_model.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthApiService {
  AuthApiService(
      {firebase_auth.FirebaseAuth? firebaseAuth,
      GoogleSignIn? googleSignIn})
      : _firebaseAuth =
            firebaseAuth ?? firebase_auth.FirebaseAuth.instance,
        _googleSignIn = googleSignIn ?? GoogleSignIn.standard();

  final firebase_auth.FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;
  final FirebaseFirestore db = FirebaseFirestore.instance;

  /// Stream of [User] which will emit the current user when
  /// the authentication state changes.
  Stream<AuthModel?> get user {
    return _firebaseAuth.authStateChanges().map((firebaseUser) {
      if (firebaseUser == null) {
        return null;
      }
      return AuthModel.fromFirebaseAuthUser(firebaseUser);
    });
  }

  Future<AuthModel> signUpWithEmailAndPassword(
      {required String name,
      required String email,
      required String password}) async {
    try {
      firebase_auth.UserCredential credential =
          await _firebaseAuth.createUserWithEmailAndPassword(
              email: email, password: password);

      AuthModel user = AuthModel(
        uid: credential.user!.uid.toString(),
        name: name,
        email: credential.user!.email.toString(),
      );

      if (credential.user == null) {
        throw Exception(
            'Sign up failed: The user is null after sign up.');
      }
      await db
          .collection('users')
          .doc(credential.user!.uid)
          .set(user.toFirestore());

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
    } on firebase_auth.FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw Exception('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        throw Exception('Wrong password provided for that user.');
      }
      log(e.code);
      throw Exception(e);
    } catch (e) {
      throw Exception(e);
    }
  }

  /// Starts the Sign In with Google Flow.
  Future<void> signInWithGoogle() async {
    try {
      late final firebase_auth.AuthCredential credential;

      if (kIsWeb) {
        final firebase_auth.GoogleAuthProvider googleProvider =
            firebase_auth.GoogleAuthProvider();
        final firebase_auth.UserCredential userCredential =
            await _firebaseAuth.signInWithPopup(googleProvider);

        credential = userCredential.credential!;
      } else {
        final GoogleSignInAccount? googleUser =
            await _googleSignIn.signIn();
        final GoogleSignInAuthentication googleAuth =
            await googleUser!.authentication;

        credential = firebase_auth.GoogleAuthProvider.credential(
            accessToken: googleAuth.accessToken,
            idToken: googleAuth.idToken);
      }

      await _firebaseAuth.signInWithCredential(credential);
    } catch (e) {
      throw Exception('Google login has failed: $e');
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
