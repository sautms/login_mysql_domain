import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AddNewsPage extends StatefulWidget {
  const AddNewsPage({super.key});

  @override
  AddNewsPageState createState() => AddNewsPageState();
}

class AddNewsPageState extends State<AddNewsPage> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController contentController = TextEditingController();
  final TextEditingController authorController = TextEditingController();

  Future<void> addNews() async {
    try {
      final response = await http.post(
        Uri.parse('http://yourdomain.com/api/add-news'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'title': titleController.text,
          'content': contentController.text,
          'author': authorController.text,
        }),
      );

      if (mounted) {
        if (response.statusCode == 200) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Berita berhasil ditambahkan')),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Gagal menambahkan berita')),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Terjadi kesalahan')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tambah Berita Baru'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(labelText: 'Judul Berita'),
            ),
            TextField(
              controller: contentController,
              decoration: const InputDecoration(labelText: 'Konten Berita'),
              maxLines: 10,
            ),
            TextField(
              controller: authorController,
              decoration: const InputDecoration(labelText: 'Penulis'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: addNews,
              child: const Text('Kirim Berita'),
            ),
          ],
        ),
      ),
    );
  }
}
