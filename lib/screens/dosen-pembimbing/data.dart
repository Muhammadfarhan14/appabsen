import 'package:flutter/material.dart';
import 'package:flutter_application_1/login.dart';
import 'package:flutter_application_1/widgets/date_picker.dart';
import 'package:get/get.dart';

class HadirPage extends StatelessWidget {
  const HadirPage({super.key});

  @override
  Widget build(BuildContext context) {
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
      body: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  final ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // Informasi Lokasi
          SizedBox(height: 24),
          DatePicker(scrollController: scrollController, id: "0"),
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
                                "Makassar Digital Valley",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                "Jl. A.P. Pettarani No.13, Sinrijala, Kec. Panakkukang, Kota Makassar",
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
          Expanded(
            child: ListView.builder(
              itemCount: 3,
              itemBuilder: (context, index) {
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
                                "Ahmad Ilham",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text("60900118033"),
                            ],
                          ),
                        ),
                        Checkbox(
                          value: true, // Atur logika check sesuai kebutuhan
                          activeColor: Colors
                              .orange, // Warna aktif (checked) diubah ke oranye
                          onChanged: (bool? value) {},
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
