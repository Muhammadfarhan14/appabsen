import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/dosen-pembimbing/home.dart';

class MainDosenPembimbing extends StatefulWidget {
  const MainDosenPembimbing({Key? key}) : super(key: key);

  @override
  State<MainDosenPembimbing> createState() => _MainDosenPembimbingState();
}

class _MainDosenPembimbingState extends State<MainDosenPembimbing> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Colors.green,
      //   title: const Text('Absensi PPL'),
      //   actions: [
      //     IconButton(
      //       icon: const Icon(Icons.account_circle),
      //       onPressed: () {
      //         // Aksi untuk ikon akun (misalnya navigasi ke profil pengguna)
      //         // Navigator.push(
      //         //   context,
      //         //   MaterialPageRoute(builder: (context) => const HomePage()), // Ubah sesuai kebutuhan
      //         // );
      //       },
      //     ),
      //   ],
      // ),

      appBar: null,

      body: DosenPage(), // Tampilkan halaman sesuai indeks aktif
    );
  }
}
