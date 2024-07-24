// lib/api_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'api_response.dart';

/// ApiService adalah kelas yang berisi metode untuk berkomunikasi dengan API.
/// Menggunakan endpoint baseUrl untuk mengakses berbagai layanan API.
class ApiService {
  static const String baseUrl = 'http://localhost:38888'; // URL dasar API yang baru

  /// Fungsi untuk melakukan login ke API.
  /// Mengirimkan username dan password, dan mengembalikan ApiResponse dengan data atau error.
  static Future<ApiResponse<dynamic>> login(String username, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/login'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'username': username,
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body); // Mengurai respon JSON
        return ApiResponse(data: data); // Mengembalikan data jika sukses
      } else {
        return ApiResponse(errorMessage: 'Login gagal: ${response.statusCode}'); // Pesan error jika status kode bukan 200
      }
    } catch (e) {
      return ApiResponse(errorMessage: 'Terjadi kesalahan login: $e'); // Pesan error jika terjadi exception
    }
  }

  /// Fungsi untuk mengambil data dari API menggunakan token autentikasi.
  /// Mengirimkan token dalam header, dan mengembalikan ApiResponse dengan data atau error.
  static Future<ApiResponse<List<dynamic>>> fetchData(String token) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/api/data'),
        headers: {
          'Authorization': 'Bearer $token', // Mengirimkan token autentikasi dalam header
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body) as List<dynamic>; // Mengurai respon JSON
        return ApiResponse(data: data); // Mengembalikan data jika sukses
      } else {
        return ApiResponse(errorMessage: 'Gagal memuat data: ${response.statusCode}'); // Pesan error jika status kode bukan 200
      }
    } catch (e) {
      return ApiResponse(errorMessage: 'Terjadi kesalahan: $e'); // Pesan error jika terjadi exception
    }
  }
}
