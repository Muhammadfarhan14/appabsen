// ignore: constant_identifier_names
const URL_TIME = 'https://worldtimeapi.org/api/timezone/Asia/Kuala_Lumpur';
const BASE_URL = 'http://192.168.1.20:8000/api';
const KEY_TOKEN = "token";

enum TypeUser {
  pembimbingLapangan("Pembimbing Lapangan"),
  dosenPembimbing("Dosen Pembimbing"),
  mahasiswa("Mahasiswa");

  final String description;

  const TypeUser(this.description);

  String getDescription() {
    return description;
  }
}