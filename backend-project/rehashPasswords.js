// rehashPasswords.js
const bcrypt = require('bcrypt');

const passwords = ['solf1na_mySQL', 'solf1na_mySQL']; // Tambahkan password yang perlu diuji

(async () => {
  for (const password of passwords) {
    const hash = await bcrypt.hash(password, 10);
    console.log(`Password: ${password}`);
    console.log(`Hashed: ${hash}`);
  }
})();
