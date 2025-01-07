import 'package:flutter/material.dart';
import 'package:flutter_application_1/widgets/date_picker.dart';

void main() {
  runApp(DosenPage());
}

class DosenPage extends StatelessWidget {
  const DosenPage({Key? key}) : super(key: key);
  Widget build(BuildContext context) {
    final ScrollController scrollController = ScrollController();

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: null,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Section
            _HeaderSection(),

            SizedBox(height: 12),

            // Calendar Section
            // _CalendarSection(),

            DatePicker(scrollController: scrollController, id: "0"),

            SizedBox(height: 12),

            // Informasi Kendala
            _KendalaInfoSection(),

            SizedBox(height: 20),

            // Lokasi PPL
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                "Lokasi PPL",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87),
              ),
            ),

            SizedBox(height: 12),

            // List of Locations
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 16),
                itemCount: 3,
                itemBuilder: (context, index) {
                  return _LokasiPPLCard();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Header Section Widget
class _HeaderSection extends StatelessWidget {
  const _HeaderSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.blue.shade800, Colors.blue],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Welcome",
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
              Text(
                "Reza Maulana",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
          CircleAvatar(
            radius: 28,
            backgroundImage: AssetImage("assets/avatar_placeholder.png"),
          ),
        ],
      ),
    );
  }
}

// Calendar Section Widget
class _CalendarSection extends StatelessWidget {
  const _CalendarSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ...["Sen", "Sel", "Rab", "Kam", "Jum"].map((day) {
            return Column(
              children: [
                Text(day, style: TextStyle(fontSize: 16, color: Colors.grey)),
                SizedBox(height: 8),
                Container(
                  decoration: BoxDecoration(
                    color: day == "Sen" ? Colors.orange : Colors.transparent,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: EdgeInsets.all(8),
                  child: Text(
                    "12",
                    style: TextStyle(
                      color: day == "Sen" ? Colors.white : Colors.black87,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
              ],
            );
          }),
          Icon(Icons.chevron_right, color: Colors.orange),
        ],
      ),
    );
  }
}

// Informasi Kendala Widget
class _KendalaInfoSection extends StatelessWidget {
  const _KendalaInfoSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.yellow.shade100,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.yellow.shade600),
      ),
      child: Row(
        children: [
          Icon(Icons.info_outline, color: Colors.yellow.shade800),
          SizedBox(width: 8),
          Expanded(
            child: Text(
              "Kendala di lokasi PPL (Makassar Digital Valley)",
              style: TextStyle(fontSize: 14, color: Colors.black87),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Icon(Icons.close, color: Colors.black54, size: 16),
        ],
      ),
    );
  }
}

// Lokasi PPL Card Widget
class _LokasiPPLCard extends StatelessWidget {
  const _LokasiPPLCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        contentPadding: EdgeInsets.all(12),
        leading: CircleAvatar(
          radius: 30,
          backgroundColor: Colors.grey.shade200,
          child: Image.asset("assets/logo_placeholder.png"),
        ),
        title: Text(
          "Makassar Digital Valley",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          "Jl. A. P. Pettarani No.13, Sinrijala, Kec. Panakkukang, Kota Makassar",
          style: TextStyle(fontSize: 12),
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Persentase Kehadiran:",
              style: TextStyle(fontSize: 10, color: Colors.grey.shade700),
            ),
            SizedBox(height: 4),
            Container(
              decoration: BoxDecoration(
                color: Colors.orange.shade100,
                borderRadius: BorderRadius.circular(8),
              ),
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              child: Text(
                "80 %",
                style: TextStyle(
                  color: Colors.orange,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
