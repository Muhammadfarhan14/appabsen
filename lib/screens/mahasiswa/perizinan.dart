import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/text/text_component.dart';
import 'package:flutter_application_1/controller/absen_controller.dart';
import 'package:get/get.dart';

class PerizinanPage extends StatelessWidget {
  final AbsenController absenController = AbsenController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green,
          title: const Text('Absensi PPL'),
          // actions: [
          //   IconButton(
          //     icon: const Icon(Icons.account_circle),
          //     onPressed: () {},
          //   ),
          // ],
        ),
        body: Obx(
          () => Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Silahkan Pilih:",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Column(
                    children: [
                      RadioListTile<String>(
                        title: Text("Izin"),
                        value: "Izin",
                        groupValue: absenController.status.value,
                        onChanged: (value) {
                          absenController.status.value = value!;
                        },
                      ),
                      RadioListTile<String>(
                        title: Text("Sakit"),
                        value: "Sakit",
                        groupValue: absenController.status.value,
                        onChanged: (value) {
                          absenController.status.value = value!;
                        },
                      ),
                      RadioListTile<String>(
                        title: Text("Lain-Lain"),
                        value: "Lain-Lain",
                        groupValue: absenController.status.value,
                        onChanged: (value) {
                          absenController.status.value = value!;
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  // TextField(
                  //   readOnly: true,
                  //   controller: absenController.tanggalController,
                  //   decoration: InputDecoration(
                  //     labelText: "Pilih Tanggal",
                  //     suffixIcon: Icon(Icons.calendar_today),
                  //     border: OutlineInputBorder(
                  //       borderRadius: BorderRadius.circular(8.0),
                  //     ),
                  //   ),
                  //   onTap: () async {
                  //     DateTime? pickedDate = await showDatePicker(
                  //       context: context,
                  //       initialDate: DateTime.now(),
                  //       firstDate: DateTime(2000),
                  //       lastDate: DateTime(2101),
                  //     );
                  //     if (pickedDate != null) {
                  //       absenController.tanggalController.text =
                  //           "${pickedDate.toLocal()}"
                  //               .split(' ')[0]; // Format tanggal: YYYY-MM-DD

                  //       absenController.tanggal.value = pickedDate;
                  //     }
                  //   },
                  // ),
                  // const SizedBox(height: 16),
                  OutlinedButton.icon(
                    onPressed: absenController.pickFile,
                    icon: Icon(
                      Icons.upload_file,
                      color: Colors.black,
                    ),
                    label: TextComponent(
                      absenController.file.value != null
                          ? "File Dipilih: ${absenController.file.value!.path.split('/').last}"
                          : "Unggah Dokumen",
                      size: 14,
                    ),
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: Colors.black),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: absenController.keteranganController,
                    maxLines: 3,
                    decoration: InputDecoration(
                      labelText: "Keterangan",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        absenController.izin();
                        // if (selectedReason == null) {
                        //   Get.snackbar("Error", "Silakan pilih alasan!");
                        //   return;
                        // }
                        // if (selectedDate == null) {
                        //   Get.snackbar("Error", "Silakan pilih tanggal!");
                        //   return;
                        // }

                        // absenController.izin(
                        //   selectedReason,
                        //   keteranganController.text,
                        //   selectedFile,
                        // );
                      },
                      child: TextComponent(
                        "KIRIM",
                        color: Colors.white,
                        size: 12,
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        minimumSize: Size(200, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
