import 'dart:convert';

import 'package:assignment2_mobileapp_prototype/service/model/user.dart';

Group groupFromJson(String str) => Group.fromJson(json.decode(str));

String groupToJson(Group data) => json.encode(data.toJson());

class Group {
  final int? id;
  final String? name;
  final List<User>? users;

  Group({
    this.id,
    this.name,
    this.users,
  });

  Group copyWith({
    int? id,
    String? name,
    List<User>? users,
  }) =>
      Group(
        id: id ?? this.id,
        name: name ?? this.name,
        users: users ?? this.users,
      );

  factory Group.fromJson(Map<String, dynamic> json) => Group(
        id: json["id"],
        name: json["name"],
        users: json["users"] == null
            ? []
            : List<User>.from(json["users"]!.map((x) => User.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "users": users == null
            ? []
            : List<dynamic>.from(users!.map((x) => x.toJson())),
      };
}
