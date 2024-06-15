import 'package:flutter/material.dart';
import 'package:rental_car/Theme.dart';
import 'package:rental_car/screens/login.dart';
import 'package:rental_car/screens/main_page.dart';
import 'package:rental_car/screens/signup.dart';
import 'package:rental_car/screens/splash_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Rentailers',
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
      home: const SplashPage(),
      routes: {
        '/login': (context) => const LoginPage(),
        '/signup': (context) => const SignUpPage(),
        '/main': (context) => const MainPage(),
      },
    );
  }
}
