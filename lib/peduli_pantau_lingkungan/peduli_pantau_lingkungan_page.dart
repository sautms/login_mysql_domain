import 'package:flutter/material.dart';

class PeduliPantauLingkunganPage extends StatelessWidget {
  const PeduliPantauLingkunganPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Peduli Pantau Lingkungan'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              showSearch(
                context: context,
                delegate: NewsSearchDelegate(),
              );
            },
          ),
        ],
      ),
      body: ListView(
        children: <Widget>[
          _buildCategoryTile(
            context,
            category: 'Berita Keluarga dan Komunitas',
            description: 'Berita tentang kegiatan, perayaan, atau acara penting di komunitas atau keluarga besar.',
            imageUrl: 'assets/images/peduli_pantau_lingkungan/community.jpg', // Gambar thumbnail
          ),
          _buildCategoryTile(
            context,
            category: 'Isu Lingkungan Lokal',
            description: 'Berita terkait dengan isu-isu lingkungan yang berdampak langsung pada daerah tempat tinggal keluarga.',
            imageUrl: 'assets/images/peduli_pantau_lingkungan/environment.jpg', // Gambar thumbnail
          ),
          _buildCategoryTile(
            context,
            category: 'Kegiatan Sosial dan Amal',
            description: 'Berita tentang kegiatan sosial dan amal yang melibatkan atau menguntungkan keluarga dan komunitas.',
            imageUrl: 'assets/images/peduli_pantau_lingkungan/social_charity.jpg', // Gambar thumbnail
          ),
          _buildCategoryTile(
            context,
            category: 'Pendidikan dan Informasi Keluarga',
            description: 'Berita tentang program pendidikan atau informasi yang relevan untuk keluarga.',
            imageUrl: 'assets/images/peduli_pantau_lingkungan/education_family.jpg', // Gambar thumbnail
          ),
          _buildCategoryTile(
            context,
            category: 'Peristiwa dan Pencapaian Keluarga',
            description: 'Berita tentang pencapaian atau peristiwa penting dalam keluarga.',
            imageUrl: 'assets/images/peduli_pantau_lingkungan/family_achievement.jpg', // Gambar thumbnail
          ),
          _buildCategoryTile(
            context,
            category: 'Berita Kesehatan dan Kesejahteraan',
            description: 'Berita yang berkaitan dengan kesehatan dan kesejahteraan anggota keluarga.',
            imageUrl: 'assets/images/peduli_pantau_lingkungan/health_wellness.jpg', // Gambar thumbnail
          ),
          _buildCategoryTile(
            context,
            category: 'Update dari Organisasi Keluarga',
            description: 'Berita dari organisasi atau asosiasi keluarga.',
            imageUrl: 'assets/images/peduli_pantau_lingkungan/family_organization.jpg', // Gambar thumbnail
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryTile(BuildContext context, {required String category, required String description, required String imageUrl}) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16.0),
        leading: Image.asset(
          imageUrl,
          width: 50,
          height: 50,
          fit: BoxFit.cover,
        ),
        title: Text(
          category,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        subtitle: Text(description),
        trailing: const Icon(Icons.arrow_forward),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => NewsDetailPage(category: category),
            ),
          );
        },
      ),
    );
  }
}

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

class NewsSearchDelegate extends SearchDelegate<String> {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestions = [
      'Berita Keluarga dan Komunitas',
      'Isu Lingkungan Lokal',
      'Kegiatan Sosial dan Amal',
      'Pendidikan dan Informasi Keluarga',
      'Peristiwa dan Pencapaian Keluarga',
      'Berita Kesehatan dan Kesejahteraan',
      'Update dari Organisasi Keluarga'
    ].where((category) => category.toLowerCase().contains(query.toLowerCase()))
    .toList();

    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        final suggestion = suggestions[index];
        return ListTile(
          title: Text(suggestion),
          onTap: () {
            query = suggestion;
            showResults(context);
          },
        );
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Center(
      child: Text(
        'Hasil pencarian untuk: $query',
        style: const TextStyle(fontSize: 24),
      ),
    );
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, '');
      },
    );
  }
}
