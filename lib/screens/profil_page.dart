// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:rental_car/models/auth_response_model.dart';
import 'package:rental_car/screens/login.dart';
import 'package:rental_car/service/auth_local_datasoure.dart';
import 'package:rental_car/service/global_variable.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  AuthResponseModel? user;
  bool _isLoading = false;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchProfile();
  }

  Future<void> _logout() async {
    try {
      String? accessToken = await AuthLocalDatasource.getAccessToken();
      final response = await http.post(
        Uri.parse('${GlobalVariable.baseUrl}/api/logout'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken',
        },
      );

      if (response.statusCode == 200) {
        // Arahkan pengguna ke layar login
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const LoginPage()),
          (route) => false,
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Failed to logout'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      print('Error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('An error occurred'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<void> _fetchProfile() async {
    setState(() {
      _isLoading = true;
    });

    try {
      String? accessToken = await AuthLocalDatasource.getAccessToken();
      final response = await http.get(
        Uri.parse('${GlobalVariable.baseUrl}/api/profile'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken',
        },
      );
      print('Body Respons: ${response.body}');
      if (response.statusCode == 200) {
        final responseBody = jsonDecode(response.body);
        setState(() {
          user = AuthResponseModel.fromJson(responseBody);
          _nameController.text = user?.user?.name ?? '';
          _emailController.text = user?.user?.email ?? '';
          _isLoading = false;
        });
      } else {
        setState(() {
          _isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Failed to fetch profile'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      print('Error: $e');
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('An error occurred'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<void> _updateProfile() async {
    setState(() {
      _isLoading = true;
    });

    try {
      String? accessToken = await AuthLocalDatasource.getAccessToken();
      final response = await http.put(
        Uri.parse('${GlobalVariable.baseUrl}/api/profile'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken',
        },
        body: jsonEncode({
          'name': _nameController.text,
          'email': _emailController.text,
        }),
      );

      print('Update Profile Response: ${response.statusCode}');
      print('Update Profile Response Body: ${response.body}');

      if (response.statusCode == 200) {
        setState(() {
          _isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Profile updated successfully'),
            backgroundColor: Colors.green,
          ),
        );
      } else {
        setState(() {
          _isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Failed to update profile'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      print('Error: $e');
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('An error occurred'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.login_outlined,
            ),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => ShowDialogLogout(logoutCallback: _logout),
              );
            },
          ),
        ],
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : user != null
              ? Center(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextFormField(
                          controller: _nameController,
                          decoration: const InputDecoration(labelText: 'Name'),
                        ),
                        const SizedBox(height: 10),
                        TextFormField(
                          controller: _emailController,
                          decoration: const InputDecoration(labelText: 'Email'),
                        ),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: _updateProfile,
                          child: const Text('Update Profile'),
                        ),
                      ],
                    ),
                  ),
                )
              : const Center(
                  child: Text('Profile not found'),
                ),
    );
  }
}

class ShowDialogLogout extends StatelessWidget {
  final Function logoutCallback;
  const ShowDialogLogout({
    super.key,
    required this.logoutCallback,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        insetPadding: const EdgeInsets.symmetric(horizontal: 30),
        title: const Text(
          "Logout",
          style: TextStyle(
            fontWeight: FontWeight.w700,
          ),
        ),
        content: const Text(
          "Apakah anda ingin logout ? ",
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text(
              'Cancel',
              style: TextStyle(
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              logoutCallback();
            },
            child: const Text(
              'Ya',
              style: TextStyle(
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ]);
  }
}
