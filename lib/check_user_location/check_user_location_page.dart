import 'package:flutter/material.dart';

class CheckUserLocationPage extends StatelessWidget {
  const CheckUserLocationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Check User Location'),
      ),
      body: const Center(
        child: Text('This is the Check User Location page.'),
      ),
    );
  }
}
