
import 'package:flutter/material.dart';
import 'package:flutter_application_1/button.dart';
import 'package:flutter_application_1/history.dart';
import 'package:flutter_application_1/home.dart';
import 'package:flutter_application_1/lokasi.dart';
// import 'package:get/get_navigation/src/root/get_material_app.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return GetMaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Absensi PPL',
//       theme: ThemeData(
//         primarySwatch: Colors.green,
//       ),
//       home: const DashboardPage(),
//     );
//   }
// }

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int _currentIndex = 0;

  // Daftar halaman yang akan ditampilkan
  final List<Widget> _pages = [
    HomePage(),
    LokasiPage(),
    HistoryPage(),
    BattunPage(),
    // AbsensiPage(),
    // ScanBarcode(),
    // MapsPage()
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
          BottomNavigationBarItem(icon: Icon(Icons.assignment), label: 'Lokasi'),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: 'History'),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: 'Button'),
          // BottomNavigationBarItem(icon: Icon(Icons.assignment), label: 'Absen'),
          // BottomNavigationBarItem(icon: Icon(Icons.qr_code), label: 'Scan QR'),
        ],
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}