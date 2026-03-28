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
          
          // HUD: Lives & Score
          Positioned(
            top: 40,
            left: 20,
            right: 20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.black45,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Row(
                    children: List.generate(
                      3,
                      (i) => Icon(
                        i < lives ? Icons.favorite : Icons.favorite_border,
                        color: Colors.red,
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.black45,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Text(
                    'Skor: $score',
                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),

          // Question Overlay
          if (!isGameOver)
            Positioned(
              top: 100,
              left: 20,
              right: 20,
              child: Card(
                elevation: 8,
                color: Colors.white.withOpacity(0.9),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Text(
                        "Pertanyaan ${currentQuestionIndex + 1}/${questions.length}",
                        style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.green),
                      ),
                      const Divider(),
                      Text(
                        questions[currentQuestionIndex].question,
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                ),
              ),
            ),

          // Discussion & Next Button Overlay
          if (showDiscussion)
            Container(
              color: Colors.black54,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.check_circle, color: Colors.green, size: 60),
                          const SizedBox(height: 16),
                          const Text(
                            "Benar!",
                            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            questions[currentQuestionIndex].pembahasan,
                            textAlign: TextAlign.center,
                            style: const TextStyle(fontSize: 16),
                          ),
                          const SizedBox(height: 24),
                          ElevatedButton(
                            onPressed: _nextQuestion,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green,
                              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                            ),
                            child: const Text("Lanjut", style: TextStyle(color: Colors.white)),
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
            top: 40,
            left: 20,
            child: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white, size: 30),
              onPressed: () => Navigator.pop(context),
            ),
          ),
        ],
      ),
    );
  }
}
