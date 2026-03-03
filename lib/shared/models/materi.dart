import 'package:flutter/material.dart';

class Materi {
  final String title;
  final String description;
  final String content;
  final Map<String, String> formulas;
  final List<ExampleQuestion> examples;
  final IconData icon;
  final Color color;

  Materi({
    required this.title,
    required this.description,
    required this.content,
    required this.formulas,
    required this.examples,
    required this.icon,
    required this.color,
  });
}

class ExampleQuestion {
  final String question;
  final String solution;

  ExampleQuestion({required this.question, required this.solution});
}
