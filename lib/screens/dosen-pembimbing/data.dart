import 'package:flutter/material.dart';
import 'package:flutter_application_1/controller/pembimbing_controller.dart';
import 'package:flutter_application_1/login.dart';
import 'package:flutter_application_1/utils/constants.dart';
import 'package:flutter_application_1/utils/log.dart';
import 'package:flutter_application_1/widgets/date_picker.dart';
import 'package:get/get.dart';

class HadirPage extends StatelessWidget {
  const HadirPage({super.key});

  @override
  Widget build(BuildContext context) {
    final PembimbingController pembimbingController =
        Get.put(PembimbingController());

    final args = Get.arguments;
    final lokasiId = args['lokasi_id'];
    final lokasi = args['lokasi'];
    final alamat = args['alamat'];

    Log.debug("lokasi_id: $lokasiId");

    // Mengambil tanggal hari ini
    DateTime today = DateTime.now();

    // Mendapatkan tanggal besok (tanggal 17 jika hari ini tanggal 16)
    DateTime tomorrow = today.add(Duration(days: 1));

    // Mengonversi tanggal ke format yang dibutuhkan (YYYY-MM-DD)
    String tomorrowDate =
        tomorrow.toString().substring(0, 10); // Format: YYYY-MM-DD

    // Mengambil data berdasarkan tanggal besok
    pembimbingController.getDetailLokasiPpl(lokasiId, tomorrowDate);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text('Presensi Mahasiswa'),
        actions: [
          IconButton(
            onPressed: () {
              Get.off(LoginPage());
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: BodyHadir(lokasiId: lokasiId, lokasi: lokasi, alamat: alamat),
    );
  }
}

class BodyHadir extends StatelessWidget {
  final PembimbingController pembimbingController = Get.find();

  final ScrollController scrollController = ScrollController();

  final int lokasiId;
  final String lokasi;
  final String alamat;

  BodyHadir(
      {required this.lokasiId, required this.lokasi, required this.alamat});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // Informasi Lokasi
          SizedBox(height: 24),
          DatePicker(scrollController: scrollController, id: lokasiId),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.blue.shade800, Colors.blue],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 24,
                          child: Icon(Icons.location_on, color: Colors.blue),
                        ),
                        SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                lokasi,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                alamat,
                                style: TextStyle(
                                    color: Colors.white, fontSize: 12),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Daftar Peserta
          Obx(
            () => Expanded(
              child: ListView.builder(
                itemCount: pembimbingController.detailLokasiPpl.length,
                itemBuilder: (context, index) {
                  final data = pembimbingController.detailLokasiPpl[index];
                  final dataAbsensi = data["status_absen"] as List<dynamic>;

                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 4.0),
                    child: Container(
                      padding: const EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Row(
                        children: [
                          SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  data["nama"],
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text(data["nim"]),
                              ],
                            ),
                          ),
                          // Looping untuk status absensi
                          for (var status in dataAbsensi)
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 4.0),
                              child: Container(
                                width: 32, // Ukuran kotak
                                height: 32,
                                decoration: BoxDecoration(
                                  color: status["status"] ==
                                          StatusAbsen.absen.description
                                      ? Colors.green // Hijau jika absen
                                      : status["status"] ==
                                              StatusAbsen.tidakHadir.description
                                          ? Colors.red
                                          : Colors
                                              .grey, // Merah jika tidak hadir
                                  border: Border.all(
                                    color: status["status"] ==
                                            StatusAbsen.absen.description
                                        ? Colors.green // Hijau jika absen
                                        : status["status"] ==
                                                StatusAbsen
                                                    .tidakHadir.description
                                            ? Colors.red
                                            : Colors.grey,
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Icon(
                                  status["status"] ==
                                          StatusAbsen.absen.description
                                      ? Icons.check // Centang hijau untuk hadir
                                      : status["status"] ==
                                              StatusAbsen.tidakHadir.description
                                          ? Icons.close
                                          : null, // Tanda silang merah untuk tidak hadir
                                  color: Colors.white,
                                  size: 20,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
