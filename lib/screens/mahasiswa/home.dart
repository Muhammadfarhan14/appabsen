import 'package:flutter/material.dart';
import 'package:flutter_application_1/controller/absen_controller.dart';
import 'package:flutter_application_1/controller/time_controller.dart';
import 'package:flutter_application_1/utils/constants.dart';
import 'package:flutter_application_1/utils/log.dart';
import 'package:get/get.dart';

// import 'package:intl/intl.dart';
class ChecklistItem {
  final String title;
  final bool isCompleted;

  ChecklistItem(this.title, this.isCompleted);
}

class HomePage extends StatelessWidget {
  final TimeController timeController = Get.put(TimeController());
  final AbsenController absenController = Get.put(AbsenController());

  @override
  Widget build(BuildContext context) {
    final List<ChecklistItem> checklist = [
      ChecklistItem("Presensi Datang", false),
      ChecklistItem("Presensi 2", false),
      ChecklistItem("Presensi 3", true),
      ChecklistItem("Presensi 4", true),
      ChecklistItem("Presensi Pulang", true),
    ];

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Obx(() {
          final absenBulanIni = absenController.dataAbsenBulanIni;
          int sumHadir = 0;
          int sumSakit = 0;
          int sumIzin = 0;

          Log.debug("absenBulanIni => $absenBulanIni");

          for (var item in absenBulanIni) {
            final status = item["status"] as String;
            final jumlah = item["jumlah"] as int;

            if (Absen.hadir.description == status) {
              sumHadir = jumlah;
            } else if (Absen.sakit.description == status) {
              sumSakit = jumlah;
            } else if (Absen.izin.description == status) {
              sumIzin = jumlah;
            }
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Hi, Muhammad Farhan",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 8),
              Text(
                timeController.formattedTime.value,
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 4),
              Text(
                timeController.formattedDate.value,
                style: TextStyle(fontSize: 14, color: Colors.black),
              ),
              SizedBox(height: 16),
              const Text(
                'Presensi Bulan November 2045',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 10),
              GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                childAspectRatio: 2,
                children: [
                  _buildAbsenceDetailCard(
                      'Hadir', "$sumHadir hari", Colors.green, Icons.done),
                  _buildAbsenceDetailCard(
                      'Izin', "$sumIzin hari", Colors.orange, Icons.alarm),
                  _buildAbsenceDetailCard('Sakit', "$sumSakit hari",
                      Colors.grey, Icons.medical_services),
                  // _buildAbsenceDetailCard(
                  //     'Terlambat', '1 Hari', Colors.red, Icons.timer_off),
                ],
              ),
              SizedBox(height: 16),
              const Text(
                'Presensi Hari Ini',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              ),
              Container(
                  width: double.infinity, // Set full width
                  child: Obx(
                    () => ListView.builder(
                      shrinkWrap:
                          true, // Allows the ListView to take only as much height as needed
                      physics:
                          NeverScrollableScrollPhysics(), // Disable scrolling to prevent conflicts
                      itemCount: absenController.dataAbsen.length,
                      itemBuilder: (context, index) {
                        final item = checklist[index];
                        final absen = absenController.dataAbsen[index];
                        final status = absen["status"];
                        Log.debug(status);

                        // Tentukan warna latar belakang dan ikon berdasarkan status
                        Color backgroundColor;
                        Color iconColor;
                        IconData? iconData;

                        if (status == StatusAbsen.absen.description) {
                          backgroundColor = Colors.green.withOpacity(0.1);
                          iconColor = Colors.green;
                          iconData = Icons.check;
                        } else if (status ==
                            StatusAbsen.belumAbsen.description) {
                          backgroundColor =
                              Colors.grey; // Tidak ubah warna latar belakang
                          iconColor = Colors.grey; // Tidak ada ikon
                          iconData = null; // Tidak ada ikon
                        } else {
                          backgroundColor = Colors.red.withOpacity(0.1);
                          iconColor = Colors.red;
                          iconData = Icons.close;
                        }

                        return ListTile(
                          leading: Container(
                            width: 24, // Ukuran kotak
                            height: 24,
                            decoration: BoxDecoration(
                              color:
                                  backgroundColor, // Latar belakang yang sudah ditentukan
                              border: Border.all(
                                color:
                                    iconColor, // Warna border yang sudah ditentukan
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(
                                  4), // Kotak dengan sudut melengkung sedikit
                            ),
                            child: iconData != null
                                ? Icon(
                                    iconData,
                                    color: iconColor, // Warna ikon
                                    size: 18, // Ukuran ikon
                                  )
                                : null, // Tidak ada ikon jika belum absen
                          ),
                          title: Text(
                            status,
                            style: TextStyle(
                              color: Colors.black,
                              decoration: item.isCompleted
                                  ? TextDecoration.none
                                  : TextDecoration.none,
                            ),
                          ),
                        );
                      },
                    ),
                  )),
            ],
          );
        }),
      ),
    );
  }

  Widget _buildMenuItem(IconData icon, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CircleAvatar(
          backgroundColor: Colors.green.withOpacity(0.1),
          child: Icon(icon, color: Colors.green),
        ),
        const SizedBox(height: 8),
        Text(label, style: const TextStyle(fontSize: 12)),
      ],
    );
  }

  Widget _buildStatusCard(String title, String subtitle, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: TextStyle(color: color, fontSize: 14)),
            const SizedBox(height: 4),
            Text(subtitle,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }

  Widget _buildAbsenceDetailCard(
      String title, String days, Color color, IconData icon) {
    return Container(
      margin: const EdgeInsets.all(4),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: color.withOpacity(0.2),
            child: Icon(icon, color: color),
          ),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: TextStyle(color: color, fontSize: 14)),
              Text(days, style: const TextStyle(fontSize: 12)),
            ],
          ),
        ],
      ),
    );
  }
}
