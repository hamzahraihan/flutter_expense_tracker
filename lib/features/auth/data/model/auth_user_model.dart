import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:expense_tracker/features/auth/domain/entity/auth_user_entities.dart';

class AuthUserModel extends AuthUserEntities {
  const AuthUserModel({
    required super.uid,
    required super.email,
    super.name,
    super.imageUrl,
  });

  factory AuthUserModel.fromFirebaseAuthUser(
      firebase_auth.User firebaseUser) {
    return AuthUserModel(
        uid: firebaseUser.uid,
        email: firebaseUser.email ?? '',
        name: firebaseUser.displayName ?? '',
        imageUrl: firebaseUser.photoURL);
  }

  AuthUserEntities toEntity() {
    return AuthUserEntities(
        uid: uid, email: email, name: name, imageUrl: imageUrl);
  }

  Map<String, dynamic> toFirestore() {
    return {
      'uid': uid,
      'email': email,
      'name': name,
      'imageUrl': imageUrl
    };
  }
}
