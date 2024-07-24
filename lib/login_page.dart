import 'package:flutter/material.dart';
import 'api/api_service.dart';
import 'guest_page.dart';
import 'db_connection.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String _errorMessage = '';

  Future<void> _login() async {
    final String username = _usernameController.text;
    final String password = _passwordController.text;

    try {
      final response = await ApiService.login(username, password);

      if (!mounted) return;

      if (!response.hasError) {
        final token = response.data['token'];

        // Generate ID unik dan timestamp
        final id = DBConnection.generateUniqueId(
          username: username,
          formName: 'LoginPage',
        );
        final timestamp = DateTime.now();

        // Rekam log di user_log_trail
        final conn = await DBConnection.getConnection();
        await DBConnection.recordUserLogTrail(
          conn,
          userId: id,
          userName: username,
          logDetails: 'Login berhasil',
          formName: 'LoginPage',
          logType: 'INFO',
          description: 'User berhasil login',
          source: 'ClientApp',
          computerName: 'UserDevice', // Atau bisa menggunakan perangkat yang dinamis jika tersedia
          timestamp: timestamp,
        );
        await conn.close();

        if (!mounted) return;
        Navigator.pushNamed(
          context,
          '/data',
          arguments: {'token': token, 'userId': id, 'userName': username},
        );
      } else {
        setState(() {
          _errorMessage = response.errorMessage!;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _errorMessage = 'Terjadi kesalahan: $e';
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextField(
              controller: _usernameController,
              decoration: const InputDecoration(labelText: 'Username'),
            ),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _login,
              child: const Text('Login'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const GuestPage()),
                );
              },
              child: const Text('Continue as Guest'),
            ),
            if (_errorMessage.isNotEmpty) ...[
              const SizedBox(height: 20),
              Text(
                _errorMessage,
                style: const TextStyle(color: Colors.red),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
