import 'package:flutter/material.dart';

class PembimbingPage extends StatelessWidget {
  const PembimbingPage({Key? key}) : super(key: key);
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 12),

            // Lokasi PPL Section
            _LokasiSection(),

            SizedBox(height: 16),

            // Tanggal Section
            _TanggalSection(),

            // List Mahasiswa
            Expanded(
              child: ListView.builder(
                itemCount: 3,
                itemBuilder: (context, index) {
                  return _MahasiswaCard(
                    name: "Laravel",
                    nim: "60200120026",
                    isChecked: true,
                  );
                },
              ),
            ),

            // // Tombol NFC
            // _ScanNFCButton(),
          ],
        ),
      ),
    );
  }
}
// Lokasi Section Widget
class _LokasiSection extends StatelessWidget {
  const _LokasiSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: CircleAvatar(
            radius: 30,
            backgroundImage: AssetImage("assets/logo_placeholder.png"),
          ),
          title: Text(
            "Uin Alauddin Kalijodo",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          subtitle: Text(
            "Jl. A. P. Pettarani No.13, Sinrijala, Kec. Panakkukang, Kota Makassar",
            style: TextStyle(fontSize: 12, color: Colors.black54),
          ),
        ),
        Divider(),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Dosen Pembimbing",
                    style: TextStyle(color: Colors.black54, fontSize: 12),
                  ),
                  SizedBox(height: 4),
                  Text(
                    "Reza Maulana",
                    style: TextStyle(
                        fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Pembimbing Lapangan",
                    style: TextStyle(color: Colors.black54, fontSize: 12),
                  ),
                  SizedBox(height: 4),
                  Text(
                    "Rini Apriliani",
                    style: TextStyle(
                        fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// Tanggal Section Widget
class _TanggalSection extends StatelessWidget {
  const _TanggalSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        color: Colors.blue.shade700,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(
        child: Text(
          "Senin, 02 Januari 2023",
          style: TextStyle(
              color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

// Mahasiswa Card Widget
class _MahasiswaCard extends StatelessWidget {
  final String name;
  final String nim;
  final bool isChecked;

  const _MahasiswaCard({
    Key? key,
    required this.name,
    required this.nim,
    required this.isChecked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        name,
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
      subtitle: Text(
        nim,
        style: TextStyle(fontSize: 14, color: Colors.black54),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.check_box,
            color: Colors.orange.shade400,
            size: 28,
          ),
          SizedBox(width: 8),
          Icon(
            Icons.check_box_outline_blank,
            color: Colors.orange.shade200,
            size: 28,
          ),
        ],
      ),
    );
  }
}