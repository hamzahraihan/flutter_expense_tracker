import 'package:equatable/equatable.dart';

class AuthEntities extends Equatable {
  final String uid;
  final String email;
  final String? name;
  final String? imageUrl;

  const AuthEntities({
    required this.uid,
    required this.email,
    this.name,
    this.imageUrl,
  });

  static const AuthEntities empty =
      AuthEntities(uid: '', email: '', name: '', imageUrl: '');

  bool get isEmpty => this == AuthEntities.empty;

  @override
  List<Object?> get props => [uid, email, name, imageUrl];
}
