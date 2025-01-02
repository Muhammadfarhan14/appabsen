import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/controller/global_controller.dart';
import 'package:flutter_application_1/screens/mahasiswa/main.dart';
import 'package:flutter_application_1/screens/mahasiswa/scan_barcode.dart';
import 'package:flutter_application_1/services/api_services.dart';
import 'package:flutter_application_1/utils/constants.dart';
import 'package:flutter_application_1/utils/log.dart';
import 'package:get/get.dart';

class AbsenController extends GetxController {
  final GlobalController globalController = Get.put(GlobalController());
  final ApiService apiService = ApiService(); // Inisialisasi ApiService

  String? get token => globalController.token.value;

  var status = ''.obs; // Reactive variable
  // var tanggalController = TextEditingController(); // Rxn untuk nullable
  var tanggal = Rxn<DateTime>();
  var file = Rxn<File>(); // Rxn untuk nullable
  final keteranganController = TextEditingController();

  Future<void> pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null && result.files.single.path != null) {
      file.value =
          File(result.files.single.path!); // Menyimpan file yang dipilih
    }
  }

  // Fungsi untuk mengecek absen datang (GET request)
  Future<void> checkAbsenDatang() async {
    try {
      await apiService.getRequest(URL_CHECK_ABSEN_DATANG, token);
      // Get.snackbar("Berhasil", resDecodeMe['message']);
      Get.to(const ScanBarcode());
    } catch (e) {
      Log.debug(e.toString());
      Get.snackbar("Error", e.toString());
    }
  }

  // Fungsi untuk absen datang (POST request)
  Future<void> absenDatang() async {
    try {
      final input = {"status": Absen.hadir};

      final resDecodeMe =
          await apiService.postRequest(URL_ABSEN_DATANG, token, input);
      Get.snackbar("Berhasil", resDecodeMe['message']);
      Get.to(const MainMahasiswa());
    } catch (e) {
      Log.debug(e.toString());
      Get.snackbar("Error", e.toString());
    }
  }

  Future<void> izin() async {
    // Log.debug("status : $status");
    // Log.debug("keterangan : ${keteranganController.value.text}");
    // Log.debug("tanggal : ${tanggal}");
    // Log.debug("file : ${file.value?.path}");
    final keterangan = keteranganController.value.text;

    try {
      final input = {"status": status, "keterangan": keterangan};

      final resDecodeMe = await apiService.postRequest(
          URL_ABSEN_DATANG, token, input, file.value);
      Get.snackbar("Berhasil", resDecodeMe['message']);
      Get.to(const MainMahasiswa());
    } catch (e) {
      Log.debug(e.toString());
      Get.snackbar("Error", e.toString());
    }
  }
}
