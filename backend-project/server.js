// Import modul yang diperlukan
const express = require('express');
const mysql = require('mysql2/promise');
const cors = require('cors');
const dotenv = require('dotenv');
const bcrypt = require('bcrypt');
const winston = require('winston');

// Memuat konfigurasi dari file .env
dotenv.config();

const app = express();

// Middleware untuk CORS dan JSON
app.use(cors()); // Mengizinkan Cross-Origin Resource Sharing
app.use(express.json()); // Mem-parsing JSON dari body request

// Setup logger
const logger = winston.createLogger({
  level: 'info',
  format: winston.format.json(),
  transports: [
    new winston.transports.Console(),
    new winston.transports.File({ filename: 'combined.log' })
  ],
});

// Variabel untuk koneksi database
let db;

// Fungsi untuk menghubungkan ke database
async function handleDisconnect() {
  try {
    db = await mysql.createConnection({
      host: process.env.DB_HOST,
      user: process.env.DB_USER,
      password: process.env.DB_PASSWORD,
      database: process.env.DB_NAME
    });
    logger.info(`Connected to MySQL database at ${process.env.DB_HOST}!`);
  } catch (err) {
    logger.error(`Error connecting to MySQL database: ${err}`);
    setTimeout(handleDisconnect, 2000); // Coba lagi setelah 2 detik
  }
}

// Panggil fungsi untuk menghubungkan ke database
handleDisconnect();

// Endpoint untuk login
app.post('/login', async (req, res) => {
  const { username, password } = req.body;

  // Validasi input
  if (!username || !password) {
    return res.status(400).json({ error: 'Username dan password diperlukan' });
  }

  try {
    logger.info('Executing query to fetch user data');
    const [rows] = await db.execute('SELECT * FROM users WHERE username = ?', [username]);
    
    if (rows.length === 0) {
      return res.status(401).json({ error: 'Kredensial salah' });
    }

    const user = rows[0];
    
    // Verifikasi password
    const isPasswordValid = await bcrypt.compare(password, user.password);
    if (!isPasswordValid) {
      return res.status(401).json({ error: 'Kredensial salah' });
    }

    res.json({ message: 'Login berhasil', user });
  } catch (err) {
    logger.error('Error executing query:', err);
    res.status(500).json({ error: 'Internal Server Error', details: err.message });
  }
});



// Endpoint untuk mengambil data
app.get('/api/data', async (req, res) => {
  try {
    const [rows] = await db.execute('SELECT * FROM users');
    res.json(rows);
  } catch (err) {
    logger.error('Error executing query:', err);
    res.status(500).json({ error: 'Internal Server Error', details: err.message });
  }
});

// Menangani rute yang tidak ditemukan
app.use((req, res) => {
  res.status(404).json({ error: 'Not Found' });
});

// Menangani kesalahan server
app.use((err, req, res, next) => {
  logger.error('Server Error:', err);
  res.status(500).json({ error: 'Internal Backend Server Error', details: err.message });
});

// Menentukan port dan memulai server
const port = process.env.PORT || 38888;
app.listen(port, '0.0.0.0', () => {
  logger.info(`Backend server is running at http://0.0.0.0:${port}`);
});
