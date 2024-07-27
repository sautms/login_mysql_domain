import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
import 'package:logging/logging.dart';

class FaceRecognitionPage extends StatefulWidget {
  final String description;

  const FaceRecognitionPage({super.key, required this.description});

  @override
  FaceRecognitionPageState createState() => FaceRecognitionPageState();
}

class FaceRecognitionPageState extends State<FaceRecognitionPage> {
  late CameraController _controller;
  late FaceDetector _faceDetector;
  late Logger _logger;

  @override
  void initState() {
    super.initState();
    _logger = Logger('FaceRecognitionPage');
    _initCamera();
    _initFaceDetector();
  }

  Future<void> _initCamera() async {
    final cameras = await availableCameras();
    _controller = CameraController(cameras[0], ResolutionPreset.high);

    _controller.initialize().then((_) {
      if (!mounted) return;
      setState(() {});
      _controller.startImageStream((CameraImage image) {
        _processImage(image);
      });
    }).catchError((e) {
      _logger.severe('Error initializing camera', e);
    });
  }

  void _initFaceDetector() {
    _faceDetector = FaceDetector(options: FaceDetectorOptions(
      enableContours: true,
      enableClassification: true,
    ));
  }

  Future<void> _processImage(CameraImage image) async {
    final bytes = _concatenatePlanes(image.planes);

    final inputImage = InputImage.fromBytes(
      bytes: bytes,
      inputImageData: InputImageData(
        size: Size(image.width.toDouble(), image.height.toDouble()),
        imageRotation: _getRotationFromSensorOrientation(_controller.description.sensorOrientation),
        inputImageFormat: InputImageFormat.yuv420, // Gantilah dengan format yang sesuai
        planeData: image.planes.map((Plane plane) {
          return InputImagePlaneMetadata(
            bytesPerRow: plane.bytesPerRow,
            height: plane.height,
            width: plane.width,
          );
        }).toList(),
      ),
    );

    try {
      final faces = await _faceDetector.processImage(inputImage);
      for (Face face in faces) {
        // Handle detected faces
        _logger.info('Detected face with bounding box: ${face.boundingBox}');
      }
    } catch (e) {
      _logger.severe('Error processing image', e);
    }
  }

  Uint8List _concatenatePlanes(List<Plane> planes) {
    final buffer = BytesBuilder();
    for (final plane in planes) {
      buffer.add(Uint8List.fromList(plane.bytes));
    }
    return buffer.toBytes();
  }

  InputImageRotation _getRotationFromSensorOrientation(int sensorOrientation) {
    switch (sensorOrientation) {
      case 0:
        return InputImageRotation.rotation0deg;
      case 90:
        return InputImageRotation.rotation90deg;
      case 180:
        return InputImageRotation.rotation180deg;
      case 270:
        return InputImageRotation.rotation270deg;
      default:
        return InputImageRotation.rotation0deg;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _faceDetector.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_controller.value.isInitialized) {
      return Container();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.description), // Use description here
      ),
      body: CameraPreview(_controller),
    );
  }
}
