import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:expense_tracker/features/auth/domain/entity/auth_entities.dart';

class AuthModel extends AuthEntities {
  const AuthModel({
    required super.uid,
    required super.email,
    super.name,
    super.imageUrl,
  });

  factory AuthModel.fromFirebaseAuthUser(
      firebase_auth.User firebaseUser) {
    return AuthModel(
        uid: firebaseUser.uid,
        email: firebaseUser.email ?? '',
        name: firebaseUser.displayName,
        imageUrl: firebaseUser.photoURL);
  }

  AuthModel toEntity() {
    return AuthModel(
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
