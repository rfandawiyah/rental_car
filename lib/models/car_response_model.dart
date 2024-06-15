class MobilSayaModel {
  final String nopol;
  final String merkmobil;
  final double harga;
  final String type;
  final String status;
  final String gambar;
  final String deskripsi;
  final DateTime createdAt;
  final DateTime updatedAt;

  MobilSayaModel({
    required this.nopol,
    required this.merkmobil,
    required this.harga,
    required this.type,
    required this.status,
    required this.gambar,
    required this.deskripsi,
    required this.createdAt,
    required this.updatedAt,
  });

  factory MobilSayaModel.fromJson(Map<String, dynamic> json) {
    return MobilSayaModel(
      nopol: json['nopol'],
      merkmobil: json['merkmobil'],
      harga: double.parse(json['harga'].toString()), // Parsing harga as double
      type: json['type'],
      status: json['status'],
      gambar: json['gambar'],
      deskripsi: json['deskripsi'] ?? '', // Handle nullable deskripsi
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }
}
