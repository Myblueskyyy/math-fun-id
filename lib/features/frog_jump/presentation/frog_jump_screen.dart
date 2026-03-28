import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flame/game.dart';
import '../frog_jump_game.dart';
import '../../platformer/domain/question.dart';

class FrogJumpScreen extends StatefulWidget {
  const FrogJumpScreen({super.key});

  @override
  State<FrogJumpScreen> createState() => _FrogJumpScreenState();
}

class _FrogJumpScreenState extends State<FrogJumpScreen> {
  late FrogJumpGame game;
  int currentQuestionIndex = 0;
  int score = 0;
  int lives = 3;
  bool showDiscussion = false;
  bool isIntro = true;
  int countdownValue = 0;
  Timer? gameTimer;
  int secondsRemaining = 180; // 3 minutes per question

  final List<MathQuestion> questions = [
    MathQuestion(
      question:
          "Pak Budi menjual barang seharga Rp 220.000 dan untung 10%. Berapa harga belinya?",
      options: ["Rp 200.000", "Rp 180.000", "Rp 210.000"],
      correctIndex: 0,
      pembahasan:
          "Harga Beli = Harga Jual / (1 + %Untung)\nHarga Beli = 220.000 / 1.1 = Rp 200.000.",
    ),
    MathQuestion(
      question:
          "Diskon 20% untuk sepatu seharga Rp 300.000. Berapa yang harus dibayar?",
      options: ["Rp 240.000", "Rp 250.000", "Rp 260.000"],
      correctIndex: 0,
      pembahasan:
          "Diskon = 20% x 300.000 = Rp 60.000.\nHarga Bayar = 300.000 - 60.000 = Rp 240.000.",
    ),
    MathQuestion(
      question:
          "Tabungan Rp 1.000.000 dengan bunga 6% per tahun. Bunga setelah 1 tahun?",
      options: ["Rp 60.000", "Rp 50.000", "Rp 70.000"],
      correctIndex: 0,
      pembahasan: "Bunga = 6% x 1.000.000 = Rp 60.000.",
    ),
    MathQuestion(
      question:
          "Beli 10kg mangga Rp 150.000, dijual Rp 18.000/kg. Untung pedagang?",
      options: ["Rp 30.000", "Rp 20.000", "Rp 40.000"],
      correctIndex: 0,
      pembahasan:
          "Harga Jual = 10 x 18.000 = 180.000.\nUntung = 180.000 - 150.000 = Rp 30.000.",
    ),
  ];

  @override
  void initState() {
    super.initState();
    _initGame();
  }

  @override
  void dispose() {
    gameTimer?.cancel();
    super.dispose();
  }

  void _initGame() {
    game = FrogJumpGame(
      onLilyPadSelected: (index) {
        _handleAnswer(index);
      },
      onReset: () {
        setState(() {
          showDiscussion = false;
        });
      },
    );
  }

  void _startCountdown() {
    setState(() {
      isIntro = false;
      countdownValue = 3;
    });

    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) return;
      setState(() {
        if (countdownValue > 1) {
          countdownValue--;
        } else if (countdownValue == 1) {
          countdownValue = -1; // Special value for "GO!"
        } else {
          timer.cancel();
          countdownValue = 0;
          _startTimer();
          game.updateOptions(questions[currentQuestionIndex].options);
        }
      });
    });
  }

  void _startTimer() {
    gameTimer?.cancel();
    secondsRemaining = 180;
    gameTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) return;
      if (secondsRemaining > 0) {
        setState(() {
          secondsRemaining--;
        });
      } else {
        _handleTimeUp();
      }
    });
  }

  void _handleTimeUp() {
    gameTimer?.cancel();
    setState(() {
      lives--;
    });

    if (lives <= 0) {
      _showGameOver();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Waktu Habis! Nyawa berkurang."),
          backgroundColor: Colors.orange,
        ),
      );
      _nextQuestion();
    }
  }

  void _handleAnswer(int index) {
    bool isCorrect = index == questions[currentQuestionIndex].correctIndex;

    gameTimer?.cancel();

    game.jumpToLilyPad(index, isCorrect, () {
      if (isCorrect) {
        setState(() {
          score += 25;
          showDiscussion = true;
        });
      } else {
        setState(() {
          lives--;
        });
        if (lives <= 0) {
          _showGameOver();
        } else {
          game.resetFrog();
          _startTimer();
        }
      }
    });
  }

  void _nextQuestion() {
    setState(() {
      if (currentQuestionIndex < questions.length - 1) {
        currentQuestionIndex++;
        showDiscussion = false;
        game.resetFrog();
        game.updateOptions(questions[currentQuestionIndex].options);
        _startTimer();
      } else {
        _showGameOver(isWin: true);
      }
    });
  }

  void _showGameOver({bool isWin = false}) {
    gameTimer?.cancel();
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: Text(isWin ? 'Luar Biasa!' : 'Yah, Selesai!'),
        content: Text('Skor Akhir: $score / 100'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
            child: const Text('Menu Utama'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              setState(() {
                lives = 3;
                score = 0;
                currentQuestionIndex = 0;
                showDiscussion = false;
                isIntro = true;
              });
              game.resetFrog();
            },
            child: const Text('Ulangi'),
          ),
        ],
      ),
    );
  }

  String _formatTime(int seconds) {
    int m = seconds ~/ 60;
    int s = seconds % 60;
    return '${m.toString().padLeft(2, '0')}:${s.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GameWidget(game: game),

          // HUD: Lives & Score (Relocated to bottom corners)
          if (!isIntro && countdownValue == 0) ...[
            // HEARTS (Bottom-Left)
            Positioned(
              bottom: 20,
              left: 20,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: List.generate(
                    3,
                    (index) => Icon(
                      index < lives ? Icons.favorite : Icons.favorite_border,
                      color: Colors.red,
                      size: 28,
                    ),
                  ),
                ),
              ),
            ),
            // SCORE (Bottom-Right)
            Positioned(
              bottom: 20,
              right: 20,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
            ),
          ],

          if (!isIntro && countdownValue == 0 && !showDiscussion) ...[
            // PROGRESS BAR (Top-Left)
            Positioned(
              top: 10,
              left: 10,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.green.withOpacity(0.8),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.white, width: 2),
                ),
                child: Text(
                  'Pertanyaan: ${currentQuestionIndex + 1} / ${questions.length}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
            ),

            // TIMER (Top-Right, next to Close)
            Positioned(
              top: 10,
              right: 60,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.8),
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(
                    color: secondsRemaining < 30 ? Colors.red : Colors.green,
                    width: 2,
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.timer,
                      size: 18,
                      color: secondsRemaining < 30 ? Colors.red : Colors.green,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      _formatTime(secondsRemaining),
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: secondsRemaining < 30 ? Colors.red : Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // QUESTION BOX (Tucked at Top)
            Positioned(
              top: 60,
              left: 20,
              right: 20,
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: const [
                    BoxShadow(color: Colors.black26, blurRadius: 10),
                  ],
                  border: Border.all(color: Colors.green, width: 3),
                ),
                child: Text(
                  questions[currentQuestionIndex].question,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ),
            ),
          ],

          // INTRO PANEL
          if (isIntro)
            Container(
              color: Colors.black.withOpacity(0.85),
              child: Center(
                child: Card(
                  margin: const EdgeInsets.symmetric(horizontal: 40),
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(32),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                          "Misi Frog Jump:",
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          "Bantu katak melompat ke lilypad dengan jawaban yang benar!\n\n✨ Jawab cepat untuk skor tinggi!\n⚠️ Setiap pertanyaan diberi waktu 3 menit.\n⚠️ Jika waktu habis, nyawa berkurang.",
                          style: TextStyle(fontSize: 18, color: Colors.black87),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 30),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 40,
                              vertical: 16,
                            ),
                            backgroundColor:
                                Colors.amber, // Sync with Platformer
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            elevation: 8,
                          ),
                          onPressed: _startCountdown,
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

          // COUNTDOWN ANIMATION (Dynamic Pop)
          if (countdownValue != 0)
            Container(
              color: Colors.black.withOpacity(0.4),
              child: Center(
                child: TweenAnimationBuilder<double>(
                  key: ValueKey(countdownValue),
                  tween: Tween(begin: 1.5, end: 1.0),
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.elasticOut,
                  builder: (context, value, child) {
                    return Transform.scale(
                      scale: value,
                      child: Text(
                        countdownValue == -1 ? "GO!" : "$countdownValue",
                        style: TextStyle(
                          fontSize: 140,
                          fontWeight: FontWeight.bold,
                          color: countdownValue == -1
                              ? Colors.greenAccent
                              : Colors.white,
                          fontStyle: FontStyle.italic,
                          shadows: [
                            Shadow(
                              color: Colors.black.withOpacity(0.5),
                              blurRadius: 30,
                              offset: const Offset(5, 5),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),

          if (showDiscussion)
            Container(
              color: Colors.black54,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.check_circle,
                            color: Colors.green,
                            size: 80,
                          ),
                          const SizedBox(height: 16),
                          const Text(
                            "JAWABAN BENAR!",
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: Colors.green,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            questions[currentQuestionIndex].pembahasan,
                            textAlign: TextAlign.center,
                            style: const TextStyle(fontSize: 18),
                          ),
                          const SizedBox(height: 32),
                          ElevatedButton(
                            onPressed: _nextQuestion,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 60,
                                vertical: 20,
                              ),
                            ),
                            child: const Text(
                              "LANJUT",
                              style: TextStyle(
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
                ),
              ),
            ),
        ],
      ),
    );
  }
}
