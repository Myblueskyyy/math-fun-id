import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:confetti/confetti.dart';
import '../../core/constants/app_colors.dart';
import '../../core/widgets/bubbly_background.dart';
import '../../core/utils/device_utils.dart';
import '../../shared/widgets/custom_card.dart';
import 'quiz_provider.dart';
import 'result_screen.dart';
import '../../core/utils/audio_controller.dart';

class QuizScreen extends StatefulWidget {
  final String title;

  const QuizScreen({super.key, required this.title});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen>
    with TickerProviderStateMixin {
  QuizProvider? _provider;
  bool _navigated = false;

  // Confetti controller for correct answers
  late ConfettiController _confettiController;

  // Animation for feedback popup
  late AnimationController _popupAnimController;
  late Animation<double> _popupScaleAnim;
  late Animation<double> _popupOpacityAnim;

  // Track whether we're showing a feedback popup
  bool _showingFeedback = false;
  bool? _lastAnswerCorrect;
  bool _lastAnswerTimeout = false;

  @override
  void initState() {
    super.initState();

    _confettiController =
        ConfettiController(duration: const Duration(seconds: 2));

    _popupAnimController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    _popupScaleAnim = Tween<double>(begin: 0.3, end: 1.0).animate(
      CurvedAnimation(
        parent: _popupAnimController,
        curve: Curves.elasticOut,
      ),
    );

    _popupOpacityAnim = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _popupAnimController,
        curve: const Interval(0.0, 0.3, curve: Curves.easeIn),
      ),
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _provider = context.read<QuizProvider>();
      _provider?.addListener(_onProviderUpdate);

      if (DeviceUtils.isPhone(context)) {
        DeviceUtils.forcePortrait();
      }

      AudioController.instance.playBgm('test_bgm.mp3', targetVolume: 0.2);
    });
  }

  void _onProviderUpdate() {
    if (!mounted) return;

    final provider = _provider;
    if (provider == null) return;

    // Check if the provider just entered feedback mode
    if (provider.isProcessingFeedback && !_showingFeedback) {
      final userAnswer = provider.userAnswers[provider.currentIndex];
      final isCorrect =
          userAnswer == provider.currentQuestion.correctAnswerIndex;
      final isTimeout = userAnswer == -1;

      setState(() {
        _showingFeedback = true;
        _lastAnswerCorrect = isCorrect;
        _lastAnswerTimeout = isTimeout;
      });

      _popupAnimController.forward(from: 0.0);

      if (isCorrect) {
        _confettiController.play();
      }
    }

    // Check if provider exited feedback mode (moving to next question)
    if (!provider.isProcessingFeedback && _showingFeedback) {
      setState(() {
        _showingFeedback = false;
      });
      _popupAnimController.reset();
      _confettiController.stop();
    }

    if (provider.isCompleted && !_navigated) {
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
    _confettiController.dispose();
    _popupAnimController.dispose();
    DeviceUtils.resetToDefault();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      AudioController.instance.ensureMainBgm();
    });
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<QuizProvider>(
      builder: (context, provider, child) {
        if (provider.questions.isEmpty) return const SizedBox.shrink();

        final question = provider.currentQuestion;

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
                                  color: Colors.white,
                                  child: Text(
                                    question.text,
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                      height: 1.5,
                                      color: AppColors.textPrimary,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 24),
                                ...List.generate(
                                  question.options.length,
                                  (index) =>
                                      _buildOption(context, provider, index),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              // Character overlays
              if (provider.currentQuizType == QuizType.preTest)
                Positioned(
                  right: 20,
                  bottom: 20,
                  child: FloatingCharacter(
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
                ),
              if (provider.currentQuizType == QuizType.postTest1 || provider.currentQuizType == QuizType.postTest2 || provider.currentQuizType == QuizType.postTest3)
                Positioned(
                  right: 20,
                  bottom: 20,
                  child: FloatingCharacter(
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
                ),

              // Feedback popup overlay
              if (_showingFeedback) _buildFeedbackPopup(),

              // Confetti overlay — on top of everything
              Align(
                alignment: Alignment.topCenter,
                child: ConfettiWidget(
                  confettiController: _confettiController,
                  blastDirection: pi / 2, // downward
                  maxBlastForce: 20,
                  minBlastForce: 8,
                  emissionFrequency: 0.05,
                  numberOfParticles: 25,
                  gravity: 0.2,
                  shouldLoop: false,
                  colors: const [
                    Colors.green,
                    Colors.blue,
                    Colors.pink,
                    Colors.orange,
                    Colors.purple,
                    Colors.yellow,
                    Colors.cyan,
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildFeedbackPopup() {
    // Determine feedback content
    String title;
    String subtitle;
    IconData icon;
    Color primaryColor;
    Color bgColor;
    List<Color> gradientColors;

    if (_lastAnswerTimeout) {
      title = "Waktu Habis! ⏰";
      subtitle = "Jangan khawatir, coba lebih cepat di soal berikutnya ya!";
      icon = Icons.timer_off_rounded;
      primaryColor = Colors.orange;
      bgColor = const Color(0xFFFFF3E0);
      gradientColors = [const Color(0xFFFF9800), const Color(0xFFFFA726)];
    } else if (_lastAnswerCorrect == true) {
      title = "Hebat! 🎉";
      subtitle = _getRandomCorrectMessage();
      icon = Icons.emoji_events_rounded;
      primaryColor = Colors.green;
      bgColor = const Color(0xFFE8F5E9);
      gradientColors = [const Color(0xFF4CAF50), const Color(0xFF66BB6A)];
    } else {
      title = "Yuk Coba Lagi! 💪";
      subtitle = _getRandomWrongMessage();
      icon = Icons.sentiment_satisfied_alt_rounded;
      primaryColor = Colors.redAccent;
      bgColor = const Color(0xFFFCE4EC);
      gradientColors = [const Color(0xFFEF5350), const Color(0xFFFF7043)];
    }

    return AnimatedBuilder(
      animation: _popupAnimController,
      builder: (context, child) {
        return Opacity(
          opacity: _popupOpacityAnim.value.clamp(0.0, 1.0),
          child: Container(
            color: Colors.black.withOpacity(0.4 * _popupOpacityAnim.value),
            child: Center(
              child: Transform.scale(
                scale: _popupScaleAnim.value.clamp(0.0, 1.5),
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 40),
                  padding: const EdgeInsets.all(28),
                  decoration: BoxDecoration(
                    color: bgColor,
                    borderRadius: BorderRadius.circular(28),
                    boxShadow: [
                      BoxShadow(
                        color: primaryColor.withOpacity(0.3),
                        blurRadius: 30,
                        spreadRadius: 5,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Gradient icon circle
                      Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(
                            colors: gradientColors,
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: primaryColor.withOpacity(0.4),
                              blurRadius: 16,
                              offset: const Offset(0, 6),
                            ),
                          ],
                        ),
                        child: Icon(
                          icon,
                          color: Colors.white,
                          size: 44,
                        ),
                      ),
                      const SizedBox(height: 20),
                      // Title
                      Text(
                        title,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.w800,
                          color: primaryColor,
                          letterSpacing: 0.5,
                        ),
                      ),
                      const SizedBox(height: 12),
                      // Subtitle
                      Text(
                        subtitle,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: primaryColor.withOpacity(0.8),
                          height: 1.4,
                        ),
                      ),
                      const SizedBox(height: 8),
                      // Animated dots indicator
                      _buildDotsIndicator(primaryColor),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildDotsIndicator(Color color) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(3, (index) {
        return TweenAnimationBuilder<double>(
          tween: Tween(begin: 0.0, end: 1.0),
          duration: Duration(milliseconds: 400 + (index * 200)),
          builder: (context, value, child) {
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 4),
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: color.withOpacity(0.3 + (0.5 * value)),
              ),
            );
          },
        );
      }),
    );
  }

  String _getRandomCorrectMessage() {
    final messages = [
      "Kamu pintar sekali! Terus semangat ya!",
      "Jawaban yang tepat! Kamu luar biasa!",
      "Benar! Kamu sudah memahami materinya!",
      "Mantap! Pertahankan terus ya!",
      "Keren! Kamu bisa menjawab dengan benar!",
    ];
    return messages[Random().nextInt(messages.length)];
  }

  String _getRandomWrongMessage() {
    final messages = [
      "Tidak apa-apa, setiap kesalahan adalah pelajaran!",
      "Tetap semangat! Kamu pasti bisa di soal berikutnya!",
      "Jangan menyerah, yuk pelajari lagi materinya!",
      "Hampir benar! Coba perhatikan lebih teliti ya!",
      "Ayo semangat! Belajar dari kesalahan itu hebat!",
    ];
    return messages[Random().nextInt(messages.length)];
  }

  Widget _buildOption(BuildContext context, QuizProvider provider, int index) {
    final userAnswer = provider.userAnswers[provider.currentIndex];
    final isSelected = userAnswer == index;
    final isCorrectOption =
        index == provider.currentQuestion.correctAnswerIndex;

    // Determine boundary colors if an answer is selected
    bool showCorrect = userAnswer != null && isCorrectOption;
    bool showWrong = userAnswer != null && isSelected && !isCorrectOption;

    Color borderColor = Colors.transparent;
    Color bgColor = Colors.white;

    if (showCorrect) {
      borderColor = Colors.green;
      bgColor = Colors.green.withOpacity(0.1);
    } else if (showWrong) {
      borderColor = Colors.redAccent;
      bgColor = Colors.redAccent.withOpacity(0.1);
    } else if (userAnswer == null) {
      borderColor = Colors.grey.shade200;
    } else {
      // Dim other options when an answer is selected
      borderColor = Colors.grey.shade200;
      bgColor = Colors.grey.shade100;
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: GestureDetector(
        onTap: () {
          if (userAnswer == null) {
            AudioController.instance.playButtonClick();
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
                  color: (showCorrect || showWrong)
                      ? Colors.white
                      : Colors.grey.shade200,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    String.fromCharCode(65 + index),
                    style: TextStyle(
                      color: (showCorrect || showWrong)
                          ? Colors.white
                          : AppColors.textSecondary,
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
                        : AppColors.textPrimary,
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

class FloatingCharacter extends StatefulWidget {
  final Widget child;

  const FloatingCharacter({Key? key, required this.child}) : super(key: key);

  @override
  State<FloatingCharacter> createState() => _FloatingCharacterState();
}

class _FloatingCharacterState extends State<FloatingCharacter>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat(reverse: true);
    _animation = Tween<double>(begin: -10, end: 10).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, _animation.value),
          child: widget.child,
        );
      },
    );
  }
}
