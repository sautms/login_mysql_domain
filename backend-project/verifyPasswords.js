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

  // Ambil semua password dari tabel users
  const [users] = await connection.execute('SELECT UserID, password FROM users');

  for (const user of users) {
    console.log(`Password hash in database for user ${user.UserID}: ${user.password}`);
    const originalPassword = 'solf1na_mySQL';

    // Verifikasi hash password dari database
    const isPasswordValid = await bcrypt.compare(originalPassword, user.password);
    console.log(`Password match for user ${user.UserID}: ${isPasswordValid}`);

    // Hash ulang password untuk verifikasi
    const rehashedPassword = await bcrypt.hash(originalPassword, 10);
    console.log(`Rehashed password: ${rehashedPassword}`);
    const isRehashedPasswordValid = await bcrypt.compare(originalPassword, rehashedPassword);
    console.log(`Rehashed password match for user ${user.UserID}: ${isRehashedPasswordValid}`);
  }

  await connection.end();
})();
