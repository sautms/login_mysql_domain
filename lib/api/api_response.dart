// lib/api_response.dart

/// Kelas ApiResponse adalah wrapper untuk hasil dari permintaan API.
/// Menggunakan generic type T untuk menyimpan data yang diterima dari API.
class ApiResponse<T> {
  final T? data; // Data yang diterima dari API, bisa berupa apapun sesuai generic type T
  final String? errorMessage; // Pesan error jika terjadi kesalahan

  ApiResponse({this.data, this.errorMessage});

  /// Properti untuk mengecek apakah ada error
  bool get hasError => errorMessage != null;
}
