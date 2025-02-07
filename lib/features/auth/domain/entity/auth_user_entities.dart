import 'package:equatable/equatable.dart';

class AuthUserEntities extends Equatable {
  final String uid;
  final String email;
  final String? name;
  final String? imageUrl;

  const AuthUserEntities({
    required this.uid,
    required this.email,
    this.name,
    this.imageUrl,
  });

  static const AuthUserEntities empty =
      AuthUserEntities(uid: '', email: '', name: '', imageUrl: '');

  bool get isEmpty => this == AuthUserEntities.empty;

  @override
  List<Object?> get props => [uid, email, name, imageUrl];
}
