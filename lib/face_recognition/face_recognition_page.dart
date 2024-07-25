import 'package:flutter/material.dart';

class FaceRecognitionPage extends StatelessWidget {
  const FaceRecognitionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Face Recognition'),
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Tampilkan tampilan kamera untuk pemindaian wajah
            Text('Position your face within the frame'),
            // Tambahkan widget kamera dan pemrosesan gambar di sini
          ],
        ),
      ),
    );
  }
}
