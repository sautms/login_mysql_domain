const mysql = require('mysql2/promise');
const bcrypt = require('bcrypt');
const dotenv = require('dotenv');

// Memuat konfigurasi dari file .env
dotenv.config();

(async () => {
  // Koneksi ke database
  const connection = await mysql.createConnection({
    host: process.env.DB_HOST,
    user: process.env.DB_USER,
    password: process.env.DB_PASSWORD,
    database: process.env.DB_NAME
  });

  console.log('Connected to MySQL database.');

  // Password asli yang perlu di-hash ulang
  const originalPassword = 'solf1na_mySQL';

  // Hash password asli
  const hashedPassword = await bcrypt.hash(originalPassword, 10);
  console.log('Hashed password:', hashedPassword);

  // Update password di database untuk user soln5686_administrator
  await connection.execute('UPDATE users SET password = ? WHERE UserID = ?', [hashedPassword, 'soln5686_administrator']);
  console.log('Updated password for user soln5686_administrator');

  // Update password di database untuk user soln5686_pengguna
  await connection.execute('UPDATE users SET password = ? WHERE UserID = ?', [hashedPassword, 'soln5686_pengguna']);
  console.log('Updated password for user soln5686_pengguna');

  console.log('Password update complete.');
  await connection.end();
})();

