import 'package:flutter/material.dart';
import 'package:flutter_application_1/controller/absen_controller.dart';
import 'package:flutter_application_1/screens/mahasiswa/perizinan.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class LokasiPage extends StatefulWidget {
  @override
  State<LokasiPage> createState() => _LokasiPageState();
}

class _LokasiPageState extends State<LokasiPage> {
  late int indexPage;
  late MapController controller;
  final GeoPoint circleCenter =
      GeoPoint(latitude: -5.2115756, longitude: 119.5058004);
  final double circleRadius = 100.0; // dalam meter
  var isPositionPpl = false.obs;

  final AbsenController absenController = Get.put(AbsenController());

  @override
  void initState() {
    super.initState();
    controller = MapController(
      initMapWithUserPosition: UserTrackingOption(),
    );
  }

  Future<void> drawMaps() async {
    await controller.drawCircle(CircleOSM(
      key: "circle0",
      centerPoint: circleCenter,
      radius: circleRadius,
      color: Colors.red,
      strokeWidth: 0.3,
    ));
  }

  Future<void> checkUserInCircle() async {
    const LocationSettings locationSettings = LocationSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 100,
    );

    Position position =
        await Geolocator.getCurrentPosition(locationSettings: locationSettings);

    final myLocation =
        GeoPoint(latitude: position.latitude, longitude: position.longitude);

    await controller.changeLocation(myLocation);

    double distance = await distance2point(myLocation, circleCenter);
    if (distance <= circleRadius) {
      isPositionPpl.obs.value(true);
    } else {
      isPositionPpl.obs.value(false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Obx(
          () => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 16),
              // Peta Lokasi
              Card(
                elevation: 2,
                child: Column(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height *
                          0.5, // Peta lebih panjang
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image:
                              AssetImage('assets/google_map_placeholder.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: OSMFlutter(
                        onMapIsReady: (isReady) {
                          print("Map is ready");
                          drawMaps();
                          // Periksa saat peta siap
                          checkUserInCircle();
                        },
                        controller: controller,
                        osmOption: OSMOption(
                          userTrackingOption: UserTrackingOption(
                            enableTracking: true,
                            unFollowUser: false,
                          ),
                          zoomOption: ZoomOption(
                            minZoomLevel: 15,
                            maxZoomLevel: 19,
                            stepZoom: 1.0,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 16),
              // Absen di Kantor
              buildAbsenCard(
                  title: "Presensi di Kantor",
                  description:
                      "Anda berada didalam radius area kantor: $circleRadius m\nHanya dapat mengambil absen jika anda berada di kantor",
                  buttonText: "Presensi",
                  buttonColor: Colors.green,
                  iconColor: Colors.blue,
                  textColor: Colors.black,
                  isPositionPpl: isPositionPpl.value),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildAbsenCard(
      {required String title,
      required String description,
      required String buttonText,
      required Color buttonColor,
      required Color iconColor,
      required Color textColor,
      required bool isPositionPpl}) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              description,
              style: TextStyle(color: textColor, fontSize: 14),
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 130,
                  child: ElevatedButton.icon(
                    onPressed: () async {
                      absenController.absenDatang();
                      // absenController.checkAbsenDatang();
                      // if (isPositionPpl) {
                      //   absenController.checkAbsenDatang();
                      // } else {
                      //   Get.snackbar("Peringatan", "tidak berada di lokasi");
                      // }
                    },
                    icon: const Icon(
                      Icons.check_circle_outline,
                      color: Colors.white,
                    ),
                    label: Text(
                      buttonText,
                      style: TextStyle(fontSize: 10, color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: buttonColor,
                      // onPrimary: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),
                Container(
                  width: 130,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Get.to(PerizinanPage());
                    },
                    icon: const Icon(
                      Icons.event_busy,
                      color: Colors.white,
                    ),
                    label: Text(
                      "Izin / Sakit",
                      style: TextStyle(fontSize: 10, color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      // onPrimary: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
