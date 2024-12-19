
import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/pembimbing-lapangan/home.dart';


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
            icon: const Icon(Icons.account_circle),
            onPressed: () {
              // Aksi untuk ikon akun (misalnya navigasi ke profil pengguna)
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (context) => const HomePage()), // Ubah sesuai kebutuhan
              // );
            },
          ),
        ],
      ),
      
      body: PembimbingPage(), // Tampilkan halaman sesuai indeks aktif
    );
  }
}