import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Jika Anda menggunakan Firestore
import '../home_page.dart';
import 'package:logger/logger.dart';

final logger = Logger();

class AdditionalInfoPage extends StatefulWidget {
  final User user;

  const AdditionalInfoPage({super.key, required this.user});

  @override
  AdditionalInfoPageState createState() => AdditionalInfoPageState();
}

class AdditionalInfoPageState extends State<AdditionalInfoPage> {
  final _usernameController = TextEditingController();

  void _saveAdditionalInfo() async {
    final username = _usernameController.text;
    if (username.isNotEmpty) {
      try {
        await FirebaseFirestore.instance.collection('users').doc(widget.user.uid).set(
          {'username': username},
          SetOptions(merge: true),
        );

        if (mounted) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => HomePage(user: widget.user)),
          );
        }
      } catch (e) {
        logger.e('Error saving additional info: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Additional Info"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _usernameController,
              decoration: const InputDecoration(labelText: "Username"),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _saveAdditionalInfo,
              child: const Text("Save"),
            ),
          ],
        ),
      ),
    );
  }
}
