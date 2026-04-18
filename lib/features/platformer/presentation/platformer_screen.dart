import 'package:flutter/material.dart';
import 'package:flame/game.dart';
import '../platformer_game.dart';
import '../domain/question.dart';
import '../../../core/utils/audio_controller.dart';

class PlatformerScreen extends StatefulWidget {
  const PlatformerScreen({Key? key}) : super(key: key);

  @override
  _PlatformerScreenState createState() => _PlatformerScreenState();
}

class _PlatformerScreenState extends State<PlatformerScreen> {
  late PlatformerGame game;
  int? activeQuestionIndex;

  bool isIntro = true;
  bool showDiscussion = false;
  int lives = 3;
  int score = 0;
  Set<int> answeredCorrectlyIndices = {};

  final List<MathQuestion> questions = [
    MathQuestion(
      question:
          "Pak Budi membeli sepatu seharga Rp 200.000 dengan diskon 15%. Berapa yang harus dibayar?",
      options: ["Rp 150.000", "Rp 170.000", "Rp 185.000", "Rp 195.000"],
      correctIndex: 1,
      pembahasan:
          "Diskon = 15% x Rp 200.000 = Rp 30.000.\nHarga Bayar = Rp 200.000 - Rp 30.000 = Rp 170.000.",
    ),
    MathQuestion(
      question:
          "Siti menabung Rp 500.000 dengan bunga 8% per tahun. Total tabungan setelah 1 tahun adalah?",
      options: ["Rp 540.000", "Rp 508.000", "Rp 550.000", "Rp 580.000"],
      correctIndex: 0,
      pembahasan:
          "Bunga = 8% x Rp 500.000 = Rp 40.000.\nTotal = Rp 500.000 + Rp 40.000 = Rp 540.000.",
    ),
    MathQuestion(
      question:
          "Pedagang membeli beras 50kg dengan harga Rp 500.000, lalu dijual kembali Rp 12.000 per kg. Pedagang mengalami?",
      options: [
        "Rugi Rp 100.000",
        "Untung Rp 100.000",
        "Untung Rp 200.000",
        "Rugi Rp 50.000",
      ],
      correctIndex: 1,
      pembahasan:
          "Harga Jual = 50 x Rp 12.000 = Rp 600.000.\nUntung = Rp 600.000 - Rp 500.000 = Rp 100.000.",
    ),
    MathQuestion(
      question:
          "Sebuah baju dijual dengan harga Rp 120.000 dan pedagang mendapatkan untung 20%. Berapa harga belinya?",
      options: ["Rp 90.000", "Rp 100.000", "Rp 110.000", "Rp 115.000"],
      correctIndex: 1,
      pembahasan:
          "Harga Beli = Harga Jual / (1 + %Untung)\nHarga Beli = 120.000 / 1.2 = Rp 100.000.",
    ),
  ];

  @override
  void initState() {
    super.initState();
    AudioController.instance.playBgm('mario_bgm.mp3');
    _initGame();
  }

  @override
  void dispose() {
    // Restore main BGM after navigation completes to avoid race conditions
    WidgetsBinding.instance.addPostFrameCallback((_) {
      AudioController.instance.ensureMainBgm();
    });
    super.dispose();
  }

  void _initGame() {
    game = PlatformerGame(
      onQuestionTriggered: (index) {
        setState(() {
          activeQuestionIndex = index;
          showDiscussion = false;
        });
      },
      onGameCompleted: () {
        _showEndDialog(isWin: true);
      },
    );
  }

  void _showEndDialog({required bool isWin}) {
    AudioController.instance.playSfx(isWin ? 'stage_win.mp3' : 'stage_lose.mp3');
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: Text(isWin ? 'Luar Biasa!' : 'Yah, Nyawa Habis!'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              isWin
                  ? 'Kamu berhasil menyelesaikan tantangan!'
                  : 'Jangan menyerah, coba lagi untuk mengasah kemampuanmu.',
            ),
            const SizedBox(height: 20),
            Text(
              'Skor Akhir: $score / 100',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              AudioController.instance.playButtonClick();
              Navigator.pop(context); // Close dialog
              Navigator.pop(context); // Back to previous menu
            },
            child: const Text('Menu Utama'),
          ),
          ElevatedButton(
            onPressed: () {
              AudioController.instance.playButtonClick();
              Navigator.pop(context);
              _restartGame();
            },
            child: const Text('Ulangi'),
          ),
        ],
      ),
    );
  }

  void _restartGame() {
    setState(() {
      lives = 3;
      score = 0;
      answeredCorrectlyIndices.clear();
      activeQuestionIndex = null;
      showDiscussion = false;
      isIntro = true;
    });
    _initGame();
  }

  void _answerQuestion(int optionIndex) {
    if (activeQuestionIndex == null) return;

    if (optionIndex == questions[activeQuestionIndex!].correctIndex) {
      AudioController.instance.playSfx('correct_answer.mp3');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Jawaban Benar! (+25 Skor)'),
          backgroundColor: Colors.green,
          duration: Duration(seconds: 1),
        ),
      );
      setState(() {
        score += 25;
        answeredCorrectlyIndices.add(activeQuestionIndex!);
        showDiscussion = true;
      });
    } else {
      AudioController.instance.playSfx('wrong_answer.mp3');
      setState(() {
        lives--;
      });

      if (lives <= 0) {
        _showEndDialog(isWin: false);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Jawaban Salah! Nyawa berkurang. Sisa: $lives'),
            backgroundColor: Colors.red,
            duration: Duration(seconds: 1),
          ),
        );
      }
    }
  }

  void _continueGameAfterDiscussion() {
    setState(() {
      activeQuestionIndex = null;
      showDiscussion = false;
    });
    game.answerCorrectly();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GameWidget(game: game),

          // HUD: Lives & Score
          if (!isIntro)
            Positioned(
              top: 40,
              left: 0,
              right: 0,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    // Hearts
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        children: List.generate(
                          3,
                          (index) => Icon(
                            index < lives
                                ? Icons.favorite
                                : Icons.favorite_border,
                            color: Colors.red,
                            size: 28,
                          ),
                        ),
                      ),
                    ),
                    // Score
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        'Skor: $score',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

          if (!isIntro && activeQuestionIndex == null) ...[
            // Tombol Kembali
            Positioned(
              top: 40,
              left: 20,
              child: FloatingActionButton(
                mini: true,
                backgroundColor: Colors.white.withOpacity(0.5),
                onPressed: () => Navigator.pop(context),
                child: const Icon(Icons.arrow_back, color: Colors.black),
              ),
            ),

            // Controller Kiri & Kanan
            Positioned(
              bottom: 40,
              left: 20,
              child: Row(
                children: [
                  GestureDetector(
                    onTapDown: (_) => game.moveLeft(),
                    onTapUp: (_) => game.stopMoving(),
                    onTapCancel: () => game.stopMoving(),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.5),
                        shape: BoxShape.circle,
                      ),
                      padding: const EdgeInsets.all(24),
                      child: const Icon(Icons.keyboard_arrow_left, size: 40),
                    ),
                  ),
                  const SizedBox(width: 20),
                  GestureDetector(
                    onTapDown: (_) => game.moveRight(),
                    onTapUp: (_) => game.stopMoving(),
                    onTapCancel: () => game.stopMoving(),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.5),
                        shape: BoxShape.circle,
                      ),
                      padding: const EdgeInsets.all(24),
                      child: const Icon(Icons.keyboard_arrow_right, size: 40),
                    ),
                  ),
                ],
              ),
            ),

            // Controller Lompat
            Positioned(
              bottom: 40,
              right: 20,
              child: GestureDetector(
                onTapDown: (_) => game.jump(),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.5),
                    shape: BoxShape.circle,
                  ),
                  padding: const EdgeInsets.all(24),
                  child: const Icon(Icons.arrow_upward, size: 40),
                ),
              ),
            ),
          ],

          // Panel Intro
          if (isIntro)
            Container(
              color: Colors.black.withOpacity(0.8),
              child: Center(
                child: Card(
                  margin: const EdgeInsets.symmetric(horizontal: 40),
                  child: Padding(
                    padding: const EdgeInsets.all(32),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                          "Misi Kamu:",
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          "Kumpulkan semua bintang yang melayang! ✨\nSetiap kamu mendapatkan bintang, ujian Aritmatika Sosial menantimu.\nJawablah dengan benar untuk terus melanjutkan tantangan.",
                          style: TextStyle(fontSize: 18),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 30),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 40,
                              vertical: 16,
                            ),
                            backgroundColor: Colors.amber,
                          ),
                          onPressed: () {
                            setState(() {
                              isIntro = false;
                            });
                            game.resumeEngine();
                          },
                          child: const Text(
                            'Mulai Bermain!',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),

          // Overlay Pertanyaan & Pembahasan
          if (activeQuestionIndex != null)
            Container(
              color: Colors.black.withOpacity(0.8),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(24),
                      child: showDiscussion
                          ? _buildDiscussionPanel()
                          : _buildQuestionPanel(),
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildQuestionPanel() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text(
          "Pertanyaan",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 20),
        Text(
          questions[activeQuestionIndex!].question,
          style: const TextStyle(fontSize: 18),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 30),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          alignment: WrapAlignment.center,
          children: List.generate(
            questions[activeQuestionIndex!].options.length,
            (idx) => ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
              ),
              onPressed: () {
                AudioController.instance.playButtonClick();
                _answerQuestion(idx);
              },
              child: Text(questions[activeQuestionIndex!].options[idx]),
            ),
          ),
        ),
        const SizedBox(height: 24),
        TextButton.icon(
          onPressed: () {
            AudioController.instance.playButtonClick();
            setState(() {
              showDiscussion = true;
            });
          },
          icon: const Icon(Icons.lightbulb, color: Colors.amber),
          label: const Text(
            "Lihat Jawaban & Pembahasan\n(Tidak mendapatkan poin)",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.amber,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDiscussionPanel() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text(
          "Pembahasan",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.green,
          ),
        ),
        const SizedBox(height: 20),
        Text(
          questions[activeQuestionIndex!].pembahasan,
          style: const TextStyle(fontSize: 18),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 30),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
            backgroundColor: Colors.amber,
          ),
          onPressed: () {
            AudioController.instance.playButtonClick();
            _continueGameAfterDiscussion();
          },
          child: const Text(
            'Lanjutkan Petualangan!',
            style: TextStyle(
              fontSize: 18,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
