import 'package:logging/logging.dart';

final Logger logger = Logger('PasswordUtil'); // Inisialisasi logger dengan nama

String hashPassword(String password) {
  String hashedPassword = '...'; // Implementasi hashing password
  logger.info('Password hashed: $hashedPassword'); // Menggunakan logger untuk output
  return hashedPassword;
}

Future<bool> verifyPassword(String password, String hashedPassword) async {
  bool isMatch = false; // Implementasi verifikasi password
  logger.info('Password matches: $isMatch'); // Menggunakan logger untuk output
  return isMatch;
}
