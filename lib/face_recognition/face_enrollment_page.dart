import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;
import 'package:http_parser/http_parser.dart';
import 'package:logging/logging.dart';

// Inisialisasi Logger
final Logger _logger = Logger('FaceEnrollmentPage');

class FaceEnrollmentPage extends StatefulWidget {
  const FaceEnrollmentPage({super.key});

  @override
  FaceEnrollmentPageState createState() => FaceEnrollmentPageState();
}

class FaceEnrollmentPageState extends State<FaceEnrollmentPage> {
  File? _image;
  final picker = ImagePicker();

  Future<void> _getImage() async {
    try {
      final pickedFile = await picker.pickImage(source: ImageSource.camera);

      setState(() {
        if (pickedFile != null) {
          _image = File(pickedFile.path);
        } else {
          _logger.info('No image selected.');
        }
      });
    } catch (e) {
      _logger.severe('Failed to pick image: $e');
    }
  }

  Future<void> _uploadImage() async {
    if (_image == null) return;

    // ignore: unused_local_variable
    String fileName = path.basename(_image!.path);
    var request = http.MultipartRequest('POST', Uri.parse('http://your-domain.com/upload'));
    request.files.add(await http.MultipartFile.fromPath(
      'file',
      _image!.path,
      contentType: MediaType('image', 'jpeg'),
    ));
    try {
      var res = await request.send();

      if (res.statusCode == 200) {
        _logger.info('File Uploaded');
      } else {
        _logger.warning('Failed to upload file, status code: ${res.statusCode}');
      }
    } catch (e) {
      _logger.severe('Error during file upload: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Face Enrollment'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _image == null
                ? const Text('No image selected.')
                : Image.file(_image!),
            ElevatedButton(
              onPressed: _getImage,
              child: const Icon(Icons.camera_alt),
            ),
            ElevatedButton(
              onPressed: _uploadImage,
              child: const Text('Upload Image'),
            ),
          ],
        ),
      ),
    );
  }
}
