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
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = context.read<QuizProvider>();
      final preTestScore = provider.preTestScore;
      final postTestScore = provider.postTestScore;

      if (preTestScore != null && postTestScore != null) {
        if (postTestScore > preTestScore) {
          AudioController.instance.playSfx('stage_win.mp3');
        } else if (postTestScore < preTestScore) {
          AudioController.instance.playSfx('stage_lose.mp3');
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: const Text(
          'Hasil Evaluasi',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: BubblyBackground(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Consumer<QuizProvider>(
              builder: (context, provider, child) {
                final preTestScore = provider.preTestScore;
                final postTestScore = provider.postTestScore;

                if (preTestScore == null || postTestScore == null) {
                  return Center(
                    child: CustomCard(
                      padding: 24,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.info_outline_rounded,
                            size: 64,
                            color: AppColors.primary,
                          ),
                          const SizedBox(height: 16),
                          const Text(
                            'Hasil Belum Tersedia',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: AppColors.primary,
                            ),
                          ),
                          const SizedBox(height: 12),
                          const Text(
                            'Selesaikan Pre-Test dan Post-Test terlebih dahulu untuk melihat ringkasan evaluasi hasil belajarmu.',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                  );
                }

                String summaryTitle = "";
                String summaryDesc = "";
                Color summaryColor = AppColors.primary;
                IconData summaryIcon = Icons.emoji_events_rounded;

                if (postTestScore > preTestScore) {
                  summaryTitle = "Luar Biasa!";
                  summaryDesc =
                      "Kamu mengalami peningkatan yang hebat setelah belajar materi.";
                  summaryColor = Colors.green;
                  summaryIcon = Icons.trending_up_rounded;
                } else if (postTestScore < preTestScore) {
                  summaryTitle = "Jangan Menyerah!";
                  summaryDesc =
                      "Nilai post-test mu menurun. Ayo pelajari kembali materinya berlatih lagi!";
                  summaryColor = Colors.orange;
                  summaryIcon = Icons.trending_down_rounded;
                } else {
                  if (postTestScore == provider.postTestTotal &&
                      postTestScore > 0) {
                    summaryTitle = "Sempurna!";
                    summaryDesc =
                        "Kamu berhasil mempertahankan nilai sempurna. Pertahankan prestasimu!";
                    summaryColor = Colors.blue;
                    summaryIcon = Icons.star_rounded;
                  } else {
                    summaryTitle = "Tetap Semangat!";
                    summaryDesc =
                        "Nilaimu masih sama dengan sebelumnya. Mari belajar lebih giat lagi.";
                    summaryColor = Colors.blueGrey;
                    summaryIcon = Icons.trending_flat_rounded;
                  }
                }

                return SingleChildScrollView(
                  child: Column(
                    children: [
                      CustomCard(
                        padding: 24,
                        color: summaryColor,
                        child: Column(
                          children: [
                            Icon(summaryIcon, size: 60, color: Colors.white),
                            const SizedBox(height: 16),
                            Text(
                              summaryTitle,
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              summaryDesc,
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
                      Row(
                        children: [
                          Expanded(
                            child: _buildScoreCard(
                              context: context,
                              title: "Pre-Test",
                              score: preTestScore,
                              total: provider.preTestTotal,
                              icon: Icons.assignment_rounded,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: _buildScoreCard(
                              context: context,
                              title: "Post-Test",
                              score: postTestScore,
                              total: provider.postTestTotal,
                              icon: Icons.assignment_turned_in_rounded,
                            ),
                          ),
                        ],
                      ),
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

  Widget _buildScoreCard({
    required BuildContext context,
    required String title,
    required int score,
    required int total,
    required IconData icon,
  }) {
    return CustomCard(
      padding: 16,
      color: Colors.white,
      child: Column(
        children: [
          Icon(icon, size: 36, color: AppColors.primary),
          const SizedBox(height: 12),
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '$score / $total',
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: AppColors.primary,
            ),
          ),
          const Text(
            'Jawaban Benar',
            style: TextStyle(fontSize: 12, color: Colors.black54),
          ),
        ],
      ),
    );
  }
}

