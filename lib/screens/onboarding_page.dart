// ignore_for_file: unused_import

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:rental_car/Theme.dart';
import 'package:rental_car/screens/signup.dart';
import 'package:rental_car/widgets/buttons.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({super.key});

  @override
  State<OnBoardingPage> createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  int currentIndex = 0;
  CarouselController carouselController = CarouselController();

  List<String> titles = [
    'Selamat datang di Aplikasi mobile_apps',
    'Kenapa harus mobile_apps?',
    'Cepat, Mudah, dan Solusi Keluarga!'
  ];

  List<String> subtitles = [
    'Temukan mobil solusi terbaik untuk perjalanan Anda',
    'Kami memberikan Anda akses ke beragam jenis mobil dengan spesifikasi yang unggul dan nyaman untuk dibawa perjalanan',
    'Jadilah bagian dari mobile_apps family. Ayo mulai perjalanan Anda bersama Keluarga tercinta dengan Aplikasi mobile_apps'
  ];

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: whiteColor,
      body: Column(
        //
        // mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CarouselSlider(
            items: [
              Image.asset(
                'assets/whitecar.jpg',
                height: size.height * .5,
                width: size.width,
                fit: BoxFit.cover,
              ),
              Image.asset(
                'assets/sedan.jpg',
                height: size.height * .5,
                width: size.width,
                fit: BoxFit.cover,
              ),
              Image.asset(
                'assets/familytrip.jpg',
                height: size.height * .5,
                width: size.width,
                fit: BoxFit.cover,
              ),
            ],
            options: CarouselOptions(
              height: size.height * .6,
              viewportFraction: 1,
              enableInfiniteScroll: false,
              onPageChanged: ((index, reason) => {
                    setState(() {
                      currentIndex = index;
                    })
                  }),
            ),
            carouselController: carouselController,
          ),
          // const SizedBox(
          //   height: 1,
          // ),
          Container(
            height: size.height * .4,
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 20,
            ),
            // padding: EdgeInsets.symmetric(horizontal: 5,),
            decoration: BoxDecoration(
                color: whiteColor, borderRadius: BorderRadius.circular(20)),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      titles[currentIndex],
                      style: blackTextStyle.copyWith(
                        fontSize: 18,
                        fontWeight: bold,
                      ),
                      textAlign: TextAlign.left,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      subtitles[currentIndex],
                      style: blackTextStyle.copyWith(
                          fontSize: 14, fontWeight: regular),
                      textAlign: TextAlign.left,
                    ),
                  ],
                ),
                // SizedBox(
                //   height: currentIndex == 2 ? 40 : 150,
                // ),
                currentIndex == 2
                    ? Column(
                        children: [
                          Row(
                            children: [
                              const SizedBox(
                                width: 140,
                              ),
                              Container(
                                width: 15,
                                height: 12,
                                margin: const EdgeInsets.only(right: 10),
                                decoration: BoxDecoration(
                                  shape: BoxShape.rectangle,
                                  borderRadius: BorderRadius.circular(10),
                                  color: currentIndex == 0
                                      ? bluetogreenColor
                                      : lightBackgroundColor,
                                ),
                              ),
                              Container(
                                width: 15,
                                height: 12,
                                margin: const EdgeInsets.only(right: 10),
                                decoration: BoxDecoration(
                                  shape: BoxShape.rectangle,
                                  borderRadius: BorderRadius.circular(10),
                                  color: currentIndex == 1
                                      ? bluetogreenColor
                                      : lightBackgroundColor,
                                ),
                              ),
                              Container(
                                width: 15,
                                height: 12,
                                margin: const EdgeInsets.only(right: 10),
                                decoration: BoxDecoration(
                                  shape: BoxShape.rectangle,
                                  borderRadius: BorderRadius.circular(10),
                                  color: currentIndex == 2
                                      ? bluetogreenColor
                                      : lightBackgroundColor,
                                ),
                              ),
                              const Spacer(),
                              CustomFilledButton(
                                bgcolor: bluetogreenColor,
                                width: 80,
                                title: 'Mulai',
                                textColor: TextStyle(color: whiteColor),
                                onPressed: () {
                                  //  Navigator.pushNamedAndRemoveUntil(
                                  //      context, '/Sign-Up', (route) => false);
                                  Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const SignUpPage()),
                                      (route) => false);
                                },
                              ),
                            ],
                          ),
                        ],
                      )
                    : Row(
                        children: [
                          CustomTextButton(
                            width: 80,
                            title: 'Lewati',
                            onPressed: () {
                              setState(() {
                                currentIndex = 2;
                              });
                              carouselController.jumpToPage(2);
                            },
                          ),
                          const SizedBox(
                            width: 60,
                          ),
                          Container(
                            width: 15,
                            height: 12,
                            margin: const EdgeInsets.only(right: 10),
                            decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.circular(10),
                              color: currentIndex == 0
                                  ? bluetogreenColor
                                  : lightBackgroundColor,
                            ),
                          ),
                          Container(
                            width: 15,
                            height: 12,
                            margin: const EdgeInsets.only(right: 10),
                            decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.circular(10),
                              color: currentIndex == 1
                                  ? bluetogreenColor
                                  : lightBackgroundColor,
                            ),
                          ),
                          Container(
                            width: 15,
                            height: 12,
                            margin: const EdgeInsets.only(right: 10),
                            decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.circular(10),
                              color: currentIndex == 2
                                  ? bluetogreenColor
                                  : lightBackgroundColor,
                            ),
                          ),
                          const Spacer(),
                          CustomFilledButton(
                            bgcolor: bluetogreenColor,
                            width: 80,
                            title: 'Lanjut',
                            textColor: TextStyle(color: whiteColor),
                            onPressed: () {
                              carouselController.nextPage();
                            },
                          ),
                        ],
                      ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
