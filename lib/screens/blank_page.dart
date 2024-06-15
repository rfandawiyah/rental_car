// ignore: duplicate_ignore
// ignore_for_file: unused_import, duplicate_import
import 'package:flutter/material.dart';
import 'package:rental_car/Theme.dart';
import 'package:rental_car/screens/login.dart';
import 'package:rental_car/screens/onboarding_page.dart';



import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import 'package:flutter/material.dart';


class BlankPage extends StatefulWidget {
  const BlankPage({super.key});

  @override
  State<BlankPage> createState() => _BlankPageState();
}

class _BlankPageState extends State<BlankPage> {
  var keyLogin;
  var token;
  @override
  void initState() {
    //
    super.initState();
    Timer(const Duration(milliseconds: 100), () => checktoken()
        // {
        //   Navigator.pushNamedAndRemoveUntil(
        //       context, '/onboarding', (route) => false);
        //   // checktoken();
        // }
        );
  }

  Future<void> checktoken() async {
    WidgetsFlutterBinding.ensureInitialized();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString('token');
    keyLogin = prefs.getString('keyLogin');
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
                iconTheme: IconThemeData(color: blackColor))),
        // home: const NavigationPage(),
        // routes: {
        //   '/': (context) => const SplashPage(),
        //   // '/': (context) => const NavigationPage(),
        //   '/onboarding': (context) => const OnBoardingPage(),
        //   '/sign-in': (context) => const SignInPage(),
        //   '/Sign-Up': (context) => const SignUpPage(),
        //   '/navigation-page': (context) => const NavigationPage(),
        //   '/breeding-page': (context) => const BreedingPage(),
        //   '/dombaTersedia': (context) => const DombaTersediaPage(),
        //   '/detailDomba': (context) => const DetailDomba(),
        //   '/detailPaketQurban': (context) => const DetailPaketQurbanPage(),
        //   '/akad': (context) => const AkadPage(),
        //   '/TermsAndConditions': (context) => const TermsAndConditions(),
        //   '/dombasaya': (context) => const DombaSaya(),
        //   '/monitoring': (context) => const Monitoring(),
        //   '/akun-page': (context) => const AkunPage(),
        //   '/edit-akun-page': (context) => const EditAkunPage(),
        //   '/ubah-password-page': (context) => const UbahPasswordPage(),
        //   '/keranjang-page': (context) => const KeranjangPage(),
        //   '/detailbreed': (context) => const DetailBreed(),
        //   '/invoice': (context) => const invoice(),
        // },
        home: keyLogin == null ? const OnBoardingPage() : const LoginPage()));
  }

  // alreadyLogin() async {
  //   if (keyLogin == null) {
  //     OnBoardingPage();
  //   } else {
  //     SignInPage();
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightBackgroundColor,
      body: const Center(
        child: SizedBox(
          height: 209,
          width: 209,
          // decoration: const BoxDecoration(
          //     image: DecorationImage(
          //         image: AssetImage('assets/logosultanfarm.png'))),
        ),
      ),
    );
  }
}
