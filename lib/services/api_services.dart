import 'package:flutter_application_1/utils/log.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';

class ApiService {
  // Fungsi untuk melakukan GET request
  Future<Map<String, dynamic>> getRequest(String url, String? token) async {
    Log.debug(token);
    final response = await http.get(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    return _handleResponse(response);
  }

  // Fungsi untuk melakukan POST request
  Future<Map<String, dynamic>> postRequest(
    String url, [
    String? token,
    Map<String, dynamic>? fields,
    File? file,
  ]) async {
    final uri = Uri.parse(url);
    final request = http.MultipartRequest('POST', uri);

    // Tambahkan header
    if (token != null) {
      request.headers['Authorization'] = 'Bearer $token';
    }

    // Tambahkan field jika ada
    if (fields != null) {
      fields.forEach((key, value) {
        request.fields[key] = value.toString();
      });
    }

    // Tambahkan file jika ada
    if (file != null) {
      final fileStream = http.MultipartFile.fromBytes(
        'file', // Key untuk file di form-data
        await file.readAsBytes(),
        filename: file.path.split('/').last,
      );
      request.files.add(fileStream);
    }

    // Kirim request
    final response = await http.Response.fromStream(await request.send());

    // Handle response
    return _handleResponse(response);
  }

  // Fungsi untuk menangani response
  Map<String, dynamic> _handleResponse(http.Response response) {
    final resDecodeMe = jsonDecode(response.body);

    if (response.statusCode == 200) {
      return resDecodeMe; // Return data jika berhasil
    } else {
      throw Exception(resDecodeMe['message']); // Tampilkan pesan error
    }
  }
}
