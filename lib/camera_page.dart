import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class CameraPage extends StatefulWidget {
  const CameraPage({super.key});

  @override
  State<CameraPage> createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  CameraController? _cameraController;
  late List<CameraDescription> _cameras;
  bool _isCameraInitialized = false;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    _cameras = await availableCameras();
    _cameraController = CameraController(_cameras[0], ResolutionPreset.high);
    await _cameraController!.initialize();

    // TODO: [Implementasi TFLite]
    // 1. Muat model TFLite Anda dari assets di sini.
    // 2. Mulai image stream untuk memproses frame secara real-time.
    // _cameraController!.startImageStream((image) {
    //    // Panggil fungsi deteksi Anda di sini
    //    // runModelOnFrame(image);
    // });
    
    if (mounted) {
      setState(() {
        _isCameraInitialized = true;
      });
    }
  }

  @override
  void dispose() {
    _cameraController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_isCameraInitialized) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Deteksi Real-time')),
      body: Stack(
        fit: StackFit.expand,
        children: [
          CameraPreview(_cameraController!),
          // TODO: [Tampilan Bounding Box]
          // Widget untuk menggambar bounding box akan ditempatkan di sini.
          // Anda bisa menggunakan CustomPaint untuk menggambar kotak dan label
          // berdasarkan hasil dari model TFLite.
          // Contoh:
          // CustomPaint(
          //   painter: BoundingBoxPainter(results),
          // ),
        ],
      ),
    );
  }
}