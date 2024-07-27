import 'package:flutter/material.dart';
import 'check_user_location/check_user_location_page.dart';
import 'peduli_pantau_lingkungan/peduli_pantau_lingkungan_page.dart';
import 'tarombo/tarombo_somba_debata_siahaan_page.dart';
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
                const description = '''
                This page will perform the following steps:
                1. Initialize the camera.
                2. Start capturing images from the camera stream.
                3. Process each image to detect faces.
                4. Display detected faces and their bounding boxes.
                5. Handle errors and provide feedback.

                You will see updates as each step progresses.
                ''';

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const FaceRecognitionPage(description: description), // Corrected usage
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
