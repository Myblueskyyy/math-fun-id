import 'package:flutter/material.dart';
import '../../features/quiz/quiz_provider.dart';
import 'materi.dart';

class Pertemuan {
  final String title;
  final String subtitle;
  final Color color;
  final IconData icon;

  final QuizType? preTestType;
  final Materi materi;
  final QuizType diskusiType;
  final QuizType postTestType;

  Pertemuan({
    required this.title,
    required this.subtitle,
    required this.color,
    required this.icon,
    this.preTestType,
    required this.materi,
    required this.diskusiType,
    required this.postTestType,
  });
}
