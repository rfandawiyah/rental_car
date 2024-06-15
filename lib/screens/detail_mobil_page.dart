import 'package:flutter/material.dart';
import 'package:rental_car/models/mobil_models.dart';
import 'data_diri_page.dart'; // Import halaman DataDiriPage

class DetailMobilPage extends StatelessWidget {
  final MobilSayaModel mobil;

  const DetailMobilPage({super.key, required this.mobil});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Mobil'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              mobil.gambar,
              width: double.infinity,
              height: 200,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 16),
            Text(
              mobil.merkmobil,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'No. Polisi: ${mobil.nopol}',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 8),
            Text(
              'Type: ${mobil.type}',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 8),
            Text(
              'Harga: Rp ${mobil.harga}',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const DataDiriPage(),
                  ),
                );
              },
              child: const Text('Pesan Sekarang'),
            ),
          ],
        ),
      ),
    );
  }
}
