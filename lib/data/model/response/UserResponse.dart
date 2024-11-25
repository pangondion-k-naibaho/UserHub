import 'package:json_annotation/json_annotation.dart';

part 'UserResponse.g.dart';

@JsonSerializable()
class UserResponse {
  final int? id;
  final String? email;
  final String? firstName;
  final String? lastName;
  final String? avatar;

  UserResponse({
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.avatar,
  });

  factory UserResponse.fromJson(Map<String, dynamic> json) =>
      _$UserResponseFromJson(json);

  Map<String, dynamic> toJson() => _$UserResponseToJson(this);

  @override
  String toString() {
    return 'User{id: $id, email: $email, firstName: $firstName, lastName: $lastName, avatar: $avatar}';
  }
}
