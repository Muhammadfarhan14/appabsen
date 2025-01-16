import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/controller/global_controller.dart';
import 'package:flutter_application_1/services/api_services.dart';
import 'package:flutter_application_1/utils/constants.dart';
import 'package:flutter_application_1/utils/log.dart';
import 'package:get/get.dart';

class PembimbingController extends GetxController {
  final GlobalController globalController = Get.put(GlobalController());

  final ApiService apiService = ApiService(); // Inisialisasi ApiService

  String? get token => globalController.token.value;
  int? get iduser => globalController.id.value;

  var status = ''.obs; // Reactive variable
  // var tanggalController = TextEditingController(); // Rxn untuk nullable
  var tanggal = Rxn<DateTime>();
  var file = Rxn<File>(); // Rxn untuk nullable
  final keteranganController = TextEditingController();
  var dataLokasiPpl = [].obs;
  var detailLokasiPpl = [].obs;

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
    await getLokasiPpl();
  }

  Future<void> getLokasiPpl() async {
    try {
      final response = await apiService.getRequest(URL_GET_LOKASI_PPL, token);
      Log.debug(response);
      dataLokasiPpl.value = response['data'];
    } catch (e) {
      Log.debug(e.toString());
      Get.snackbar("Error", e.toString());
    }
  }

  Future<void> getDetailLokasiPpl(id, String date) async {
    try {
      Log.debug("dosen_pembimbing_id => $iduser");
      Log.debug("date => $date");
      final response = await apiService.postRequest(
          URL_GET_DETAIL_LOKASI_PPL,
          token,
          {"tanggal": date, "lokasi_id": id, "dosen_pembimbing_id": iduser});
      Log.debug(response);

      detailLokasiPpl.value = response['data'];
    } catch (e) {
      Log.debug(e.toString());
      // Get.snackbar("Error", e.toString());
    }
  }
}
