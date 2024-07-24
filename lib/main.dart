import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart'; // Import Firebase Core
import 'login_page.dart';  // Import halaman login
import 'data_page.dart';   // Import halaman data
import 'guest_page.dart';  // Import halaman guest
import 'check_user_location/check_user_location_page.dart';  // Import halaman Check User Location
import 'peduli_pantau_lingkungan/peduli_pantau_lingkungan_page.dart'; // Import halaman Peduli Pantau Lingkungan
import 'tarombo/tarombo_somba_debata_siahaan_page.dart'; // Import halaman Tarombo Somba Debata Siahaan

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Pastikan widget binding telah diinisialisasi
  await Firebase.initializeApp(); // Inisialisasi Firebase
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/data':
            final args = settings.arguments as Map<String, dynamic>?;
            return MaterialPageRoute(
              builder: (context) => DataPage(
                token: args?['token'] ?? '',
                userId: args?['userId'] ?? '',
                userName: args?['userName'] ?? '',
              ),
            );
          case '/guest':
            return MaterialPageRoute(
              builder: (context) => const GuestPage(),
            );
          case '/check_user_location':
            return MaterialPageRoute(
              builder: (context) => const CheckUserLocationPage(),
            );
          case '/peduli_pantau_lingkungan':
            return MaterialPageRoute(
              builder: (context) => const PeduliPantauLingkunganPage(),
            );
          case '/tarombo_somba_debata_siahaan':
            return MaterialPageRoute(
              builder: (context) => const TaromboSombaDebataSiahaanPage(),
            );
          // Handle other routes if necessary
          default:
            return MaterialPageRoute(
              builder: (context) => const LoginPage(),
            );
        }
      },
    );
  }
}
