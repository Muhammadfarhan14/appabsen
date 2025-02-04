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
  var dataAbsen = [].obs;
  var dataAbsenBulanIni = [].obs;
  var dataHistory = [].obs;

  @override
  void onInit() {
    super.onInit();
    _waitForTokenAndGetAbsen();
  }

  Future<void> _waitForTokenAndGetAbsen() async {
    while (token == null) {
      // Tunggu hingga token tidak null
      await Future.delayed(Duration(milliseconds: 500));
    }
    // Setelah token tersedia, panggil getAbsen
    await getAbsen();
    await getAbsenBulanIni();
    await getHistory("2025", "1");
  }

  Future<void> pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null && result.files.single.path != null) {
      file.value =
          File(result.files.single.path!); // Menyimpan file yang dipilih
    }
  }

  Future<void> getAbsenBulanIni() async {
    try {
      Log.debug("getAbsen");
      Log.debug("token $token");
      final response =
          await apiService.getRequest(URL_GET_ABSEN_BULAN_INI, token);
      dataAbsenBulanIni.value = response['data'];
    } catch (e) {
      Log.debug(e.toString());
      // Get.snackbar("Error", e.toString());
    }
  }

  Future<void> getAbsen() async {
    try {
      Log.debug("getAbsen");
      Log.debug("token $token");
      final response = await apiService.getRequest(URL_GET_ABSEN, token);
      Log.debug(response);
      dataAbsen.value = response['data'];
    } catch (e) {
      Log.debug(e.toString());
      // Get.snackbar("Error", e.toString());
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
      final input = {"status": Absen.hadir.description};

      final resDecodeMe =
          await apiService.postRequest(URL_ABSEN_DATANG, token, input);
      await getAbsenBulanIni();
      Get.snackbar("Berhasil", resDecodeMe['message']);
      Get.to(const MainMahasiswa());
    } catch (e) {
      Log.debug(e.toString());
      Get.snackbar("Error", e.toString());
    }
  }

  Future<void> izin() async {
    final keterangan = keteranganController.value.text.toString();
    final statusLower = status.value.toLowerCase() == "lain-lain"
        ? "izin"
        : status.value.toLowerCase();

    try {
      final input = {"status": statusLower, "keterangan": keterangan};

      final resDecodeMe = await apiService.postRequest(
          URL_ABSEN_DATANG, token, input, file.value);
      Get.snackbar("Berhasil", resDecodeMe['message']);
      Get.offAll(const MainMahasiswa());
    } catch (e) {
      Log.debug(e);
      Get.snackbar("Error", e.toString());
    }
  }

  Future<void> getHistory(String year, String month) async {
    try {
      final response = await apiService.getRequest(
          "$URL_GET_ABSEN_TANGGAL/$month/$year", token);
      Log.debug(response);
      dataHistory.value = response['data'];
    } catch (e) {
      Log.debug(e.toString());
      // Get.snackbar("Error", e.toString());
    }
  }
}
