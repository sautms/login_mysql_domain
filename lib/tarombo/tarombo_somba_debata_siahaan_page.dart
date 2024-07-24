import 'package:flutter/material.dart';
import 'update_profile_page.dart'; // Pastikan untuk mengimpor file ini

class TaromboSombaDebataSiahaanPage extends StatelessWidget {
  const TaromboSombaDebataSiahaanPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tarombo Somba Debata Siahaan'),
        actions: [
          IconButton(
            icon: const Icon(Icons.login),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const UpdateProfilePage(username: 'user123'), // Ganti 'user123' dengan username aktual
                ),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const UpdateProfilePage(username: 'user123'), // Ganti 'user123' dengan username aktual
                ),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            const Text(
              'Keturunan Siraja Batak:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            _buildFamilyList([
              'Si Raja Batak',
              'Raja Isumbaon',
              'Tuan Sorimangaraja',
              'Tuan Sorbadibanua (Raja Nai Suanon)',
              'Sibagot ni Pohan',
              'Tuan Somanimbil',
              'Ompu Somba Debata Siahaan',
            ]),
            const SizedBox(height: 20),
            const Text(
              'Keturunan Ompu Somba Debata Siahaan:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            _buildFamilyList([
              'Raja Marhite Ombun',
              'Raja Hinalang',
              'Raja Juaramonang',
              'Tuan Pangorian',
              'Namora Tano',
              'Tuan Pangerlam',
              'Tuan Mauli',
            ]),
          ],
        ),
      ),
    );
  }

  Widget _buildFamilyList(List<String> names) {
    return Column(
      children: names.map((name) => Text(name, style: const TextStyle(fontSize: 16))).toList(),
    );
  }
}
