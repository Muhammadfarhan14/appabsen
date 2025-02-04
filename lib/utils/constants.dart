// ignore: constant_identifier_names
const URL_TIME = 'https://worldtimeapi.org/api/timezone/Asia/Kuala_Lumpur';
const URL = "http://192.168.1.4:8000";
const BASE_URL = "$URL/api";
const BASE_IMAGE = '$URL/images';
const URL_RESET_PASSWORD = '$BASE_URL/reset-password';
const URL_CHECK_ABSEN_DATANG = '$BASE_URL/mahasiswa/absen/check_absen';
const URL_GET_ABSEN = '$BASE_URL/mahasiswa/absen/get';
const URL_GET_ABSEN_BULAN_INI = '$BASE_URL/mahasiswa/absen/bulan';
const URL_GET_ABSEN_TANGGAL = '$BASE_URL/mahasiswa/absen/tanggal';
const URL_ABSEN_DATANG = '$BASE_URL/mahasiswa/absen/create';
const URL_GET_LOKASI_PPL = '$BASE_URL/dosen-pembimbing/home_lokasi_ppl';
const URL_GET_DETAIL_LOKASI_PPL =
    '$BASE_URL/dosen-pembimbing/detail_lokasi_ppl';

const KEY_TOKEN = "token";
const KEY_TYPE_AKUN = "akun";
const KEY_ID = "id";

enum TypeUser {
  // pembimbingLapangan("Pembimbing Lapangan"),
  dosenPembimbing("dosen_pembimbing"),
  mahasiswa("mahasiswa");

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

enum StatusAbsen {
  absen("absen"),
  belumAbsen("belum absen"),
  tidakHadir("tidak hadir");

  final String description;

  const StatusAbsen(this.description);

  String getDescription() {
    return description;
  }
}
