import 'dart:convert';

List<CustomersModel> customersModelFromJson(String str) =>
  List<CustomersModel>.from(
    json.decode(str).map((x) => CustomersModel.fromJson(x)));

String customersModelToJson(List<CustomersModel> data) =>
  json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CustomersModel {
  final String NIK;
  final String nama;
  final String noTelephon;
  final String alamat;
  final DateTime createdAt;
  final DateTime updatedAt;

  CustomersModel({
    required this.NIK,
    required this.nama,
    required this.noTelephon,
    required this.alamat,
    required this.createdAt,
    required this.updatedAt,
  });

  factory CustomersModel.fromJson(Map<String, dynamic> json) => CustomersModel(
        NIK: json["NIK"],
        nama: json["nama"],
        noTelephon: json["no_telephon"],
        alamat: json["alamat"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );
  
  Map<String, dynamic> toJson() => {
        "NIK": NIK,
        "nama": nama,
        "no_telephon": noTelephon,
        "alamat": alamat,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
  };
}