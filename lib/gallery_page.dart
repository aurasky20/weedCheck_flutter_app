import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:weed_detection_app/detection_result.dart';
import 'dart:io';
import 'home_page.dart' as home; // Menggunakan alias untuk ImageSource

class GalleryPage extends StatefulWidget {
  final home.ImageSource source;
  const GalleryPage({super.key, required this.source});

  @override
  State<GalleryPage> createState() => _GalleryPageState();
}

class _GalleryPageState extends State<GalleryPage> {
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    // Gunakan addPostFrameCallback agar picker terbuka setelah build selesai
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _pickImage();
    });
  }

  Future<void> _pickImage() async {
    try {
      final XFile? image = await _picker.pickImage(
        source: widget.source == home.ImageSource.gallery ? ImageSource.gallery : ImageSource.camera,
      );

      if (image != null) {
        // Jika gambar berhasil dipilih, navigasi ke halaman hasil
        if (mounted) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => DetectionResultPage(imageFile: File(image.path)),
            ),
          );
        }
      } else {
        // Jika pengguna batal memilih, kembali ke halaman sebelumnya
        if (mounted) {
          Navigator.pop(context);
        }
      }
    } catch (e) {
      // Handle error jika terjadi
      print("Error picking image: $e");
      if (mounted) {
        Navigator.pop(context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // Tampilkan loading indicator saat picker sedang aktif
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}