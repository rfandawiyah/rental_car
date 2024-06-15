import 'dart:convert';

List<RentModel> rentModelFromJson(String str) => 
    List<RentModel>.from(json.decode(str).map((x) => RentModel.fromJson(x)));

String rentModelToJson(List<RentModel> data) => 
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class RentModel {
  final int idSewa;
  final DateTime tglSewa;
  final DateTime tglPembayaran;
  final String status;
  final double total;
  final String NIK;

  RentModel({
    required this.idSewa,
    required this.tglSewa,
    required this.tglPembayaran,
    required this.status,
    required this.total,
    required this.NIK,
  });

  factory RentModel.fromJson(Map<String, dynamic> json) => RentModel(
        idSewa: json["id_sewa"],
        tglSewa: DateTime.parse(json["tgl_sewa"]),
        tglPembayaran: DateTime.parse(json["tgl_pembayaran"]),
        status: json["status"],
        total: json["total"].toDouble(),
        NIK: json["NIK"],
      );

  Map<String, dynamic> toJson() => {
        "id_sewa": idSewa,
        "tgl_sewa": tglSewa.toIso8601String(),
        "tgl_pembayaran": tglPembayaran.toIso8601String(),
        "status": status,
        "total": total,
        "NIK": NIK,
      };
}
