import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/constants/app_colors.dart';
import '../../core/widgets/bubbly_background.dart';
import '../../shared/widgets/custom_card.dart';
import 'quiz_provider.dart';
import 'result_screen.dart';

class QuizScreen extends StatefulWidget {
  final String title;

  const QuizScreen({super.key, required this.title});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  QuizProvider? _provider;
  bool _navigated = false;

  @override
  void initState() {
    super.initState();
    // Add post frame callback to safely add the listener
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _provider = context.read<QuizProvider>();
      _provider?.addListener(_onProviderUpdate);
    });
  }

  void _onProviderUpdate() {
    if (!mounted) return;
    if (_provider?.isCompleted == true && !_navigated) {
      _navigated = true;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => ResultScreen(title: widget.title)),
      );
    }
  }

  @override
  void dispose() {
    _provider?.removeListener(_onProviderUpdate);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<QuizProvider>(
      builder: (context, provider, child) {
        if (provider.questions.isEmpty) return const SizedBox.shrink();

        final question = provider.currentQuestion;
        final isDark = Theme.of(context).brightness == Brightness.dark;

        return Scaffold(
          extendBodyBehindAppBar: true,
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            title: Text(widget.title),
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
          body: Stack(
            fit: StackFit.expand,
            children: [
              BubblyBackground(
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          'Pertanyaan ${provider.currentIndex + 1}/${provider.questions.length}',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primary,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 20),
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
                                  (index) =>
                                      _buildOption(context, provider, index),
                                ),
                                if (provider.isProcessingFeedback)
                                  _buildFeedbackOverlay(provider),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              if (provider.currentQuizType == QuizType.preTest)
                Positioned(
                  right: 20,
                  bottom: 20,
                  child: Transform.flip(
                    flipX: true,
                    child: Image.asset(
                      'assets/images/anis.png',
                      height: 300,
                      errorBuilder: (context, error, stackTrace) => Column(
                        children: [
                          Icon(
                            Icons.person_outline_rounded,
                            size: 100,
                            color: AppColors.primary.withOpacity(0.5),
                          ),
                          const Text(
                            'Anis Placeholder',
                            style: TextStyle(color: Colors.white70),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              if (provider.currentQuizType == QuizType.postTest)
                Positioned(
                  right: 20,
                  bottom: 20,
                  child: Image.asset(
                    'assets/images/angga.png',
                    height: 300,
                    errorBuilder: (context, error, stackTrace) => Column(
                      children: [
                        Icon(
                          Icons.person_outline_rounded,
                          size: 100,
                          color: AppColors.primary.withOpacity(0.5),
                        ),
                        const Text(
                          'Angga Placeholder',
                          style: TextStyle(color: Colors.white70),
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildFeedbackOverlay(QuizProvider provider) {
    final userAnswer = provider.userAnswers[provider.currentIndex];
    final isCorrect = userAnswer == provider.currentQuestion.correctAnswerIndex;
    final isTimeout = userAnswer == -1;

    Color color;
    IconData icon;
    String text;

    if (isTimeout) {
      color = Colors.orange;
      icon = Icons.timer_off_rounded;
      text = "Waktu Habis!";
    } else if (isCorrect) {
      color = Colors.green;
      icon = Icons.check_circle_rounded;
      text = "Benar!";
    } else {
      color = Colors.redAccent;
      icon = Icons.cancel_rounded;
      text = "Salah!";
    }

    return Container(
      margin: const EdgeInsets.only(top: 24),
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
      decoration: BoxDecoration(
        color: color.withOpacity(0.15),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color, width: 2),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: color, size: 36),
          const SizedBox(width: 12),
          Text(
            text,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOption(BuildContext context, QuizProvider provider, int index) {
    final userAnswer = provider.userAnswers[provider.currentIndex];
    final isSelected = userAnswer == index;
    final isCorrectOption =
        index == provider.currentQuestion.correctAnswerIndex;

    // Determine boundary colors if an answer is selected
    bool showCorrect = userAnswer != null && isCorrectOption;
    bool showWrong = userAnswer != null && isSelected && !isCorrectOption;

    final isDark = Theme.of(context).brightness == Brightness.dark;

    Color borderColor = Colors.transparent;
    Color bgColor = isDark ? const Color(0xFF1E1E1E) : Colors.white;

    if (showCorrect) {
      borderColor = Colors.green;
      bgColor = Colors.green.withOpacity(0.1);
    } else if (showWrong) {
      borderColor = Colors.redAccent;
      bgColor = Colors.redAccent.withOpacity(0.1);
    } else if (userAnswer == null) {
      borderColor = isDark ? Colors.white10 : Colors.grey.shade200;
    } else {
      // Dim other options when an answer is selected
      borderColor = isDark ? Colors.white10 : Colors.grey.shade200;
      bgColor = isDark ? Colors.grey.shade900 : Colors.grey.shade100;
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: GestureDetector(
        onTap: () {
          if (userAnswer == null) {
            provider.answerQuestion(index);
          }
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: borderColor, width: 2),
          ),
          child: Row(
            children: [
              Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  color: showCorrect
                      ? Colors.green
                      : showWrong
                      ? Colors.redAccent
                      : (isDark ? Colors.white12 : Colors.grey.shade200),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    String.fromCharCode(65 + index),
                    style: TextStyle(
                      color: (showCorrect || showWrong)
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
                    fontWeight: (showCorrect || showWrong)
                        ? FontWeight.bold
                        : FontWeight.normal,
                    color: (showCorrect || showWrong)
                        ? borderColor
                        : (isDark ? Colors.white : AppColors.textPrimary),
                  ),
                ),
              ),
              if (showCorrect)
                const Icon(Icons.check_circle_rounded, color: Colors.green)
              else if (showWrong)
                const Icon(Icons.cancel_rounded, color: Colors.redAccent),
            ],
          ),
        ),
      ),
    );
  }
}
