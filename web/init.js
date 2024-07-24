// Import the functions you need from the SDKs you need
import { initializeApp } from 'firebase/app';
import { getAuth } from 'firebase/auth';

// Your web app's Firebase configuration
const firebaseConfig = {
  apiKey: "AIzaSyAMWAFkImgXaqTxTTXiOuAuCuUUyihsYRI",
  authDomain: "login-mysql-domain.firebaseapp.com",
  projectId: "login-mysql-domain",
  storageBucket: "login-mysql-domain.appspot.com",
  messagingSenderId: "1016408346389",
  appId: "1:1016408346389:web:ea5177b77507d38dcd231c",
  measurementId: "G-XXXXXXXXXX"
};

// Initialize Firebase
const app = initializeApp(firebaseConfig);
const auth = getAuth(app);
