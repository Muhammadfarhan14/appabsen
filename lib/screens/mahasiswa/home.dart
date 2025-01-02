import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/text/text_component.dart';
import 'package:flutter_application_1/controller/time_controller.dart';
import 'package:get/get.dart';

// import 'package:intl/intl.dart';
class ChecklistItem {
  final String title;
  final bool isCompleted;

  ChecklistItem(this.title, this.isCompleted);
}

class HomePage extends StatelessWidget {
  final TimeController timeController =
      Get.put(TimeController()); // Injeksi controller

  @override
  Widget build(BuildContext context) {
    final List<ChecklistItem> checklist = [
      ChecklistItem("Presensi Datang", true),
      ChecklistItem("Presensi 2", false),
      ChecklistItem("Presensi 3", true),
      ChecklistItem("Presensi 4", true),
      ChecklistItem("Presensi Pulang", true),
    ];

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Obx(
          () => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Hi, Ferry Irwandi",
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
                      'Hadir', '1 Hari', Colors.green, Icons.done),
                  _buildAbsenceDetailCard(
                      'Izin', '0 Hari', Colors.orange, Icons.alarm),
                  _buildAbsenceDetailCard(
                      'Sakit', '0 Hari', Colors.grey, Icons.medical_services),
                  _buildAbsenceDetailCard(
                      'Terlambat', '1 Hari', Colors.red, Icons.timer_off),
                ],
              ),
              SizedBox(height: 16),
              const Text(
                'Presensi Hari Ini',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              ),
              Container(
                width: double.infinity, // Set full width
                child: ListView.builder(
                  shrinkWrap:
                      true, // Allows the ListView to take only as much height as needed
                  physics:
                      NeverScrollableScrollPhysics(), // Disable scrolling to prevent conflicts
                  itemCount: checklist.length,
                  itemBuilder: (context, index) {
                    final item = checklist[index];
                    return ListTile(
                      leading: Checkbox(
                        value: item.isCompleted,
                        onChanged: null, // Disable interaction
                        checkColor: Colors.green,
                        activeColor: Colors.white,
                      ),
                      title: Text(
                        item.title,
                        style: TextStyle(
                          color: item.isCompleted ? Colors.black: Colors.black,
                          decoration: item.isCompleted
                              ? TextDecoration.none
                              : TextDecoration.none,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
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
