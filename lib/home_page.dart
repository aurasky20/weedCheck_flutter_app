import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'camera_page.dart';
import 'gallery_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  Future<void> _requestPermissions() async {
    await [
      Permission.camera,
      Permission.storage,
    ].request();
  }

  @override
  Widget build(BuildContext context) {
    // Meminta izin saat halaman pertama kali dibuka
    _requestPermissions();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Deteksi Gulma'),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const Icon(Icons.eco, size: 100, color: Colors.green),
              const SizedBox(height: 40),
              ElevatedButton.icon(
                icon: const Icon(Icons.camera),
                label: const Text('Deteksi Real-time'),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const CameraPage()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  textStyle: const TextStyle(fontSize: 18),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                icon: const Icon(Icons.camera_alt),
                label: const Text('Ambil Gambar dari Kamera'),
                onPressed: () {
                   // Langsung ke halaman gallery page yang akan membuka kamera
                   Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => GalleryPage(source: ImageSource.camera)),
                  );
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  textStyle: const TextStyle(fontSize: 18),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                icon: const Icon(Icons.photo_library),
                label: const Text('Pilih Gambar dari Galeri'),
                onPressed: () {
                  // Langsung ke halaman gallery page yang akan membuka galeri
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => GalleryPage(source: ImageSource.gallery)),
                  );
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  textStyle: const TextStyle(fontSize: 18),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Enum untuk membedakan sumber gambar
enum ImageSource { camera, gallery }