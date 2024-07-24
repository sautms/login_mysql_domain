import 'package:flutter/material.dart';
import 'news_content_page.dart';

class NewsDetailPage extends StatelessWidget {
  final String category;

  const NewsDetailPage({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    // Dummy data for demonstration
    final List<String> newsItems = List.generate(
      10,
      (index) => '$category Berita $index',
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(category),
      ),
      body: ListView.builder(
        itemCount: newsItems.length,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.all(8.0),
            child: ListTile(
              contentPadding: const EdgeInsets.all(16.0),
              title: Text(newsItems[index]),
              trailing: const Icon(Icons.arrow_forward),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => NewsContentPage(newsTitle: newsItems[index]),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
