import 'package:flutter/material.dart';
import 'package:rental_car/models/mobil_models.dart';
import 'package:rental_car/service/global_variable.dart';

class CardMobil extends StatelessWidget {
  final MobilSayaModel mobil;

  const CardMobil({super.key, required this.mobil});

  @override
  Widget build(BuildContext context) {
    String imageUrl = '${GlobalVariable.baseUrl}/gambar/${mobil.gambar}';
    return Card(
      child: Column(
        children: [
          Image.network(
            mobil.gambar.contains('http') ? mobil.gambar : imageUrl,
            fit: BoxFit.cover,
            height: 150,
            width: 150,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  mobil.merkmobil,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(mobil.deskripsi),
                const SizedBox(height: 4),
                Text('Harga: ${mobil.harga}'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
