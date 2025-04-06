
import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  final String? email;
  final String? message;
  final String? role;
  final String? status;
  final int? userId;
  final String? username;

  User({
    this.email,
    this.message,
    this.role,
    this.status,
    this.userId,
    this.username,
  });

  User copyWith({
    String? email,
    String? message,
    String? role,
    String? status,
    int? userId,
    String? username,
  }) =>
      User(
        email: email ?? this.email,
        message: message ?? this.message,
        role: role ?? this.role,
        status: status ?? this.status,
        userId: userId ?? this.userId,
        username: username ?? this.username,
      );

  factory User.fromJson(Map<String, dynamic> json) => User(
        email: json["email"],
        message: json["message"],
        role: json["role"],
        status: json["status"],
        userId: json["userId"],
        username: json["username"],
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "message": message,
        "role": role,
        "status": status,
        "userId": userId,
        "username": username,
      };
}
