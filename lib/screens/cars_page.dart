import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:rental_car/models/mobil_models.dart';
import 'dart:convert';

import 'package:rental_car/service/global_variable.dart';

class CarList extends StatefulWidget {
  const CarList({super.key});

  @override
  _CarListState createState() => _CarListState();
}

class _CarListState extends State<CarList> {
  List<MobilSayaModel> mobilList = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final response =
        await http.get(Uri.parse('${GlobalVariable.baseUrl}/api/cars'));
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      setState(() {
       mobilList = data.map((item) {
          MobilSayaModel mobil = MobilSayaModel.fromJson(item);
          // Correct the image URL by removing "public/" from the path if it exists
          String imagePath = mobil.gambar.replaceFirst('public/gambar/', '');
          mobil.gambar = '${GlobalVariable.baseUrlImage}$imagePath';
          return mobil;
        }).toList();
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Car List'),
      ),
      body: ListView.builder(
        itemCount: mobilList.length,
        itemBuilder: (context, index) {
          final car = mobilList[index];
          return ListTile(
            leading: Image.network(
              car.gambar.contains('http') ? car.gambar :
              '${GlobalVariable.baseUrlImage}${car.gambar}',
              width: 100,
              height: 100,
              fit: BoxFit.cover,
            ),
            title: Text(car.nopol),
            subtitle: Text(car.merkmobil),
          );
        },
      ),
    );
  }
}

class Car {
  final String nopol;
  final String merkmobil;
  final String image;

  Car({
    required this.nopol,
    required this.merkmobil,
    required this.image,
  });

  factory Car.fromJson(Map<String, dynamic> json) {
    return Car(
      nopol: json['nopol'],
      merkmobil: json['merkmobil'],
      image: json['gambar'],
    );
  }
}
