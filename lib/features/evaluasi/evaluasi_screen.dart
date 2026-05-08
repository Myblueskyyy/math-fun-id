import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/constants/app_colors.dart';
import '../../core/widgets/bubbly_background.dart';
import '../../shared/widgets/custom_card.dart';
import '../quiz/quiz_provider.dart';
import '../../core/utils/audio_controller.dart';

class EvaluasiScreen extends StatefulWidget {
  const EvaluasiScreen({super.key});

  @override
  State<EvaluasiScreen> createState() => _EvaluasiScreenState();
}

class _EvaluasiScreenState extends State<EvaluasiScreen> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: const Text(
          'Dasbor Evaluasi',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh_rounded),
            tooltip: 'Reset Data',
            onPressed: () => _showResetDialog(context),
          )
        ],
      ),
      body: BubblyBackground(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Consumer<QuizProvider>(
              builder: (context, provider, child) {
                final isCompleted = provider.isAllTestsCompleted;

                return SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      // Header Card
                      CustomCard(
                        padding: 24,
                        color: isCompleted ? Colors.green : Colors.orange,
                        child: Column(
                          children: [
                            Icon(
                              isCompleted ? Icons.emoji_events_rounded : Icons.pending_actions_rounded, 
                              size: 60, 
                              color: Colors.white
                            ),
                            const SizedBox(height: 16),
                            Text(
                              isCompleted ? "Luar Biasa!" : "Belum Selesai",
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              isCompleted 
                                ? "Kamu telah menyelesaikan semua tes dan evaluasi. Berikut adalah ringkasan hasil belajarmu!"
                                : "Kamu belum menyelesaikan semua tes. Silakan selesaikan setiap tes di semua Pertemuan untuk melihat hasil akhir.",
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),
                      
                      // Progress List
                      _buildTestStatusRow(context, provider, 'Pertemuan 1: Pre-Test', QuizType.preTest),
                      _buildTestStatusRow(context, provider, 'Pertemuan 1: Diskusi', QuizType.diskusi1),
                      _buildTestStatusRow(context, provider, 'Pertemuan 1: Post-Test', QuizType.postTest1),
                      _buildTestStatusRow(context, provider, 'Pertemuan 2: Diskusi', QuizType.diskusi2),
                      _buildTestStatusRow(context, provider, 'Pertemuan 2: Post-Test', QuizType.postTest2),
                      _buildTestStatusRow(context, provider, 'Pertemuan 3: Diskusi', QuizType.diskusi3),
                      _buildTestStatusRow(context, provider, 'Pertemuan 3: Post-Test', QuizType.postTest3),

                      const SizedBox(height: 32),

                      if (isCompleted) ...[
                        const Text(
                          'Ringkasan Nilai Akhir',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            Expanded(
                              child: _buildFinalScoreCard(
                                title: "Total Benar",
                                value: _calculateTotalScore(provider).toString(),
                                color: Colors.blue,
                                icon: Icons.check_circle_rounded,
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: _buildFinalScoreCard(
                                title: "Akurasi",
                                value: "${_calculateAccuracy(provider)}%",
                                color: Colors.purple,
                                icon: Icons.percent_rounded,
                              ),
                            ),
                          ],
                        ),
                      ]
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  void _showResetDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Reset Progres?'),
        content: const Text('Apakah kamu yakin ingin mereset semua data progres belajar dan nilai evaluasi? Data yang dihapus tidak dapat dikembalikan.'),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Batal'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () {
              context.read<QuizProvider>().resetAllData();
              Navigator.pop(ctx);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Progres berhasil direset!')),
              );
            },
            child: const Text('Ya, Reset', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  int _calculateTotalScore(QuizProvider provider) {
    int total = 0;
    for (var score in provider.scores.values) {
      total += score;
    }
    return total;
  }

  int _calculateTotalQuestions(QuizProvider provider) {
    int total = 0;
    for (var t in provider.totals.values) {
      total += t;
    }
    return total;
  }

  int _calculateAccuracy(QuizProvider provider) {
    int score = _calculateTotalScore(provider);
    int total = _calculateTotalQuestions(provider);
    if (total == 0) return 0;
    return ((score / total) * 100).round();
  }

  Widget _buildTestStatusRow(BuildContext context, QuizProvider provider, String title, QuizType type) {
    final hasScore = provider.scores.containsKey(type);
    final score = provider.scores[type];
    final total = provider.totals[type];

    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: CustomCard(
        color: Colors.white,
        padding: 16,
        child: Row(
          children: [
            Icon(
              hasScore ? Icons.check_circle_rounded : Icons.radio_button_unchecked_rounded,
              color: hasScore ? Colors.green : Colors.grey,
              size: 28,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
            ),
            if (hasScore)
              Text(
                '$score / $total',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
              )
            else
              const Text(
                '-',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              )
          ],
        ),
      ),
    );
  }

  Widget _buildFinalScoreCard({
    required String title,
    required String value,
    required Color color,
    required IconData icon,
  }) {
    return CustomCard(
      padding: 16,
      color: Colors.white,
      child: Column(
        children: [
          Icon(icon, size: 36, color: color),
          const SizedBox(height: 12),
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Colors.black54,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}
