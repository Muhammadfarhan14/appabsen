import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class MapsPage extends StatefulWidget {
  const MapsPage({super.key});

  @override
  State<MapsPage> createState() => _MapsPageState();
}

class _MapsPageState extends State<MapsPage> {
  late int indexPage;
  late MapController controller;
  final GeoPoint circleCenter =
      GeoPoint(latitude: -5.201530, longitude: 119.498365);
  final double circleRadius = 300.0; // dalam meter

  @override
  void initState() {
    super.initState();
    controller = MapController(
      initMapWithUserPosition: UserTrackingOption(),
    );
  }

  Future<void> drawMaps() async {
    print("draw maps");

    await controller.drawCircle(CircleOSM(
      key: "circle0",
      centerPoint: circleCenter,
      radius: circleRadius,
      color: Colors.red,
      strokeWidth: 0.3,
    ));
  }

  Future<void> checkUserInCircle() async {
    print("getLocation");

    final LocationSettings locationSettings = LocationSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 100,
    );

    Position position =
        await Geolocator.getCurrentPosition(locationSettings: locationSettings);

    print("position: $position");

    final myLocation = GeoPoint(latitude: position.latitude, longitude: position.longitude);

    await controller.changeLocation(myLocation);

    double distance = await distance2point(myLocation, circleCenter);
    if (distance <= circleRadius) {
      print("User is inside the circle: true");
      Get.snackbar("Status", "Berada di lokasi");
    } else {
      print("User is inside the circle: false");
      Get.snackbar("Status", "Tidak berada di lokasi");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
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
        userLocationMarker: UserLocationMaker(
          personMarker: MarkerIcon(
            icon: Icon(
              Icons.location_history_rounded,
              color: Colors.red,
              size: 48,
            ),
          ),
          directionArrowMarker: MarkerIcon(
            icon: Icon(
              Icons.double_arrow,
              size: 48,
            ),
          ),
        ),
        roadConfiguration: RoadOption(
          roadColor: Colors.yellowAccent,
        ),
        markerOption: MarkerOption(
          defaultMarker: MarkerIcon(
            icon: Icon(
              Icons.person_pin_circle,
              color: Colors.blue,
              size: 56,
            ),
          ),
        ),
      ),
    )));
  }
}


// class TesterMaps extends StatefulWidget {
//   TesterMaps({Key? key}) : super(key: key);

//   @override
//   _TesterMapsState createState() => _TesterMapsState();
// }

// class _TesterMapsState extends State<TesterMaps> {
//   late PageController controller;
//   late int indexPage;

//   @override
//   void initState() {
//     super.initState();
//     controller = PageController(initialPage: 1);
//     indexPage = controller.initialPage;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("osm"),
//       ),
//       body: Container(
//         child: SimpleOSM(),
//       ),
//     );
//   }
// }

// class SimpleOSM extends StatefulWidget {
//   @override
//   State<StatefulWidget> createState() => SimpleOSMState();
// }

// class SimpleOSMState extends State<SimpleOSM> {
//   late MapController controller;
//   final GeoPoint circleCenter =
//       GeoPoint(latitude: -5.201530, longitude: 119.498365);
//   final double circleRadius = 300.0; // dalam meter

//   @override
//   void initState() {
//     super.initState();
//     controller = MapController(
//       initMapWithUserPosition: UserTrackingOption(),
//     );
//   }

//   Future<void> drawMaps() async {
//     print("draw maps");

//     await controller.drawCircle(CircleOSM(
//       key: "circle0",
//       centerPoint: circleCenter,
//       radius: circleRadius,
//       color: Colors.red,
//       strokeWidth: 0.3,
//     ));
//   }

//   // Periksa apakah pengguna berada di dalam lingkaran
//   Future<void> checkUserInCircle() async {
//     GeoPoint? userPosition = await controller.myLocation();
//     print("userPosition : ${userPosition}");

//     await controller.addMarker(
//       userPosition,
//       markerIcon: MarkerIcon(
//         icon: Icon(
//           Icons.location_history_rounded,
//           color: Colors.red,
//           size: 48,
//         ),
//       ),
//     );

//     double distance = await distance2point(userPosition, circleCenter);
//     if (distance <= circleRadius) {
//       print("User is inside the circle: true");
//     } else {
//       print("User is inside the circle: false");
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return OSMFlutter(
//       onMapIsReady: (isReady) {
//         print("Map is ready");
//         drawMaps();
//         // Periksa saat peta siap
//         checkUserInCircle();
//       },
//       controller: controller,
//       osmOption: OSMOption(
//         userTrackingOption: UserTrackingOption(
//           enableTracking: true,
//           unFollowUser: false,
//         ),
//         zoomOption: ZoomOption(
//           minZoomLevel: 15,
//           maxZoomLevel: 19,
//           stepZoom: 1.0,
//         ),
//         userLocationMarker: UserLocationMaker(
//           personMarker: MarkerIcon(
//             icon: Icon(
//               Icons.location_history_rounded,
//               color: Colors.red,
//               size: 48,
//             ),
//           ),
//           directionArrowMarker: MarkerIcon(
//             icon: Icon(
//               Icons.double_arrow,
//               size: 48,
//             ),
//           ),
//         ),
//         roadConfiguration: RoadOption(
//           roadColor: Colors.yellowAccent,
//         ),
//         markerOption: MarkerOption(
//           defaultMarker: MarkerIcon(
//             icon: Icon(
//               Icons.person_pin_circle,
//               color: Colors.blue,
//               size: 56,
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }