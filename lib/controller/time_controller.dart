import 'dart:async';
import 'dart:convert';
import 'package:flutter_application_1/utils/constants.dart';
import 'package:flutter_application_1/utils/log.dart';
import 'package:flutter_application_1/utils/shared_preference_utils.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

class TimeController extends GetxController {
  var currentTime = DateTime.now().obs; // Observable untuk waktu
  var formattedDate = ''.obs; // Observable untuk tanggal terformat
  var formattedTime = ''.obs; // Observable untuk waktu terformat
  var resToken = ''.obs;
  Timer? timer;

  @override
  void onInit() {
    super.onInit();
    initializeDateFormatting("id_ID").then((_) {
      fetchTimeFromAPI(); // Ambil waktu awal setelah lokal diinisialisasi
    });

    getToken();
  }

  Future<void> getToken() async {
    final token = await SharedPreferenceUtils.getString(KEY_TOKEN);
    resToken.value = token!;
    Log.debug(token);
  }

  Future<void> fetchTimeFromAPI() async {
    final url = Uri.parse(URL_TIME);
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final utcDateTime = DateTime.parse(data['datetime']);
        currentTime.value = utcDateTime.toLocal(); // Update waktu lokal
        updateFormattedDateTime(); // Perbarui format tanggal dan waktu
        startTimer(); // Mulai timer
      } else {
        throw Exception(
            'Gagal mengambil data dari API, status code: ${response.statusCode}');
      }
    } catch (e) {
      Log.error("Error: $e");
      // Tunggu 2 detik sebelum mencoba lagi
      await Future.delayed(const Duration(seconds: 2));
      fetchTimeFromAPI();
    }
  }

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (Timer t) {
      currentTime.value = currentTime.value
          .add(const Duration(seconds: 1)); // Tambahkan 1 detik
      updateFormattedDateTime(); // Perbarui format setiap detik
    });
  }

  void updateFormattedDateTime() {
    formattedDate.value =
        DateFormat('EEEE, dd MMMM yyyy', 'id_ID').format(currentTime.value);
    formattedTime.value = DateFormat('HH:mm:ss').format(currentTime.value);
  }

  @override
  void onClose() {
    timer?.cancel(); // Hentikan timer saat controller dihapus
    super.onClose();
  }
}
