import 'package:flutter/material.dart';

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
