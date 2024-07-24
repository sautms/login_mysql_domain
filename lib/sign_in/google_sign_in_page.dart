import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'additional_info_page.dart'; // Pastikan jalur impor benar
import 'package:logger/logger.dart';

class GoogleSignInPage extends StatefulWidget {
  const GoogleSignInPage({super.key});

  @override
  GoogleSignInPageState createState() => GoogleSignInPageState();
}

class GoogleSignInPageState extends State<GoogleSignInPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final Logger _logger = Logger();

  Future<void> _signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        // Proses login dibatalkan oleh pengguna
        _logger.i('Login with Google canceled by user.');
        return;
      }

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential = await _auth.signInWithCredential(credential);
      final User? user = userCredential.user;

      if (user != null) {
        _logger.i('User signed in: ${user.email}');
        // Simpan informasi tambahan ke Firestore jika diperlukan
        if (mounted) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => AdditionalInfoPage(user: user), // Pindah ke halaman info tambahan
            ),
          );
        }
      }
    } catch (e) {
      _logger.e('Error signing in with Google: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sign In with Google"),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            await _signInWithGoogle(); // Memanggil metode sign-in
          },
          child: const Text("Sign In with Google"),
        ),
      ),
    );
  }
}
