import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
import 'package:logging/logging.dart'; // Import logging dari paket logging
import 'dart:typed_data'; // Import untuk Uint8List

class FaceRecognitionPage extends StatefulWidget {
  final CameraDescription camera;

  const FaceRecognitionPage({super.key, required this.camera});

  @override
  FaceRecognitionPageState createState() => FaceRecognitionPageState();
}

class FaceRecognitionPageState extends State<FaceRecognitionPage> {
  late CameraController _controller;
  late FaceDetector _faceDetector;

  final Logger _logger = Logger('FaceRecognitionPageState');

  @override
  void initState() {
    super.initState();
    _controller = CameraController(
      widget.camera,
      ResolutionPreset.high,
    );

    _faceDetector = FaceDetector(
      options: FaceDetectorOptions(
        performanceMode: FaceDetectorMode.accurate,
        enableContours: true,
      ),
    );

    _controller.initialize().then((_) {
      _controller.startImageStream((image) {
        _processImage(image);
      });
    }).catchError((e) {
      _logger.severe('Error initializing camera: $e');
    });
  }

  Future<void> _processImage(CameraImage image) async {
    final bytes = _convertCameraImageToBytes(image);
    final Size imageSize = Size(image.width.toDouble(), image.height.toDouble());

    final InputImageRotation imageRotation =
        InputImageRotationValue.fromRawValue(widget.camera.sensorOrientation) ?? InputImageRotation.rotation0deg;

    final InputImageFormat inputImageFormat =
        InputImageFormatValue.fromRawValue(image.format.raw) ?? InputImageFormat.nv21;

    final inputImage = InputImage.fromBytes(
      bytes: bytes,
      metadata: InputImageMetadata(
        size: imageSize,
        rotation: imageRotation,
        format: inputImageFormat,
        bytesPerRow: image.planes[0].bytesPerRow, // Tambahkan bytesPerRow di sini
      ),
    );

    try {
      final List<Face> faces = await _faceDetector.processImage(inputImage);

      for (Face face in faces) {
        _logger.info('BoundingBox: ${face.boundingBox}');
      }
    } catch (e) {
      _logger.severe('Error: $e');
    }
  }

  Uint8List _convertCameraImageToBytes(CameraImage image) {
    final Plane plane = image.planes[0];
    return plane.bytes;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Face Recognition'),
      ),
      body: FutureBuilder<void>(
        future: _controller.initialize(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return CameraPreview(_controller);
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _faceDetector.close();
    super.dispose();
  }
}
