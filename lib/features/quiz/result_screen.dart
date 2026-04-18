import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/constants/app_colors.dart';
import '../../core/widgets/bubbly_background.dart';
import '../../core/widgets/bubbly_button.dart';
import '../../shared/widgets/custom_card.dart';
import 'quiz_provider.dart';
import '../../core/utils/audio_controller.dart';

class ResultScreen extends StatefulWidget {
  final String title;

  const ResultScreen({super.key, required this.title});

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = context.read<QuizProvider>();
      final totalQuestions = provider.questions.length;
      final correctAnswers = provider.correctAnswersCount;
      
      // Consider it a "win" if score is more than 60%
      if (totalQuestions > 0 && (correctAnswers / totalQuestions) >= 0.6) {
        AudioController.instance.playSfx('stage_win.mp3');
      } else {
        AudioController.instance.playSfx('stage_lose.mp3');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<QuizProvider>(
      builder: (context, provider, child) {
        final totalQuestions = provider.questions.length;
        final correctAnswers = provider.correctAnswersCount;

        return Scaffold(
          extendBodyBehindAppBar: true,
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            title: const Text('Hasil Akhir'),
            backgroundColor: Colors.transparent,
            elevation: 0,
            automaticallyImplyLeading: false,
          ),
          body: BubblyBackground(
            child: SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  children: [
                    _buildHeader(context, correctAnswers, totalQuestions),
                    const SizedBox(height: 32),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: const Text(
                        'Pembahasan Soal',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    // Only show discussion up to the index users reached.
                    ...List.generate(
                      provider.userAnswers.where((a) => a != null).length,
                      (index) => _buildDiscussionCard(context, provider, index),
                    ),
                    const SizedBox(height: 32),
                    BubblyButton(
                      title: 'Kembali ke Menu Utama',
                      icon: Icons.home_rounded,
                      mainColor: const Color(0xFF64B5F6),
                      shadowColor: const Color(0xFF1E88E5),
                      isFullWidth: true,
                      onTap: () {
                        provider.reset();
                        Navigator.popUntil(context, (route) => route.isFirst);
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildHeader(BuildContext context, int correctAnswers, int total) {
    Color cardColor = AppColors.primary;
    String statusTitle = 'SELESAI!';
    IconData iconData = Icons.emoji_events_rounded;

    return CustomCard(
      color: cardColor,
      child: Column(
        children: [
          Icon(iconData, color: Colors.white, size: 60),
          const SizedBox(height: 16),
          Text(
            statusTitle,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Benar $correctAnswers Dari $total Soal',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDiscussionCard(
    BuildContext context,
    QuizProvider provider,
    int index,
  ) {
    final question = provider.questions[index];
    final userAnswer = provider.userAnswers[index];
    final isCorrect = userAnswer == question.correctAnswerIndex;
    final isTimeout = userAnswer == -1;

    Color avatarColor = isCorrect
        ? AppColors.success
        : (isTimeout ? Colors.orange : AppColors.error);
    IconData avatarIcon = isCorrect
        ? Icons.check
        : (isTimeout ? Icons.timer_off : Icons.close);

    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: CustomCard(
        padding: 16,
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: avatarColor,
                  radius: 14,
                  child: Icon(avatarIcon, color: Colors.white, size: 16),
                ),
                const SizedBox(width: 12),
                Text(
                  'Soal ${index + 1}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(question.text, style: const TextStyle(color: Colors.black87)),
            const Divider(height: 24),
            Text(
              'Jawaban Kamu:',
              style: TextStyle(fontSize: 12, color: AppColors.textSecondary),
            ),
            Text(
              isTimeout
                  ? 'Habis Waktu'
                  : (userAnswer != null
                        ? question.options[userAnswer]
                        : 'Tidak dijawab'),
              style: TextStyle(color: avatarColor, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'Jawaban Benar:',
              style: TextStyle(fontSize: 12, color: AppColors.textSecondary),
            ),
            Text(
              question.options[question.correctAnswerIndex],
              style: const TextStyle(
                color: AppColors.success,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey.shade50,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Pembahasan:',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    question.explanation,
                    style: const TextStyle(
                      fontSize: 14,
                      fontStyle: FontStyle.italic,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

