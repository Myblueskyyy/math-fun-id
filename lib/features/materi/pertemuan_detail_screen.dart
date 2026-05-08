import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/constants/app_colors.dart';
import '../../core/widgets/bubbly_background.dart';
import '../../shared/models/pertemuan.dart';
import '../../shared/widgets/custom_card.dart';
import '../quiz/quiz_provider.dart';
import '../quiz/quiz_repository.dart';
import '../quiz/quiz_screen.dart';
import 'materi_detail_screen.dart';
import '../../core/utils/audio_controller.dart';
import '../../shared/models/question.dart';

class PertemuanDetailScreen extends StatelessWidget {
  final Pertemuan pertemuan;

  const PertemuanDetailScreen({super.key, required this.pertemuan});

  List<Question> _getQuestionsForType(QuizType type) {
    switch (type) {
      case QuizType.preTest:
        return QuizRepository.preTestQuestions;
      case QuizType.diskusi1:
        return QuizRepository.diskusi1Questions;
      case QuizType.postTest1:
        return QuizRepository.postTest1Questions;
      case QuizType.diskusi2:
        return QuizRepository.diskusi2Questions;
      case QuizType.postTest2:
        return QuizRepository.postTest2Questions;
      case QuizType.diskusi3:
        return QuizRepository.diskusi3Questions;
      case QuizType.postTest3:
        return QuizRepository.postTest3Questions;
      default:
        return [];
    }
  }

  void _navigateToQuiz(BuildContext context, QuizType type, String title) {
    AudioController.instance.playButtonClick();
    final provider = Provider.of<QuizProvider>(context, listen: false);
    provider.startQuiz(_getQuestionsForType(type), type: type);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => QuizScreen(title: title),
      ),
    );
  }

  void _navigateToMateri(BuildContext context) {
    AudioController.instance.playButtonClick();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => MateriDetailScreen(materi: pertemuan.materi),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(pertemuan.title),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: BubblyBackground(
        child: SafeArea(
          child: Consumer<QuizProvider>(
            builder: (context, quizProvider, _) {
              return ListView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.all(20),
                children: [
                  Text(
                    pertemuan.subtitle,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: pertemuan.color,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 32),
                  
                  if (pertemuan.preTestType != null)
                    _buildStepCard(
                      context: context,
                      title: '1. Pre-Test',
                      description: 'Uji pemahaman awalmu.',
                      icon: Icons.assignment_rounded,
                      color: Colors.purple,
                      isCompleted: quizProvider.scores.containsKey(pertemuan.preTestType),
                      onTap: () => _navigateToQuiz(context, pertemuan.preTestType!, 'Pre-Test'),
                    ),
                  
                  _buildStepCard(
                    context: context,
                    title: pertemuan.preTestType != null ? '2. Materi Pembelajaran' : '1. Materi Pembelajaran',
                    description: 'Pelajari konsep materi dan simulasinya.',
                    icon: Icons.menu_book_rounded,
                    color: pertemuan.color,
                    isCompleted: false, // Materi doesn't have a completion status yet
                    onTap: () => _navigateToMateri(context),
                  ),

                  _buildStepCard(
                    context: context,
                    title: pertemuan.preTestType != null ? '3. Soal Diskusi' : '2. Soal Diskusi',
                    description: 'Kerjakan soal latihan berdasarkan materi.',
                    icon: Icons.group_work_rounded,
                    color: Colors.teal,
                    isCompleted: quizProvider.scores.containsKey(pertemuan.diskusiType),
                    onTap: () => _navigateToQuiz(context, pertemuan.diskusiType, 'Soal Diskusi'),
                  ),

                  _buildStepCard(
                    context: context,
                    title: pertemuan.preTestType != null ? '4. Post-Test' : '3. Post-Test',
                    description: 'Uji pemahaman akhirmu setelah belajar.',
                    icon: Icons.assessment_rounded,
                    color: Colors.indigo,
                    isCompleted: quizProvider.scores.containsKey(pertemuan.postTestType),
                    onTap: () => _navigateToQuiz(context, pertemuan.postTestType, 'Post-Test'),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildStepCard({
    required BuildContext context,
    required String title,
    required String description,
    required IconData icon,
    required Color color,
    required bool isCompleted,
    required VoidCallback onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: CustomCard(
        onTap: onTap,
        color: Colors.white,
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Icon(icon, color: color, size: 30),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    description,
                    style: const TextStyle(
                      fontSize: 14,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            if (isCompleted)
              const Icon(
                Icons.check_circle_rounded,
                color: Colors.green,
                size: 28,
              )
            else
              const Icon(
                Icons.arrow_forward_ios_rounded,
                size: 16,
                color: Colors.grey,
              ),
          ],
        ),
      ),
    );
  }
}
