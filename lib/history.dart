import 'package:flutter/material.dart';

class HistoryPage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HistoryPage> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Colors.white,
      //   elevation: 0,
      //   title: Text(
      //     "Home",
      //     style: TextStyle(
      //       color: Colors.black,
      //       fontWeight: FontWeight.bold,
      //     ),
      //   ),
      //   actions: [
      //     Padding(
      //       padding: const EdgeInsets.only(right: 16.0),
      //       child: ElevatedButton.icon(
      //         onPressed: () {},
      //         icon: Icon(Icons.help_outline, size: 16),
      //         label: Text("Panduan"),
      //         style: ElevatedButton.styleFrom(
      //           backgroundColor: Colors.orange.shade100,
      //           // backgroundColor: Colors.orange,
      //           textStyle: TextStyle(fontSize: 12),
      //         ),
      //       ),
      //     ),
      //   ],
      // ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Hi, Rian Reski Ananda",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 8),
            Text(
              "9:56:3",
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 4),
            Text(
              "Kamis, 17 Desember 2020",
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: Card(
                    elevation: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          Text(
                            "08:37:26",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.blue),
                          ),
                          SizedBox(height: 8),
                          ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8)),
                            ),
                            child: Text("Absen Masuk"),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 8),
                Expanded(
                  child: Card(
                    elevation: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          Icon(Icons.remove, color: Colors.orange),
                          SizedBox(height: 8),
                          ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.orange,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8)),
                            ),
                            child: Text("Absen Pulang"),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            Text(
              "Jadwal Besok (Jumat, 18 Desember 2020)",
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Expanded(
              child: ListView(
                children: [
                  buildScheduleItem(
                    time: "07:30",
                    description: "07:00 - 12:00",
                    status: "di kantor",
                    color: Colors.blue,
                  ),
                  buildScheduleItem(
                    time: "16:30",
                    description: "16:30 - 23:59",
                    status: "di kantor",
                    color: Colors.orange,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.map),
            label: "Peta",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.fingerprint),
            label: "Absen",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.report),
            label: "Laporan",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Profil",
          ),
        ],
      ),
    );
  }

  Widget buildScheduleItem({
    required String time,
    required String description,
    required String status,
    required Color color,
  }) {
    return Card(
      elevation: 2,
      margin: EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: color.withOpacity(0.2),
          child: Icon(Icons.arrow_forward, color: color),
        ),
        title: Text(
          time,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(description),
        trailing: Chip(
          label: Text(
            status,
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.green,
        ),
      ),
    );
  }
}
