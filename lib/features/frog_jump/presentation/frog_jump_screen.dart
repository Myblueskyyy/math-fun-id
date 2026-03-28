import 'package:flutter/material.dart';
import 'package:flame/game.dart';
import '../frog_jump_game.dart';
import '../../platformer/domain/question.dart';

class FrogJumpScreen extends StatefulWidget {
  const FrogJumpScreen({Key? key}) : super(key: key);

  @override
  _FrogJumpScreenState createState() => _FrogJumpScreenState();
}

class _FrogJumpScreenState extends State<FrogJumpScreen> {
  late FrogJumpGame game;
  int currentQuestionIndex = 0;
  bool showDiscussion = false;
  int lives = 3;
  int score = 0;
  bool isGameOver = false;

  final List<MathQuestion> questions = [
    MathQuestion(
      question: "Pak Budi menjual barang seharga Rp 220.000 dan untung 10%. Berapa harga belinya?",
      options: ["Rp 190.000", "Rp 200.000", "Rp 210.000"],
      correctIndex: 1,
      pembahasan: "Harga Beli = 220.000 / (1 + 0.1) = 220.000 / 1.1 = Rp 200.000.",
    ),
    MathQuestion(
      question: "Diskon 20% untuk sepatu seharga Rp 300.000. Berapa yang harus dibayar?",
      options: ["Rp 240.000", "Rp 250.000", "Rp 260.000"],
      correctIndex: 0,
      pembahasan: "Diskon = 0.2 x 300.000 = 60.000. Bayar = 300.000 - 60.000 = Rp 240.000.",
    ),
    MathQuestion(
      question: "Bunga 5% per tahun. Tabungan Rp 1.000.000. Bunga setelah 1 tahun?",
      options: ["Rp 40.000", "Rp 45.000", "Rp 50.000"],
      correctIndex: 2,
      pembahasan: "Bunga = 5% x 1.000.000 = Rp 50.000.",
    ),
    MathQuestion(
      question: "Bruto 50kg, tara 2%. Netto adalah...",
      options: ["48kg", "49kg", "49.5kg"],
      correctIndex: 1,
      pembahasan: "Tara = 2% x 50kg = 1kg. Netto = 50kg - 1kg = 49kg.",
    ),
  ];

  @override
  void initState() {
    super.initState();
    _initGame();
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
    // Initialize first question options
    WidgetsBinding.instance.addPostFrameCallback((_) {
      game.updateOptions(questions[currentQuestionIndex].options);
    });
  }

  void _handleAnswer(int index) {
    bool isCorrect = index == questions[currentQuestionIndex].correctIndex;
    
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
      } else {
        _showGameOver(isWin: true);
      }
    });
  }

  void _showGameOver({bool isWin = false}) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: Text(isWin ? 'Luar Biasa!' : 'Yah, Selesai!'),
        content: Text('Skor Akhir: $score / 100'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Close dialog
              Navigator.pop(context); // Back to Home
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
              });
              game.resetFrog();
              game.updateOptions(questions[currentQuestionIndex].options);
            },
            child: const Text('Ulangi'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GameWidget(game: game),
          
          // TOP PROGRESS BAR
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
                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12),
              ),
            ),
          ),

          // CLEAN QUESTION BOX
          Positioned(
            top: 50,
            left: 20,
            right: 20,
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 10)],
                border: Border.all(color: Colors.green, width: 3),
              ),
              child: Text(
                questions[currentQuestionIndex].question,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87),
              ),
            ),
          ),

          // BOTTOM HUD (Timer & Controls)
          Positioned(
            bottom: 20,
            left: 20,
            right: 20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Timer Mockup
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.green, width: 2),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.timer, color: Colors.green),
                      const SizedBox(width: 8),
                      const Text("00:45", style: TextStyle(fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
                // Score & Settings
                Row(
                  children: [
                    _hudCircleButton(Icons.tune),
                    const SizedBox(width: 8),
                    _hudCircleButton(Icons.fullscreen),
                  ],
                ),
              ],
            ),
          ),

          // Discussion Overlay
          if (showDiscussion)
            Container(
              color: Colors.black54,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Card(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.check_circle, color: Colors.green, size: 80),
                          const SizedBox(height: 16),
                          const Text(
                            "JAWABAN BENAR!",
                            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.green),
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
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                              padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 20),
                            ),
                            child: const Text("LANJUT", style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),

          // Back Button
          Positioned(
            top: 10,
            right: 10,
            child: IconButton(
              icon: const Icon(Icons.close, color: Colors.red, size: 30),
              onPressed: () => Navigator.pop(context),
            ),
          ),
        ],
      ),
    );
  }

  Widget _hudCircleButton(IconData icon) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        border: Border.all(color: Colors.green, width: 2),
      ),
      child: Icon(icon, color: Colors.green),
    );
  }
}
