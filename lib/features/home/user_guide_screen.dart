import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import '../../core/widgets/bubbly_background.dart';
import '../../core/utils/audio_controller.dart';
import 'home_screen.dart';

class UserGuideScreen extends StatefulWidget {
  const UserGuideScreen({super.key});

  @override
  State<UserGuideScreen> createState() => _UserGuideScreenState();
}

class _UserGuideScreenState extends State<UserGuideScreen> with SingleTickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();
  bool _showScrollIndicator = true;
  late AnimationController _animationController;
  late Animation<double> _bounceAnimation;

  final String _guideText = '''
# Petunjuk Penggunaan

## PETUNJUK PENGGUNAAN APLIKASI
**Media Pembelajaran Matematika: Aritmatika Sosial**

Aplikasi ini dirancang untuk membantu siswa memahami konsep jual beli, untung rugi, diskon, dan pajak secara interaktif melalui materi, latihan, evaluasi, dan game edukasi.

### 1. Halaman Awal (Beranda)
* Saat membuka aplikasi, pengguna akan melihat menu utama.
* Pilih menu yang tersedia: Materi, Evaluasi dan Game Edukasi.

### 2. Materi Pembelajaran
Pada bagian ini materi dibagi menjadi beberapa Pertemuan:
* Pertemuan Pertama (Jual Beli & Untung Rugi)
* Pertemuan Kedua (Diskon)
* Pertemuan Ketiga (Pajak)

**Cara penggunaan:**
* Pilih pertemuan yang ingin dipelajari.
* Setiap pertemuan mungkin berisi Pre-Test, penjelasan materi, soal diskusi, dan Post-Test.
* Bacalah penjelasan yang tersedia dan perhatikan contoh soal.
* Ikuti juga cerita Visual Novel yang menarik!

### 3. Pre-Test & Post-Test
* Kerjakan semua soal ujian dengan jujur tanpa bantuan.
* Pre-Test menguji kemampuan awal, sedangkan Post-Test menguji pemahaman akhir materi.

### 4. Game Edukasi
* Game dirancang untuk memperkuat pemahaman konsep secara menyenangkan.
* Ikuti instruksi permainan yang tersedia.
''';

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat(reverse: true);
    
    _bounceAnimation = Tween<double>(begin: 0, end: 10).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    _scrollController.addListener(_scrollListener);
  }

  void _scrollListener() {
    if (_scrollController.offset > 50) {
      if (_showScrollIndicator) {
        setState(() {
          _showScrollIndicator = false;
        });
      }
    } else {
      if (!_showScrollIndicator) {
        setState(() {
          _showScrollIndicator = true;
        });
      }
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text('Panduan Penggunaan', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: BubblyBackground(
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: Stack(
                  children: [
                    Container(
                      margin: const EdgeInsets.all(16.0),
                      padding: const EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.9),
                        borderRadius: BorderRadius.circular(24),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.1),
                            blurRadius: 10,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: Scrollbar(
                        controller: _scrollController,
                        thumbVisibility: true,
                        child: Markdown(
                          controller: _scrollController,
                          data: _guideText,
                          styleSheet: MarkdownStyleSheet(
                            h1: const TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
                            h2: const TextStyle(color: Colors.orange, fontWeight: FontWeight.bold),
                            h3: const TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
                            p: const TextStyle(fontSize: 16, height: 1.5),
                            listBullet: const TextStyle(color: Colors.blue, fontSize: 18),
                          ),
                        ),
                      ),
                    ),
                    if (_showScrollIndicator)
                      Positioned(
                        bottom: 30,
                        left: 0,
                        right: 0,
                        child: AnimatedBuilder(
                          animation: _bounceAnimation,
                          builder: (context, child) {
                            return Transform.translate(
                              offset: Offset(0, _bounceAnimation.value),
                              child: Opacity(
                                opacity: 0.6,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Text(
                                      'Scroll ke bawah',
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    Icon(
                                      Icons.keyboard_double_arrow_down_rounded,
                                      color: Colors.blue.shade300,
                                      size: 30,
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 24.0, left: 16.0, right: 16.0),
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.amber,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    elevation: 5,
                  ),
                  onPressed: () {
                    AudioController.instance.playButtonClick();
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (_) => const HomeScreen(),
                      ),
                    );
                  },
                  icon: const Icon(Icons.play_arrow_rounded, size: 28),
                  label: const Text(
                    'Lanjutkan ke Beranda',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
