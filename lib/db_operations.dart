// untuk menangani operasi CRUD seperti select, insert, update, dan delete:
import 'db_connection.dart';

class DBOperations {
  static Future<void> fetchData() async {
    var conn = await DBConnection.getConnection();
    // Proses hasil query
    await conn.close();
  }

  static Future<void> insertData(String data) async {
    var conn = await DBConnection.getConnection();
    await conn.query('INSERT INTO tabel_data (field) VALUES (?)', [data]);
    // Proses hasil query
    await conn.close();
  }
  // Komentar: Kelas ini digunakan untuk melakukan operasi CRUD pada basis data MySQL.
}
