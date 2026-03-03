import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/constants/app_colors.dart';
import '../../shared/widgets/custom_button.dart';
import '../../shared/widgets/custom_card.dart';
import 'quiz_provider.dart';

class ResultScreen extends StatelessWidget {
  final String title;

  const ResultScreen({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Consumer<QuizProvider>(
      builder: (context, provider, child) {
        final scorePercentage =
            (provider.score / provider.questions.length) * 100;
        final isDark = Theme.of(context).brightness == Brightness.dark;

        return Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          appBar: AppBar(
            title: const Text('Hasil Akhir'),
            automaticallyImplyLeading: false,
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              children: [
                _buildHeader(
                  context,
                  provider.score,
                  provider.questions.length,
                  scorePercentage,
                ),
                const SizedBox(height: 32),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Pembahasan Soal',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: isDark ? Colors.white : Colors.black,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                ...List.generate(
                  provider.questions.length,
                  (index) => _buildDiscussionCard(context, provider, index),
                ),
                const SizedBox(height: 32),
                CustomButton(
                  label: 'Kembali ke Menu Utama',
                  onPressed: () {
                    provider.reset();
                    Navigator.popUntil(context, (route) => route.isFirst);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildHeader(
    BuildContext context,
    int score,
    int total,
    double percentage,
  ) {
    return CustomCard(
      color: AppColors.primary,
      child: Column(
        children: [
          const Icon(Icons.stars_rounded, color: Colors.white, size: 60),
          const SizedBox(height: 16),
          const Text(
            'Skor Kamu',
            style: TextStyle(color: Colors.white70, fontSize: 16),
          ),
          Text(
            score.toString(),
            style: const TextStyle(
              color: Colors.white,
              fontSize: 64,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            'Dari $total Soal',
            style: const TextStyle(color: Colors.white70, fontSize: 16),
          ),
          const SizedBox(height: 8),
          Text(
            '${percentage.toInt()}% Benar',
            style: const TextStyle(
              color: AppColors.accent,
              fontSize: 20,
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
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: CustomCard(
        padding: 16,
        color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: isCorrect
                      ? AppColors.success
                      : AppColors.error,
                  radius: 14,
                  child: Icon(
                    isCorrect ? Icons.check : Icons.close,
                    color: Colors.white,
                    size: 16,
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  'Soal ${index + 1}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: isDark ? Colors.white : Colors.black,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              question.text,
              style: TextStyle(color: isDark ? Colors.white70 : Colors.black87),
            ),
            Divider(height: 24, color: isDark ? Colors.white10 : null),
            Text(
              'Jawaban Kamu:',
              style: TextStyle(
                fontSize: 12,
                color: isDark ? Colors.white38 : AppColors.textSecondary,
              ),
            ),
            Text(
              userAnswer != null
                  ? question.options[userAnswer]
                  : 'Tidak dijawab',
              style: TextStyle(
                color: isCorrect ? AppColors.success : AppColors.error,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Jawaban Benar:',
              style: TextStyle(
                fontSize: 12,
                color: isDark ? Colors.white38 : AppColors.textSecondary,
              ),
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
                color: isDark ? Colors.black26 : Colors.grey.shade50,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Pembahasan:',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: isDark ? Colors.white : Colors.black,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    question.explanation,
                    style: TextStyle(
                      fontSize: 14,
                      fontStyle: FontStyle.italic,
                      color: isDark ? Colors.white70 : Colors.black87,
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
