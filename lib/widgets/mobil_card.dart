import 'package:flutter/material.dart';
import 'package:rental_car/Theme.dart';
import 'package:rental_car/models/mobil_models.dart';
import 'package:rental_car/screens/detail_mobil_page.dart';
import 'package:rental_car/service/global_variable.dart';

class CardMobil extends StatelessWidget {
  final MobilSayaModel mobil;

  const CardMobil({super.key, required this.mobil});

  @override
  Widget build(BuildContext context) {
    // Ensure the image URL is correctly formatted
    final imageUrl = mobil.gambar.contains('http')
        ? mobil.gambar
        : '${GlobalVariable.baseUrlImage}${mobil.gambar}';

    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailMobilPage(mobil: mobil),
          ),
        );
      },
      child: Container(
        width: 150,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(12)),
              child: Image.network(
                imageUrl,
                fit: BoxFit.cover,
                height: 120,
                width: double.infinity,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                mobil.merkmobil,
                style: blackTextStyle.copyWith(
                  fontWeight: semiBold,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
