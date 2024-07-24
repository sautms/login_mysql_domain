import 'package:mysql1/mysql1.dart';
import 'package:logging/logging.dart';
import 'package:intl/intl.dart'; // Tambahkan import ini untuk format tanggal
import 'config.dart';

final Logger _logger = Logger('DBConnection');

class DBConnection {
  // Fungsi untuk menghasilkan ID unik
  static String generateUniqueId({
    required String username,
    required String formName,
  }) {
    final timestamp = DateFormat('yyyyMMddHHmmss').format(DateTime.now());
    return '$username-$formName-$timestamp';
  }

  static Future<MySqlConnection> getConnection() async {
    final settings = ConnectionSettings(
      host: AppConfig.dbHost, // Pastikan ini sesuai dengan pengaturan database
      port: int.parse(AppConfig.dbPort), // Pastikan port sudah benar
      user: AppConfig.dbUserID, // Pastikan username database benar
      password: AppConfig.dbPassword, // Pastikan password benar
      db: AppConfig.dbName, // Pastikan nama database benar
    );

    try {
      final conn = await MySqlConnection.connect(settings);
      _logger.info('Connected to MySQL database');
      return conn;
    } catch (e) {
      _logger.severe('Error connecting to MySQL: $e');
      rethrow;
    }
  }

  static Future<void> recordUserLogTrail(MySqlConnection conn, {
    required String userId,
    required String userName,
    required String logDetails,
    required String formName,
    required String logType,
    required String description,
    required String source,
    required String computerName,
    required DateTime timestamp,
  }) async {
    try {
      await conn.query(
        'INSERT INTO user_log_trail (id, user_id, user_name, log_details, form_name, log_type, description, source, computer_name, time_stamp) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)',
        [
          userId, // ID unik yang dihasilkan sebelumnya
          userId,
          userName,
          logDetails,
          formName,
          logType,
          description,
          source,
          computerName,
          timestamp.toIso8601String(), // Menggunakan format ISO8601 untuk timestamp
        ],
      );
      _logger.info('Log entry recorded');
    } catch (e) {
      _logger.severe('Failed to record log: $e');
    }
  }
}
