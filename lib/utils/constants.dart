// ignore: constant_identifier_names
const URL_TIME = 'https://worldtimeapi.org/api/timezone/Asia/Kuala_Lumpur';
const BASE_URL = 'http://192.168.1.4:8000/api';
const URL_CHECK_ABSEN_DATANG = '$BASE_URL/mahasiswa/absen/check_absen';
const URL_ABSEN_DATANG = '$BASE_URL/mahasiswa/absen/create';
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

enum Absen {
  hadir("hadir"),
  izin("izin"),
  sakit("sakit");

  final String description;

  const Absen(this.description);

  String getDescription() {
    return description;
  }
}
