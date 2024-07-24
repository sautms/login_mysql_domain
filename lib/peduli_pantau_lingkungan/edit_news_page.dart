import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class EditNewsPage extends StatefulWidget {
  final int newsId;
  final String initialTitle;
  final String initialContent;
  final String initialAuthor;

  const EditNewsPage({
    super.key,
    required this.newsId,
    required this.initialTitle,
    required this.initialContent,
    required this.initialAuthor,
  });

  @override
  EditNewsPageState createState() => EditNewsPageState();
}

class EditNewsPageState extends State<EditNewsPage> {
  late TextEditingController titleController;
  late TextEditingController contentController;
  late TextEditingController authorController;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(text: widget.initialTitle);
    contentController = TextEditingController(text: widget.initialContent);
    authorController = TextEditingController(text: widget.initialAuthor);
  }

  Future<void> editNews() async {
    try {
      final response = await http.put(
        Uri.parse('http://yourdomain.com/api/edit-news/${widget.newsId}'),
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
            const SnackBar(content: Text('Berita berhasil diupdate')),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Gagal mengupdate berita')),
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
        title: const Text('Edit Berita'),
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
              onPressed: editNews,
              child: const Text('Update Berita'),
            ),
          ],
        ),
      ),
    );
  }
}
