import 'dart:convert';

class AuthResponseModel {
  final String? accessToken;
  final User? user;

  AuthResponseModel({
    this.accessToken,
    this.user,
  });

  factory AuthResponseModel.fromJson(Map<String, dynamic> json) =>
      AuthResponseModel.fromMap(json);

  String toJson() => json.encode(toMap());

  factory AuthResponseModel.fromMap(Map<String, dynamic> json) =>
      AuthResponseModel(
        accessToken: json["access_token"],
        user: json["result"] == null ? null : User.fromMap(json["result"]),
      );

  Map<String, dynamic> toMap() => {
        "access_token": accessToken,
        "user": user?.toMap(),
      };

  @override
  String toString() =>
      'AuthResponseModel(accessToken: $accessToken, user: $user)';
}

class User {
  final int? id;
  final String? name;
  final String? email;
  final String? password;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  User({
    this.id,
    this.name,
    this.email,
    this.password,
    this.createdAt,
    this.updatedAt,
  });

  factory User.fromJson(String str) => User.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory User.fromMap(Map<String, dynamic> json) => User(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        password: json["password"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "email": email,
        "password": password,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
