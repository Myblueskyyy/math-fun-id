import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/constants/app_colors.dart';
import '../../core/widgets/bubbly_background.dart';
import '../../core/widgets/bubbly_button.dart';
import '../../shared/widgets/custom_card.dart';
import 'quiz_provider.dart';
import 'result_screen.dart';

class QuizScreen extends StatelessWidget {
  final String title;

  const QuizScreen({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Consumer<QuizProvider>(
      builder: (context, provider, child) {
        final question = provider.currentQuestion;

        final isDark = Theme.of(context).brightness == Brightness.dark;

        return Scaffold(
          extendBodyBehindAppBar: true,
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            title: Text(title),
            backgroundColor: Colors.transparent,
            elevation: 0,
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(4),
              child: LinearProgressIndicator(
                value: (provider.currentIndex + 1) / provider.questions.length,
                backgroundColor: AppColors.primary.withOpacity(0.1),
                valueColor: const AlwaysStoppedAnimation<Color>(
                  AppColors.primary,
                ),
              ),
            ),
          ),
          body: BubblyBackground(
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Pertanyaan ${provider.currentIndex + 1}/${provider.questions.length}',
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            CustomCard(
                              padding: 24,
                              color: isDark
                                  ? const Color(0xFF1E1E1E)
                                  : Colors.white,
                              child: Text(
                                question.text,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  height: 1.5,
                                  color: isDark
                                      ? Colors.white
                                      : AppColors.textPrimary,
                                ),
                              ),
                            ),
                            const SizedBox(height: 24),
                            ...List.generate(
                              question.options.length,
                              (index) => _buildOption(context, provider, index),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    BubblyButton(
                      title: provider.isLastQuestion ? 'Selesai' : 'Lanjut',
                      isFullWidth: true,
                      onTap: provider.userAnswers[provider.currentIndex] != null
                          ? () {
                              if (provider.isLastQuestion) {
                                provider.nextQuestion();
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => ResultScreen(title: title),
                                  ),
                                );
                              } else {
                                provider.nextQuestion();
                              }
                            }
                          : () {},
                      mainColor:
                          provider.userAnswers[provider.currentIndex] != null
                          ? const Color(0xFF64B5F6)
                          : (isDark ? Colors.white24 : Colors.grey.shade400),
                      shadowColor:
                          provider.userAnswers[provider.currentIndex] != null
                          ? const Color(0xFF1E88E5)
                          : (isDark ? Colors.white12 : Colors.grey.shade600),
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

  Widget _buildOption(BuildContext context, QuizProvider provider, int index) {
    final isSelected = provider.userAnswers[provider.currentIndex] == index;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: InkWell(
        onTap: () => provider.answerQuestion(index),
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
          decoration: BoxDecoration(
            color: isSelected
                ? AppColors.primary.withOpacity(0.1)
                : (isDark ? const Color(0xFF1E1E1E) : Colors.white),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: isSelected
                  ? AppColors.primary
                  : (isDark ? Colors.white10 : Colors.grey.shade200),
              width: 2,
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  color: isSelected
                      ? AppColors.primary
                      : (isDark ? Colors.white12 : Colors.grey.shade100),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    String.fromCharCode(65 + index),
                    style: TextStyle(
                      color: isSelected
                          ? Colors.white
                          : (isDark ? Colors.white70 : AppColors.textSecondary),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  provider.currentQuestion.options[index],
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: isSelected
                        ? FontWeight.bold
                        : FontWeight.normal,
                    color: isSelected
                        ? AppColors.primary
                        : (isDark ? Colors.white : AppColors.textPrimary),
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
