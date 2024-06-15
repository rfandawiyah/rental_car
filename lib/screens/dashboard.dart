import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:http/http.dart' as http;
import 'package:rental_car/Theme.dart';
import 'package:rental_car/models/mobil_models.dart';
import 'package:rental_car/service/global_variable.dart';
import 'package:rental_car/widgets/mobil_card.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  List<MobilSayaModel> mobilList = [];

  @override
  void initState() {
    super.initState();
    fetchMobilData();
  }

  Future<void> fetchMobilData() async {
    final response =
        await http.get(Uri.parse('${GlobalVariable.baseUrl}/api/cars'));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      setState(() {
        mobilList = data.map((item) {
          MobilSayaModel mobil = MobilSayaModel.fromJson(item);
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
      backgroundColor: lightBackgroundColor,
      appBar: AppBar(
        backgroundColor: whiteColor,
        title: Text(
          "Dashboard",
          style: greyTextStyle.copyWith(
            fontWeight: semiBold,
            fontSize: 14,
            letterSpacing: 0.1,
          ),
        ),
        centerTitle: false,
      ),
      body: mobilList.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CarouselSlider(
                    options: CarouselOptions(
                      height: 200.0,
                      aspectRatio: 16 / 9,
                      viewportFraction: 0.8,
                      initialPage: 0,
                      enableInfiniteScroll: true,
                      reverse: false,
                      autoPlay: true,
                      autoPlayInterval: const Duration(seconds: 3),
                      autoPlayAnimationDuration:
                          const Duration(milliseconds: 800),
                      autoPlayCurve: Curves.fastOutSlowIn,
                      enlargeCenterPage: true,
                      scrollDirection: Axis.horizontal,
                    ),
                    items: mobilList.map((mobil) {
                      return Builder(
                        builder: (BuildContext context) {
                          return Container(
                            width: MediaQuery.of(context).size.width,
                            margin: const EdgeInsets.symmetric(horizontal: 5.0),
                            decoration: const BoxDecoration(
                              color: Colors.amber,
                            ),
                            child: Image.network(
                              mobil.gambar,
                              fit: BoxFit.cover,
                            ),
                          );
                        },
                      );
                    }).toList(),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      "Welcome to Rental Mobile",
                      style: blackTextStyle.copyWith(
                        fontWeight: bold,
                        fontSize: 24,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(16),
                    margin: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: whiteColor,
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
                        Text(
                          "Search for Cars",
                          style: blackTextStyle.copyWith(
                            fontWeight: semiBold,
                            fontSize: 18,
                          ),
                        ),
                        const SizedBox(height: 12),
                        TextFormField(
                          decoration: const InputDecoration(
                            hintText: "Search...",
                            prefixIcon: Icon(Icons.search),
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      "Mobil Tersedia",
                      style: blackTextStyle.copyWith(
                        fontWeight: bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: mobilList.map((mobil) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: CardMobil(mobil: mobil),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
