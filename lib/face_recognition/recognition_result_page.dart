import 'package:flutter/material.dart';

class RecognitionResultPage extends StatelessWidget {
  final bool isSuccess;

  const RecognitionResultPage({super.key, required this.isSuccess});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recognition Result'),
      ),
      body: Center(
        child: isSuccess ? 
          const Text('Face recognized successfully') :
          const Text('Face recognition failed'),
        // Tambahkan logika untuk menangani hasil pengenalan
      ),
    );
  }
}
