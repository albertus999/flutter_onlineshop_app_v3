import 'package:meta/meta.dart';
import 'dart:convert';

class AuthResponseModel {
    final String accessToken;
    final User user;

    AuthResponseModel({
        required this.accessToken,
        required this.user,
    });

    factory AuthResponseModel.fromJson(String str) => AuthResponseModel.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory AuthResponseModel.fromMap(Map<String, dynamic> json) => AuthResponseModel(
        accessToken: json["access_token"],
        user: User.fromMap(json["user"]),
    );

    Map<String, dynamic> toMap() => {
        "access_token": accessToken,
        "user": user.toMap(),
    };
}

class User {
    final String name;
    final String email;
    final String phone;
    final String roles;
    final DateTime updatedAt;
    final DateTime createdAt;
    final int id;

    User({
        required this.name,
        required this.email,
        required this.phone,
        required this.roles,
        required this.updatedAt,
        required this.createdAt,
        required this.id,
    });

    factory User.fromJson(String str) => User.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory User.fromMap(Map<String, dynamic> json) => User(
        name: json["name"],
        email: json["email"],
        phone: json["phone"],
        roles: json["roles"] ?? 'USER',
        updatedAt: DateTime.parse(json["updated_at"]),
        createdAt: DateTime.parse(json["created_at"]),
        id: json["id"],
    );

    Map<String, dynamic> toMap() => {
        "name": name,
        "email": email,
        "phone": phone,
        "roles": roles,
        "updated_at": updatedAt.toIso8601String(),
        "created_at": createdAt.toIso8601String(),
        "id": id,
    };
}
