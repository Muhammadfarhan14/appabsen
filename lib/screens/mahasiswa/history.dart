import 'package:flutter/material.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: RiwayatPresensiPage(),
    );
  }
}

class RiwayatPresensiPage extends StatelessWidget {
  RiwayatPresensiPage({super.key});

  final List<Map<String, String?>> riwayat = [
    {'tanggal': 'Kamis, 26 Desember 2024', 'jamMasuk': '-', 'jamPulang': '-', 'Status': '-'},
    {'tanggal': 'Rabu, 25 Desember 2024', 'jamMasuk': '-', 'jamPulang': '-', 'Status': '-'},
    {'tanggal': 'Selasa, 24 Desember 2024', 'jamMasuk': '07:09', 'jamPulang': '16:07', 'Status': '-'},
    {'tanggal': 'Senin, 23 Desember 2024', 'jamMasuk': '07:07', 'jamPulang': '16:13', 'Status': '-'},
    {'tanggal': 'Minggu, 22 Desember 2024', 'jamMasuk': '-', 'jamPulang': '-', 'Status': '-'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Riwayat Presensi'),
        // backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: riwayat.length,
                itemBuilder: (context, index) {
                  final data = riwayat[index];
                  return Card(
                    elevation: 2,
                    margin: const EdgeInsets.only(bottom: 8),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            data['tanggal']!,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              const Text('Jam Masuk: '),
                              Text(
                                data['jamMasuk']!,
                                style: const TextStyle(
                                  color: Colors.blue,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              const Text('Jam Pulang: '),
                              Text(
                                data['jamPulang']!,
                                style: const TextStyle(
                                  color: Colors.blue,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              const Text('Status:'),
                              Text(
                                data['Status']!,
                                style: const TextStyle(
                                  color: Colors.blue,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
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
