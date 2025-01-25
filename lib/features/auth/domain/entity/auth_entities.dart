import 'package:equatable/equatable.dart';

class AuthEntities extends Equatable {
  final String uuid;
  final String email;
  final String? name;
  final String? imageUrl;

  const AuthEntities({
    required this.uuid,
    required this.email,
    this.name,
    this.imageUrl,
  });

  @override
  List<Object?> get props => [uuid, email, name, imageUrl];
}
