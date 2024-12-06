import 'package:flutter/material.dart';

class BattunPage extends StatefulWidget {
  @override
  _BattunPageState createState() => _BattunPageState();
}

class _BattunPageState extends State<BattunPage> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    Center(child: Text('Beranda', style: TextStyle(fontSize: 24))),
    Center(child: Text('Absensi', style: TextStyle(fontSize: 24))),
    Center(child: Text('Riwayat', style: TextStyle(fontSize: 24))),
  ];

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 8.0,
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: _onTabTapped,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Beranda',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.history),
              label: 'Riwayat',
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _currentIndex = 1; // Pindah ke halaman Absensi
          });
        },
        child: Icon(Icons.camera_alt),
        backgroundColor: Colors.green,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

// void main() {
//   runApp(MaterialApp(
//     home: CustomBottomNavBar(),
//   ));
// }
