import 'dart:convert';

List<LoginCustomerModel> loginCustomerModelFromJson(String str) => 
    List<LoginCustomerModel>.from(json.decode(str).map((x) => LoginCustomerModel.fromJson(x)));

String loginCustomerModelToJson(List<LoginCustomerModel> data) => 
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class LoginCustomerModel {
  final int id;
  final String name;
  final String email;
  final String password;
  final String? rememberToken;

  LoginCustomerModel({
    required this.id,
    required this.name,
    required this.email,
    required this.password,
    this.rememberToken,
  });

  factory LoginCustomerModel.fromJson(Map<String, dynamic> json) => LoginCustomerModel(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        password: json["password"],
        rememberToken: json["remember_token"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "password": password,
        "remember_token": rememberToken,
      };
}
