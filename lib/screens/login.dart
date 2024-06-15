import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:rental_car/Theme.dart';
import 'package:rental_car/models/auth_response_model.dart';
import 'package:rental_car/screens/main_page.dart';
import 'package:rental_car/screens/signup.dart';
import 'package:rental_car/service/auth_local_datasoure.dart';
import 'package:rental_car/service/global_variable.dart';
import 'package:rental_car/widgets/custom_textformfield.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final passwordController = TextEditingController();
  bool _isLoading = false;

  Future<void> _loginUser() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      final response = await http.post(
        Uri.parse('${GlobalVariable.baseUrl}/api/loginCustomers'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'name': nameController.text,
        }),
      );

      setState(() {
        _isLoading = false;
      });

      if (response.statusCode == 200) {
        final responseBody = jsonDecode(response.body);
         String accessToken = responseBody['access_token'];
        await AuthLocalDatasource.saveAccessToken(accessToken); // Simpan token akses
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Login successful for ${responseBody['name']}'),
            backgroundColor: bluetogreenColor,
          ),
        );
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const MainPage()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Login failed: User not found')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightBackgroundColor,
      appBar: AppBar(
        centerTitle: true,
        title: Text('LOGIN',
            style: bluetogreenTextStyle.copyWith(
                fontSize: 25, fontWeight: FontWeight.bold)),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(right: 30, left: 30),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Center(
                      child: Column(
                        children: [
                          const SizedBox(height: 50),
                          SizedBox(
                            height: 300,
                            width: 300,
                            child: Image.asset(
                              "assets/login.png",
                              fit: BoxFit.contain,
                            ),
                          ),
                          const SizedBox(height: 20),
                          Text("Login dengan akun yang terdaftar",
                              style: blackTextStyle.copyWith(
                                  fontSize: 20, fontWeight: FontWeight.w400)),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 50),
                  RegisterField(
                    controller: nameController,
                    keyType: TextInputType.emailAddress,
                    hint: 'Masukkan Username',
                    validator: (val) {
                      if (val == null || val.isEmpty) {
                        return 'Kolom Username harus diisi';
                      }
                      return null;
                    },
                    prefixIcon: Icons.mail,
                  ),
                  const SizedBox(height: 50),
                  RegisterField(
                    controller: passwordController,
                    prefixIcon: Icons.key,
                    hint: 'Masukkan Password',
                    isPassword: true,
                    validator: (val) {
                      if (val == null || val.isEmpty) {
                        return 'Kolom Password harus diisi';
                      }
                      if (val.length < 8) {
                        return 'Password harus 8 karakter';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 40),
                  ElevatedButton(
                    onPressed: _isLoading ? null : _loginUser,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: bluetogreenColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: _isLoading
                        ? const CircularProgressIndicator(
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.white),
                          )
                        : Text(
                            "Masuk",
                            style: whitekTextStyle.copyWith(
                              fontWeight: bold,
                              fontSize: 17,
                            ),
                          ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Belum memiliki akun?', style: blackTextStyle),
                      TextButton(
                        onPressed: () {
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SignUpPage()),
                            (route) => false,
                          );
                        },
                        child: Text('Daftar',
                            style: bluetogreenTextStyle.copyWith(
                                fontWeight: bold)),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
