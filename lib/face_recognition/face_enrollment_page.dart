import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as path;

class FaceEnrollmentPage extends StatefulWidget {
  @override
  _FaceEnrollmentPageState createState() => _FaceEnrollmentPageState();
}

class _FaceEnrollmentPageState extends State<FaceEnrollmentPage> {
  File? _image;
  final picker = ImagePicker();

  Future<void> _getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  Future<void> _uploadImage() async {
    if (_image == null) return;

    String fileName = path.basename(_image!.path);
    Reference firebaseStorageRef = FirebaseStorage.instance.ref().child('uploads/$fileName');
    UploadTask uploadTask = firebaseStorageRef.putFile(_image!);
    await uploadTask.whenComplete(() {
      print('File Uploaded');
      firebaseStorageRef.getDownloadURL().then((fileURL) {
        print('File URL: $fileURL');
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Face Enrollment'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _image == null
                ? Text('No image selected.')
                : Image.file(_image!),
            ElevatedButton(
              onPressed: _getImage,
              child: Icon(Icons.camera_alt),
            ),
            ElevatedButton(
              onPressed: _uploadImage,
              child: Text('Upload Image'),
            ),
          ],
        ),
      ),
    );
  }
}
