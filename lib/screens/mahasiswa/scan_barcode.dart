import 'package:flutter/material.dart';
import 'package:flutter_application_1/controller/absen_controller.dart';
import 'package:get/get.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class ScanBarcode extends StatefulWidget {
  const ScanBarcode({Key? key}) : super(key: key);

  @override
  State<ScanBarcode> createState() => _ScanBarcodeState();
}

class _ScanBarcodeState extends State<ScanBarcode> {
  String? scannedBarcode;

  final AbsenController absenController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('QR Code Scanner'),
        actions: [
          // IconButton(
          //   icon: const Icon(Icons.flip_camera_ios),
          //   onPressed: () {
          //     MobileScannerController().switchCamera();
          //   },
          // ),
        ],
      ),
      body: MobileScanner(
        onDetect: (BarcodeCapture capture) {
          final barcode = capture.barcodes.first;
          if (scannedBarcode != barcode.rawValue) {
            setState(() {
              scannedBarcode = barcode.rawValue ?? 'Unknown QR Code';
            });
            _showResultDialog(context, scannedBarcode!);
          }
        },
      ),
    );
  }

  void _showResultDialog(BuildContext context, String result) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        icon: const Icon(Icons.check_circle_outline_outlined),
        title: const Text('Berhasil'),
        content: Text(result),
        actions: [
          TextButton(
            onPressed: absenController.absenDatang,
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}
