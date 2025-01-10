import 'package:flutter/material.dart';
import 'package:flutter_application_1/login.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

// void main() {
//   runApp(MyApp());
// }

class ForgotPasswordPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
    );
  }
}

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text('Lupa Password'),
        actions: [
          IconButton(
             onPressed: () {
              Get.to(LoginPage());
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Text(
              //   'PRESENSI PRAKTEK PENGALAMAN LAPANGAN',
              //   textAlign: TextAlign.center,
              //   style: TextStyle(
              //     fontSize: 18,
              //     fontWeight: FontWeight.bold,
              //   ),
              // ),
              // SizedBox(height: 40),

              // Input NIM/Username
              TextField(
                decoration: InputDecoration(
                  labelText: 'NIM/Username anda',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
              SizedBox(height: 20),

              // Input Password
              TextField(
                obscureText: !_isPasswordVisible,
                decoration: InputDecoration(
                  labelText: 'Password Anda',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  // suffixIcon: IconButton(
                  //   icon: Icon(
                  //     _isPasswordVisible
                  //         ? Icons.visibility
                  //         : Icons.visibility_off,
                  //   ),
                  //   onPressed: () {
                  //     setState(() {
                  //       _isPasswordVisible = !_isPasswordVisible;
                  //     });
                  //   },
                  // ),
                ),
              ),
              SizedBox(height: 20),

              TextField(
                obscureText: !_isPasswordVisible,
                decoration: InputDecoration(
                  labelText: 'Konfirmasi Password Anda',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  // suffixIcon: IconButton(
                  //   icon: Icon(
                  //     _isPasswordVisible
                  //         ? Icons.visibility
                  //         : Icons.visibility_off,
                  //   ),
                  //   onPressed: () {
                  //     setState(() {
                  //       _isPasswordVisible = !_isPasswordVisible;
                  //     });
                  //   },
                  // ),
                ),
              ),
              SizedBox(height: 40),

              // Tombol Masuk
              ElevatedButton(
                onPressed: () {
                  // Logika saat tombol ditekan
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.login),
                    SizedBox(width: 10),
                    Text(
                      'Ganti Password',
                      style: TextStyle(fontSize: 16),
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


