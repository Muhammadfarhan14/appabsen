import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/text/text_component.dart';

class PerizinanPage extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: PengajuanPerizinanPage(),
    );
  }
}

class PengajuanPerizinanPage extends StatefulWidget {
  @override
  _PengajuanPerizinanPageState createState() => _PengajuanPerizinanPageState();
}

class _PengajuanPerizinanPageState extends State<PengajuanPerizinanPage> {
  String? selectedReason;
  DateTime? selectedDate;

  final TextEditingController keteranganController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text('Absensi PPL'),
        actions: [
          IconButton(
            icon: const Icon(Icons.account_circle),
            onPressed: () {},
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Silahkan Pilih:",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Column(
                children: [
                  RadioListTile<String>(
                    title: Text("Izin"),
                    value: "Izin",
                    groupValue: selectedReason,
                    onChanged: (value) {
                      setState(() {
                        selectedReason = value;
                      });
                    },
                  ),
                  RadioListTile<String>(
                    title: Text("Sakit"),
                    value: "Sakit",
                    groupValue: selectedReason,
                    onChanged: (value) {
                      setState(() {
                        selectedReason = value;
                      });
                    },
                  ),
                  RadioListTile<String>(
                    title: Text("Lain-Lain"),
                    value: "Lain-Lain",
                    groupValue: selectedReason,
                    onChanged: (value) {
                      setState(() {
                        selectedReason = value;
                      });
                    },
                  ),
                ],
              ),
              const SizedBox(height: 16),
              TextField(
                readOnly: true,
                decoration: InputDecoration(
                  labelText: "Pilih Tanggal",
                  suffixIcon: Icon(Icons.calendar_today),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2101),
                  );
                  if (pickedDate != null) {
                    setState(() {
                      selectedDate = pickedDate;
                    });
                  }
                },
              ),
              const SizedBox(height: 16),
              OutlinedButton.icon(
                onPressed: () {
                  print("Unggah Dokumen clicked");
                },
                icon: Icon(
                  Icons.upload_file,
                  color: Colors.black,
                ),
                label: TextComponent(
                  "Unggah Dokumen",
                  size: 14,
                ),
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: Colors.black),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: keteranganController,
                maxLines: 3,
                decoration: InputDecoration(
                  labelText: "Keterangan",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    print("Kirim clicked");
                    print("Alasan: $selectedReason");
                    print("Tanggal: $selectedDate");
                    print("Keterangan: ${keteranganController.text}");
                  },
                  child: TextComponent(
                    "KIRIM",
                    color: Colors.white,
                    size: 12,
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    minimumSize: Size(200, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
