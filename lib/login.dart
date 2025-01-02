import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/dosen-pembimbing/main.dart';
import 'package:flutter_application_1/screens/mahasiswa/main.dart';
import 'package:flutter_application_1/screens/pembimbing-lapangan/main.dart';
import 'package:flutter_application_1/utils/constants.dart';
import 'package:flutter_application_1/utils/log.dart';
import 'package:flutter_application_1/utils/shared_preference_utils.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPreferenceUtils.initialize(); // Penting!
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Halaman Login',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: const LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isPasswordVisible = false;
  bool _isLoading = false;

  Future<void> login() async {
    const String loginUrl = '$BASE_URL/login';
    const String meUrl = '$BASE_URL/me';
    final String email = _emailController.text.trim();
    final String password = _passwordController.text;

    if (email.isEmpty && password.isEmpty) {
      Get.snackbar(
        'Error',
        'Email dan password tidak boleh kosong',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final response = await http.post(
        Uri.parse(loginUrl),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'username': email,
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        final token = response.body;

        final resMe = await http.get(
          Uri.parse(meUrl),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token', // Tambahkan Bearer Token di sini
          },
        );

        final resDecodeMe = jsonDecode(resMe.body);

        final typeAkun = resDecodeMe["data"]["roles"];

        Log.debug("resDecodeMe : $resDecodeMe");
        Log.debug("typeAkun : $typeAkun");

        SharedPreferenceUtils.setString(KEY_TOKEN, token);

        if (typeAkun == TypeUser.dosenPembimbing) {
          Get.off(() => MainDosenPembimbing());
        } else if (typeAkun == TypeUser.pembimbingLapangan) {
          Get.off(() => MainPembimbingLapangan());
        } else {
          Get.off(() => MainMahasiswa());
        }
      } else {
        Get.snackbar(
          'Error',
          'Server tidak dapat dihubungi (status: ${response.statusCode})',
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      Log.error(e);
      Get.snackbar(
        'Error',
        'Terjadi kesalahan: $e',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'PRESENSI',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'PRAKTEK PENGALAMAN LAPANGAN',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 24),
              TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'E-mail Anda',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _passwordController,
                obscureText: !_isPasswordVisible,
                decoration: InputDecoration(
                  labelText: 'Kata sandi Anda',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _isPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: Colors.grey,
                    ),
                    onPressed: () {
                      setState(() {
                        _isPasswordVisible = !_isPasswordVisible;
                      });
                    },
                  ),
                ),
              ),
              const SizedBox(height: 24),
              _isLoading
                  ? const CircularProgressIndicator()
                  : ElevatedButton(
                      onPressed: login,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(Icons.login, color: Colors.white),
                          SizedBox(width: 8),
                          Text(
                            'Masuk',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
