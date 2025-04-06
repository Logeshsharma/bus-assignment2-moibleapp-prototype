import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class LoginController extends GetxController {
  RxBool loadingState = false.obs;

  RxBool obscureText = true.obs;

  Future<void> login(String username, String password) async {
    loadingState(true);

    var response = await http.post(
      Uri.parse('https://bus-test-f592.onrender.com/mobile_login'),
      body: json.encode({"username": "amy", "password": "amy.pw"}),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      loadingState(false);
      // return User.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
    } else {
      loadingState(false);
      throw Exception('Internal server issue');
    }
  }
}

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
