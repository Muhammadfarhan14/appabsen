
import 'package:flutter/material.dart';
import 'package:flutter_application_1/login.dart';
import 'package:flutter_application_1/screens/pembimbing-lapangan/home.dart';
import 'package:get/get.dart';


class MainPembimbingLapangan extends StatefulWidget {
  const MainPembimbingLapangan({Key? key}) : super(key: key);

  @override
  State<MainPembimbingLapangan> createState() => _MainPembimbingLapanganState();
}

class _MainPembimbingLapanganState extends State<MainPembimbingLapangan> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text('Absensi PPL'),
        actions: [
          IconButton(
            onPressed: () {
              Get.off(LoginPage());
            },
             icon: const Icon(Icons.logout),
          ),
        ],
      ),
      
      body: PembimbingPage(), // Tampilkan halaman sesuai indeks aktif
    );
  }
}
