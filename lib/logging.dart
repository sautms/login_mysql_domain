import 'package:logging/logging.dart';

final Logger _logger = Logger('UserLog');

void setupLogging() {
  Logger.root.level = Level.ALL; // Set logging level
  Logger.root.onRecord.listen((record) {
    // Log to console using _logger
    _logger.log(record.level, '${record.level.name}: ${record.time}: ${record.message}');
  });
}
