import 'package:flutter/material.dart';
import 'package:flutter_application_1/lokasi.dart';
import 'package:flutter_application_1/main.dart';
import 'package:get/get.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class ScanBarcode extends StatefulWidget {
  const ScanBarcode({Key? key}) : super(key: key);

  @override
  State<ScanBarcode> createState() => _ScanBarcodeState();
}

class _ScanBarcodeState extends State<ScanBarcode> {
  String? scannedBarcode;

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
        title: const Text('Hasil Pemindaian'),
        content: Text(result),
        actions: [
          TextButton(
            onPressed: () {
              Get.to(const DashboardPage());
              },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}