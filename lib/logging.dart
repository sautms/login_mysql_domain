import 'package:logging/logging.dart';

final Logger _logger = Logger('UserLog');

void setupLogging(Logger logger) {
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((record) {
    _logger.log(record.level, '${record.level.name}: ${record.time}: ${record.message}');
  });
}
