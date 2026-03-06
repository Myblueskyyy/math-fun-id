import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/constants/app_strings.dart';
import '../quiz/quiz_provider.dart';
import '../quiz/quiz_repository.dart';
import '../quiz/quiz_screen.dart';
import '../materi/materi_list_screen.dart';
import '../evaluasi/evaluasi_screen.dart';
import '../../core/widgets/bubbly_background.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE0F7FA),
      extendBodyBehindAppBar: true,
      body: BubblyBackground(
        child: SafeArea(
          child: Center(
            child: Container(
              constraints: const BoxConstraints(maxWidth: 800),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Flexible(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Flexible(
                          child: InkWell(
                            onTap: () {
                              final provider = Provider.of<QuizProvider>(
                                context,
                                listen: false,
                              );
                              provider.startQuiz(
                                QuizRepository.preTestQuestions,
                                type: QuizType.preTest,
                              );
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const QuizScreen(
                                    title: AppStrings.menuSimulasi,
                                  ),
                                ),
                              );
                            },
                            child: Image.asset(
                              'assets/images/home_screen/pre_test_button.png',
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Flexible(
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const MateriListScreen(),
                                ),
                              );
                            },
                            child: Image.asset(
                              'assets/images/home_screen/materi_button.png',
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Flexible(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Flexible(
                          child: InkWell(
                            onTap: () {
                              final provider = Provider.of<QuizProvider>(
                                context,
                                listen: false,
                              );
                              provider.startQuiz(
                                QuizRepository.postTestQuestions,
                                type: QuizType.postTest,
                              );
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) =>
                                      const QuizScreen(title: 'Evaluasi'),
                                ),
                              );
                            },
                            child: Image.asset(
                              'assets/images/home_screen/post_test_button.png',
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Flexible(
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const EvaluasiScreen(),
                                ),
                              );
                            },
                            child: Image.asset(
                              'assets/images/home_screen/eval_button.png',
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
