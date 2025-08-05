import 'dart:io';
import 'package:flutter/material.dart';

class DetectionResultPage extends StatefulWidget {
  final File imageFile;

  const DetectionResultPage({super.key, required this.imageFile});

  @override
  State<DetectionResultPage> createState() => _DetectionResultPageState();
}

class _DetectionResultPageState extends State<DetectionResultPage> {
  // TODO: [Variabel Hasil Deteksi]
  // Ganti data dummy ini dengan hasil dari model TFLite Anda.
  // Anda akan menjalankan model pada 'widget.imageFile' di initState()
  // lalu mengisi variabel-variabel ini.
  int _broadleafCount = 0;
  int _narrowleafCount = 0;
  int _sedgeCount = 0;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _runDetection();
  }

  Future<void> _runDetection() async {
    // Mensimulasikan proses deteksi
    setState(() {
      _isLoading = true;
    });
    
    // TODO: [Implementasi TFLite]
    // 1. Muat model TFLite Anda (jika belum).
    // 2. Proses 'widget.imageFile' menggunakan model.
    // 3. Hitung jumlah bounding box untuk setiap kelas.
    // 4. Update state dengan hasil yang sebenarnya.
    
    // Simulasi delay untuk proses deteksi
    await Future.delayed(const Duration(seconds: 2));

    // Data dummy sebagai placeholder
    setState(() {
      _broadleafCount = 5; // Hasil deteksi model
      _narrowleafCount = 3; // Hasil deteksi model
      _sedgeCount = 2; // Hasil deteksi model
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hasil Deteksi'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            // Tampilkan gambar yang dideteksi
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.file(widget.imageFile),
            ),
            const SizedBox(height: 24),
            const Text(
              'Ringkasan Deteksi',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            _isLoading
                ? const Center(child: CircularProgressIndicator())
                : Column(
                    children: [
                      _buildResultCard(
                        title: 'Gulma Daun Lebar',
                        count: _broadleafCount,
                        color: Colors.blue.shade700,
                        icon: Icons.grass,
                      ),
                      const SizedBox(height: 12),
                      _buildResultCard(
                        title: 'Gulma Daun Sempit',
                        count: _narrowleafCount,
                        color: Colors.orange.shade700,
                        icon: Icons.energy_savings_leaf,
                      ),
                      const SizedBox(height: 12),
                      _buildResultCard(
                        title: 'Teki-tekian',
                        count: _sedgeCount,
                        color: Colors.purple.shade700,
                        icon: Icons.compost,
                      ),
                    ],
                  ),
          ],
        ),
      ),
    );
  }

  Widget _buildResultCard({required String title, required int count, required Color color, required IconData icon}) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Icon(icon, size: 40, color: color),
            const SizedBox(width: 20),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
            ),
            Text(
              '$count',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: color),
            )
          ],
        ),
      ),
    );
  }
}