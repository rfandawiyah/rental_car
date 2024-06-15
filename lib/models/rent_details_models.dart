import 'dart:convert';

List<RentDetailModel> rentDetailModelFromJson(String str) => 
    List<RentDetailModel>.from(json.decode(str).map((x) => RentDetailModel.fromJson(x)));

String rentDetailModelToJson(List<RentDetailModel> data) => 
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class RentDetailModel {
  final int idSewa;
  final String nopol;
  final int lamaSewa;
  final DateTime tglPengembalian;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  RentDetailModel({
    required this.idSewa,
    required this.nopol,
    required this.lamaSewa,
    required this.tglPengembalian,
    this.createdAt,
    this.updatedAt,
  });

  factory RentDetailModel.fromJson(Map<String, dynamic> json) => RentDetailModel(
        idSewa: json["id_sewa"],
        nopol: json["nopol"],
        lamaSewa: json["lama_sewa"],
        tglPengembalian: DateTime.parse(json["tgl_pengembalian"]),
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id_sewa": idSewa,
        "nopol": nopol,
        "lama_sewa": lamaSewa,
        "tgl_pengembalian": tglPengembalian.toIso8601String(),
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
