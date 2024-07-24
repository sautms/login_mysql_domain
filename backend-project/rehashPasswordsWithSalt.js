// rehashPasswordsWithSalt.js
const bcrypt = require('bcrypt');

const passwords = ['solf1na_mySQL']; // Password yang perlu diuji
const saltRounds = 10; // Pastikan ini sesuai dengan jumlah salt rounds yang digunakan sebelumnya

(async () => {
  for (const password of passwords) {
    const hash = await bcrypt.hash(password, saltRounds);
    console.log(`Password: ${password}`);
    console.log(`Hashed: ${hash}`);
  }
})();
