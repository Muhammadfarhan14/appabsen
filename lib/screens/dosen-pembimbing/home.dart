import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/dosen-pembimbing/data.dart';
import 'package:get/get.dart';

class DosenPage extends StatelessWidget {
  const DosenPage({Key? key}) : super(key: key);
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: null,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Section
            _HeaderSection(),

            SizedBox(height: 10),

            // Lokasi PPL
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                "Lokasi PPL",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87),
              ),
            ),

            SizedBox(height: 12),

            // List of Locations
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: 3, // Pastikan jumlah ini sesuai dengan data Anda
                itemBuilder: (context, index) {
                  return _LokasiPPLCard(
                    lokasi: "Lokasi PPL ${index + 1}", // Contoh data dinamis
                    alamat: "Alamat Lokasi PPL ${index + 1}",
                    Kehadiran: "Presentasi Kehadiran",
                    logoPath:
                        "assets/logo_placeholder.png", // Pastikan file ini ada
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Header Section Widget
class _HeaderSection extends StatelessWidget {
  const _HeaderSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.blue.shade800, Colors.blue],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Welcome",
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
              Text(
                "Reza Maulana",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
          CircleAvatar(
            radius: 28,
            backgroundImage: AssetImage("assets/avatar_placeholder.png"),
          ),
        ],
      ),
    );
  }
}

// Calendar Section Widget
class _CalendarSection extends StatelessWidget {
  const _CalendarSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ...["Sen", "Sel", "Rab", "Kam", "Jum"].map((day) {
            return Column(
              children: [
                Text(day, style: TextStyle(fontSize: 16, color: Colors.grey)),
                SizedBox(height: 8),
                Container(
                  decoration: BoxDecoration(
                    color: day == "Sen" ? Colors.orange : Colors.transparent,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: EdgeInsets.all(8),
                  child: Text(
                    "12",
                    style: TextStyle(
                      color: day == "Sen" ? Colors.white : Colors.black87,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
              ],
            );
          }),
          Icon(Icons.chevron_right, color: Colors.orange),
        ],
      ),
    );
  }
}

// Lokasi PPL Card Widget
class _LokasiPPLCard extends StatelessWidget {
  final String lokasi;
  final String alamat;
  final String Kehadiran;
  final String logoPath;

  const _LokasiPPLCard({
    Key? key,
    required this.lokasi,
    required this.alamat,
    required this.Kehadiran,
    required this.logoPath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title (Lokasi)
            Text(
              lokasi,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            SizedBox(height: 8),

            // Subtitle (Alamat)
            Text(
              alamat,
              style: TextStyle(fontSize: 12, color: Colors.grey.shade700),
            ),
            SizedBox(height: 12),

            Text(
              Kehadiran,
              style: TextStyle(fontSize: 12, color: Colors.grey.shade700),
            ),
            

            // Trailing (Persentase Kehadiran dan Tombol Aksi)
            Row(
              children: [
                // Persentase Kehadiran
                Container(
                  decoration: BoxDecoration(
                    color: Colors.orange.shade100,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  child: Text(
                    "80%",
                    style: TextStyle(
                      color: Colors.orange,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Spacer(),

                // Tombol Lihat
                ElevatedButton(
                  onPressed: () {
                    Get.to(HadirPage());
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    "Lihat",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
