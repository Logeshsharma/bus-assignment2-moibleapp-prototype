import 'dart:convert';
import 'dart:math';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

List<String> images = [
  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS7-aGpatw32H3vwj6ZVhJew0zFKD-R1UlzL-N1AUu2kQ&s",
  "https://a.storyblok.com/f/191576/1200x800/faa88c639f/round_profil_picture_before_.webp",
  "https://img.freepik.com/free-photo/freedom-concept-with-hiker-mountain_23-2148107064.jpg",
  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTqZZYSsnncqDhroX4Ud9rgHCxpDeyLSN5PdG71BuDAk-ulL4CQCFtjL4lKVH26UIW9EOo&usqp=CAU",
  "https://www.shutterstock.com/image-photo/profile-picture-smiling-millennial-asian-600nw-1836020740.jpg",
  "https://media.istockphoto.com/id/1300512215/photo/headshot-portrait-of-smiling-ethnic-businessman-in-office.jpg?s=612x612&w=0&k=20&c=QjebAlXBgee05B3rcLDAtOaMtmdLjtZ5Yg9IJoiy-VY=",
];

class User {
  final String? email;
  final String? message;
  final String? role;
  final String? status;
  final int? id;
  final String? username;
  final int? groupId;
  final String? image;

  User({
    this.email,
    this.message,
    this.role,
    this.status,
    this.id,
    this.username,
    this.groupId,
    this.image,
  });

  User copyWith({
    String? email,
    String? message,
    String? role,
    String? status,
    int? id,
    String? username,
    int? groupId,
    String? image,
  }) =>
      User(
          email: email ?? this.email,
          message: message ?? this.message,
          role: role ?? this.role,
          status: status ?? this.status,
          id: id ?? this.id,
          groupId: groupId ?? this.groupId,
          username: username ?? this.username,
          image: image ?? this.image);

  factory User.fromJson(Map<String, dynamic> json) => User(
        email: json["email"],
        message: json["message"],
        role: json["role"],
        status: json["status"],
        id: json["id"],
        groupId: json["groupId"],
        username: json["username"],
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "message": message,
        "role": role,
        "status": status,
        "id": id,
        "groupId": groupId,
        "username": username,
      };

  static String getRandomImage() {
    Random random = Random();
    return images[random.nextInt(images.length)];
  }
}
