import 'package:flutter/material.dart';

class LoginService {
  Future<void> performLogin(BuildContext context) async {
    // Logika login Anda

    if (!context.mounted) return;

    Navigator.pushReplacementNamed(context, '/home');
  }
}
