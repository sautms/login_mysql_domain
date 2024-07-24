import 'package:flutter/material.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  LoginFormState createState() => LoginFormState();
}

class LoginFormState extends State<LoginForm> {
  // ignore: non_constant_identifier_names
  final TextEditingController _UserIDController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(
            controller: _UserIDController,
            decoration: const InputDecoration(
              labelText: 'UserID',
            ),
          ),
          const SizedBox(height: 20),
          TextField(
            controller: _passwordController,
            obscureText: true,
            decoration: const InputDecoration(
              labelText: 'password',
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              _login(context);
            },
            child: const Text('Login'),
          ),
        ],
      ),
    );
  }

  void _login(BuildContext context) {
    // Implementasi proses login di sini
    // ignore: unused_local_variable, non_constant_identifier_names
    String UserID = _UserIDController.text;
    // ignore: unused_local_variable
    String password = _passwordController.text;

    // Lakukan validasi atau kirim permintaan HTTP untuk login
    // Implementasi proses login seperti yang telah dijelaskan sebelumnya
  }
}
