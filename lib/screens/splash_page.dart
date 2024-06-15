// ignore: duplicate_ignore
// ignore_for_file: unused_import, duplicate_import, prefer_typing_uninitialized_variables

import 'package:rental_car/Theme.dart';
import 'package:rental_car/screens/blank_page.dart';
import 'package:rental_car/screens/main_page.dart';
import 'package:rental_car/screens/onboarding_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  var keyLogin;
  var token;
  @override
  void initState() {
    //
    super.initState();
    Timer(const Duration(seconds: 2), () => checkToken());
  }

  Future<void> checkToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString('token');
    keyLogin = prefs.getString('keyLogin');

    Widget initialRoute;
    if (token != null) {
      initialRoute = const MainPage();
    } else {
      initialRoute =
          const OnBoardingPage(); // Assuming OnBoardingPage is your onboarding screen
    }

    runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: primaryColor,
        appBarTheme: AppBarTheme(
          backgroundColor: lightBackgroundColor,
          centerTitle: false,
          elevation: 1,
          titleTextStyle: blackTextStyle.copyWith(
            fontSize: 20,
            fontWeight: semiBold,
          ),
          iconTheme: IconThemeData(color: blackColor),
        ),
      ),
      home: initialRoute,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightBackgroundColor,
      body: Center(
        child: Container(
          height: 300,
          width: 300,
          decoration: const BoxDecoration(
              image: DecorationImage(image: AssetImage('assets/nobg.png'))),
        ),
      ),
    );
  }
}
