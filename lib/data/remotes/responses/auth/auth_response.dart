import 'package:net_module/net_module.dart';

class AuthResponse extends ResponseBase {
  AuthResponse({required this.user, required this.token});

  factory AuthResponse.fromJson(Map<String, dynamic> json) => AuthResponse(
        user: UserResponse.fromJson(json['user']),
        token: json['token'],
      );

  final UserResponse user;
  final String token;
}

class UserResponse {
  UserResponse({this.name, this.email, this.age});

  factory UserResponse.fromJson(Map<String, dynamic> json) => UserResponse(
        name: json['name'],
        email: json['email'],
        age: json['age'],
      );

  final String? name;
  final String? email;
  final int? age;
}
