import 'package:mysql1/mysql1.dart';
import 'config.dart';
import 'package:logging/logging.dart';

class UserLog {
  static final Logger _logger = Logger('UserLog');

  static Future<void> recordUserLogTrail({
    required String userId,
    required String userName,
    required String logDetails,
    required String formName,
    required String logType,
    required String description,
    required String source,
    required String computerName,
    DateTime? timestamp, // Tambahkan parameter timestamp
    String? uniqueId, // Tambahkan parameter uniqueId
  }) async {
    try {
      final settings = ConnectionSettings(
        host: AppConfig.dbHost, // Pastikan nama properti benar
        port: int.parse(AppConfig.dbPort), // Pastikan nama properti benar
        user: AppConfig.dbUserID, // Pastikan nama properti benar
        password: AppConfig.dbPassword, // Pastikan nama properti benar
        db: AppConfig.dbName, // Pastikan nama properti benar
      );

      final conn = await MySqlConnection.connect(settings);
      _logger.info('Connected to database for logging');

      await conn.query(
        'INSERT INTO user_log_trail (user_id, user_name, log_details, form_name, log_type, description, source, computer_name, timestamp, unique_id) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)',
        [
          userId,
          userName,
          logDetails,
          formName,
          logType,
          description,
          source,
          computerName,
          timestamp?.toIso8601String(), // Simpan timestamp dalam format ISO 8601
          uniqueId,
        ],
      );

      await conn.close();
      _logger.info('Log entry recorded and database connection closed');
    } catch (e) {
      _logger.severe('Failed to record log: $e');
    }
  }
}
