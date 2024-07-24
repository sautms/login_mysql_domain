import 'package:flutter/material.dart';

class NewsContentPage extends StatelessWidget {
  final String newsTitle;

  const NewsContentPage({super.key, required this.newsTitle});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(newsTitle),
      ),
      body: Center(
        child: Text(
          'Konten berita untuk $newsTitle',
          style: const TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
