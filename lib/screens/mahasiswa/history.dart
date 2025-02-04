import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_application_1/controller/absen_controller.dart';

class RiwayatPresensiPage extends StatelessWidget {
  RiwayatPresensiPage({super.key});

  final AbsenController absenController = Get.put(AbsenController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Riwayat Presensi'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Obx(() {
          if (absenController.dataHistory.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          return ListView.builder(
            itemCount: absenController.dataHistory.length,
            itemBuilder: (context, index) {
              final data = absenController.dataHistory[index];

              return Card(
                elevation: 2,
                margin: const EdgeInsets.only(bottom: 8),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        data['tanggal'] ?? 'Tidak ada tanggal',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          const Text('Status: '),
                          Row(
                            children: (data['absen'] as List)
                                .map<Widget>((status) => Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 4),
                                      child: Icon(
                                        status == 'hadir'
                                            ? Icons.check_circle
                                            : Icons.cancel,
                                        color: status == 'hadir'
                                            ? Colors.green
                                            : Colors.red,
                                      ),
                                    ))
                                .toList(),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        }),
      ),
    );
  }
}
