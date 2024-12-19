import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/mahasiswa/history.dart';
import 'package:flutter_application_1/screens/mahasiswa/home.dart';
import 'package:flutter_application_1/screens/mahasiswa/lokasi.dart';

class MainMahasiswa extends StatefulWidget {
  const MainMahasiswa({Key? key}) : super(key: key);

  @override
  State<MainMahasiswa> createState() => _MainMahasiswaState();
}

class _MainMahasiswaState extends State<MainMahasiswa> {
  int _currentIndex = 0;

  // Daftar halaman yang akan ditampilkan
  final List<Widget> _pages = [
    HomePage(),
    LokasiPage(),
    HistoryPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text('Absensi PPL'),
        actions: [
          IconButton(
            icon: const Icon(Icons.account_circle),
            onPressed: () {},
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.green),
              child: Text(
                'Menu',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Home'),
              onTap: () {
                Navigator.pop(context); // Tutup drawer
                setState(() {
                  _currentIndex = 0; // Tampilkan halaman Home
                });
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Settings'),
              onTap: () {
                // Tambahkan navigasi ke halaman Settings jika diperlukan
              },
            ),
          ],
        ),
      ),
      body: _pages[_currentIndex], // Tampilkan halaman sesuai indeks aktif
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex, // Menentukan halaman aktif
        onTap: (index) {
          setState(() {
            _currentIndex = index; // Ubah halaman aktif
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.camera_alt_outlined), label: 'Absen'),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: 'History'),
        ],
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}
