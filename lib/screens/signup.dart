import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:rental_car/Theme.dart';
import 'package:rental_car/screens/login.dart';
import 'package:rental_car/service/global_variable.dart';
import 'package:rental_car/widgets/custom_textformfield.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  bool _isChecked = false;
  bool _isLoading = false;

  final namaController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final konfirmasiController = TextEditingController();

  void _updateCheckboxStatus(bool value) {
    setState(() {
      _isChecked = value;
    });
  }

  // Show privacy dialog
  Future<void> showPrivacy() async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text(
                "Syarat, Ketentuan & Kebijakan",
                textAlign: TextAlign.left,
                style: blackTextStyle.copyWith(fontWeight: extraBold),
              ),
              actionsAlignment: MainAxisAlignment.center,
              actions: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: bluetogreenColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    'Saya Setuju',
                    style: whitekTextStyle.copyWith(fontWeight: bold),
                  ),
                ),
              ],
              content: Scrollbar(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Selamat datang di Aplikasi Rentailers...',
                        textAlign: TextAlign.left,
                        style: greyTextStyle.copyWith(fontSize: 14),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Ketentuan Penggunaan',
                        textAlign: TextAlign.left,
                        style: blackTextStyle.copyWith(fontWeight: bold),
                      ),
                      const SizedBox(height: 10),
                      Table(
                          columnWidths: const {
                            0: IntrinsicColumnWidth(),
                            1: IntrinsicColumnWidth(),
                          },
                          border: TableBorder.all(color: Colors.transparent),
                          children: [
                            TableRow(children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 5),
                                child: Text(
                                    textAlign: TextAlign.left,
                                    '1.',
                                    style: blackTextStyle.copyWith(
                                        fontSize: 14, fontWeight: regular)),
                              ),
                              Text(
                                'Penggunaan Aplikasi : Anda diizinkan untuk menggunakan aplikasi ini hanya untuk tujuan yang sah...',
                                textAlign: TextAlign.left,
                                style: blackTextStyle.copyWith(
                                    fontWeight: regular, fontSize: 14),
                              )
                            ]),
                            TableRow(children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 5),
                                child: Text(
                                    textAlign: TextAlign.left,
                                    '2.',
                                    style: blackTextStyle.copyWith(
                                        fontSize: 14, fontWeight: regular)),
                              ),
                              Text(
                                ' Pendaftaran Akun : Untuk mengakses fitur-fitur tertentu dalam aplikasi ini...',
                                textAlign: TextAlign.left,
                                style: blackTextStyle.copyWith(
                                    fontWeight: regular, fontSize: 14),
                              )
                            ]),
                            // Add other TableRow items here
                          ]),
                      const SizedBox(height: 10),
                      Text(
                        'Kontak Kami',
                        textAlign: TextAlign.left,
                        style: blackTextStyle.copyWith(fontWeight: bold),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Jika Anda memiliki pertanyaan atau komentar...',
                        textAlign: TextAlign.left,
                        style: greyTextStyle.copyWith(fontSize: 14),
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  // Register function to call the API
  Future<void> _registerUser() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      final response = await http.post(
        Uri.parse('${GlobalVariable.baseUrl}/api/registrasiCustomer'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'name': namaController.text,
          'email': emailController.text,
          'password': passwordController.text,
        }),
      );
      setState(() {
        _isLoading = false;
      });
      if (response.statusCode == 200) {
        final responseBody = jsonDecode(response.body);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text(
                  'Registration successful for ${responseBody['result']['name']}'),
                  backgroundColor: bluetogreenColor,),
        );
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const LoginPage()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Registration failed')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightBackgroundColor,
      appBar: AppBar(
        title: Text('REGISTER',
            style: bluetogreenTextStyle.copyWith(
                fontSize: 25, fontWeight: FontWeight.bold)),
        centerTitle: true,
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
                          SizedBox(
                            height: 300,
                            width: 300,
                            child: Image.asset(
                              "assets/login.png",
                              fit: BoxFit.contain,
                            ),
                          ),
                          const SizedBox(height: 20),
                          Text("Isi dengan data yang valid",
                              style: blackTextStyle.copyWith(
                                  fontSize: 17, fontWeight: FontWeight.w400)),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 25),
                  RegisterField(
                    controller: namaController,
                    hint: 'Masukkan Nama',
                    prefixIcon: Icons.account_circle,
                    validator: (val) {
                      if (val == null || val.isEmpty) {
                        return 'Kolom Nama harus diisi';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  RegisterField(
                    controller: emailController,
                    keyType: TextInputType.emailAddress,
                    hint: "Masukkan Email",
                    validator: (val) {
                      if (val == null || val.isEmpty) {
                        return 'Kolom E-mail harus diisi';
                      }
                      if (!val.contains('@')) {
                        return 'E-mail tidak valid';
                      }
                      return null;
                    },
                    prefixIcon: Icons.mail,
                  ),
                  const SizedBox(height: 20),
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
                  const SizedBox(height: 20),
                  RegisterField(
                    controller: konfirmasiController,
                    prefixIcon: Icons.key,
                    hint: 'Konfirmasi Password',
                    isPassword: true,
                    validator: (val) {
                      if (val == null || val.isEmpty) {
                        return 'Kolom Konfirmasi Password harus diisi';
                      }
                      if (val != passwordController.text) {
                        return 'Password dan Konfirmasi password harus sama';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 30),
                  Row(
                    children: [
                      Checkbox(
                        value: _isChecked,
                        onChanged: (value) {
                          setState(() {
                            _isChecked = value ?? false;
                          });
                        },
                      ),
                      Expanded(
                        child: Wrap(
                          spacing: 2,
                          children: [
                            Text(
                              'Saya menyetujui',
                              style: blackTextStyle.copyWith(fontSize: 14),
                            ),
                            InkWell(
                              child: Text('Syarat, Ketentuan & Kebijakan',
                                  style: bluetogreenTextStyle.copyWith(
                                      fontWeight: bold, fontSize: 15)),
                              onTap: () => showPrivacy(),
                            ),
                            Text(
                              'yang berlaku',
                              style: blackTextStyle.copyWith(fontSize: 14),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: _isChecked ? _registerUser : null,
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
                            "Daftar",
                            style: whitekTextStyle.copyWith(
                              fontWeight: bold,
                              fontSize: 17,
                            ),
                          ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Sudah memiliki akun?',
                        style: blackTextStyle,
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LoginPage()),
                            (route) => false,
                          );
                        },
                        child: Text(
                          'Masuk',
                          style:
                              bluetogreenTextStyle.copyWith(fontWeight: bold),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
