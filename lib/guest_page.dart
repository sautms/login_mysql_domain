import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'check_user_location/check_user_location_page.dart';
import 'peduli_pantau_lingkungan/peduli_pantau_lingkungan_page.dart';
import 'tarombo/tarombo_somba_debata_siahaan_page.dart';
import 'sign_in/google_sign_in_page.dart';
import 'face_recognition/face_recognition_page.dart';

class GuestPage extends StatelessWidget {
  const GuestPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Guest Menu'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CheckUserLocationPage(),
                  ),
                );
              },
              child: const Text('Check User Location'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const PeduliPantauLingkunganPage(),
                  ),
                );
              },
              child: const Text('Peduli Pantau Lingkungan'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const TaromboSombaDebataSiahaanPage(),
                  ),
                );
              },
              child: const Text('Tarombo Somba Debata Siahaan'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const GoogleSignInPage(),
                  ),
                );
              },
              child: const Text('Sign in with Google'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () async {
                // Menggunakan availableCameras() untuk mendapatkan daftar kamera
                final cameras = await availableCameras();

                // Cek apakah widget masih dipasang
                if (!context.mounted) return;

                // Navigasi ke FaceRecognitionPage dengan kamera pertama yang tersedia
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FaceRecognitionPage(camera: cameras.first),
                  ),
                );
              },
              child: const Text('Face Recognition'),
            ),
          ],
        ),
      ),
    );
  }
}
