// File: config.dart
// Description: Configuration class for API endpoints and database connection parameters.

class AppConfig {
  // Base URL for your API. This should be the URL where your backend server is hosted.
  // Update this to the correct host and port where your backend server is running.
  static const String apiBaseUrl = 'http://solfina-apps.id:38888';

  // Endpoint for user login. This appends '/login' to the base URL.
  static const String loginEndpoint = '$apiBaseUrl/login';

  // Endpoint for fetching data (if applicable). This appends '/api/data' to the base URL.
  static const String dataEndpoint = '$apiBaseUrl/api/data';

  // Optionally, add more endpoints if your application requires additional API routes.
  // static const String anotherEndpoint = '$apiBaseUrl/another-endpoint';

  // Example for API request timeout (if needed). This defines the maximum duration for API requests.
  // You can adjust the timeout value as needed.
  static const Duration requestTimeout = Duration(seconds: 30);
  static const String dbHost = 'solfina-apps.id'; // Nama properti dbHost
  static const String dbPort = '3306'; // Nama properti dbPort
  static const String dbName = 'soln5686_database'; // Nama properti dbName
  static const String dbUserID = 'soln5686_pengguna'; // Nama properti dbUserID
  static const String dbPassword = 'solf1na_mySQL'; // Nama properti dbPassword
}
