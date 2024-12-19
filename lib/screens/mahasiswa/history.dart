import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/text/text_component.dart';

void main() {
  runApp(HistoryPage());
}

class HistoryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: AbsensiScreen(),
      theme: ThemeData(primarySwatch: Colors.green),
    );
  }
}

class AbsensiScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: EdgeInsets.all(8),
                child: Column(
                  children: [
                    TextField(
                      decoration: InputDecoration(
                        labelText: "Tanggal Awal",
                        hintText: "08-12-2024",
                        border: OutlineInputBorder(),
                        suffixIcon: Icon(Icons.calendar_today),
                      ),
                    ),
                    SizedBox(height: 10,),
                    TextField(
                      decoration: InputDecoration(
                        labelText: "Tanggal Akhir",
                        hintText: "08-12-2024",
                        border: OutlineInputBorder(),
                        suffixIcon: Icon(Icons.calendar_today),
                      ),
                    ),
                    SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.pink),
                          child: TextComponent("Tampilkan", size: 12, color: Colors.white,),
                        ),
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.orange),
                          child: TextComponent("Cetak", size: 12, color: Colors.white,),
                        ),
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green),
                          child: TextComponent("Clear", size: 12, color: Colors.white,),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: 24.0),

            // DataTable
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  columns: [
                    DataColumn(label: Text("No")),
                    DataColumn(label: Text("Tanggal")),
                    DataColumn(label: Text("Absen Masuk")),
                    DataColumn(label: Text("Absen Pulang")),
                    DataColumn(label: Text("Status")),
                  ],
                  rows: List<DataRow>.generate(
                    10,
                    (index) => DataRow(cells: [
                      DataCell(Text("${index + 1}")),
                      DataCell(Text("29 Des 2023")),
                      DataCell(Text("00:00:00")),
                      DataCell(Text("00:00:00")),
                      DataCell(Container(
                        padding: EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Text(
                          "Tepat Waktu",
                          style: TextStyle(color: Colors.white),
                        ),
                      )),
                    ]),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
