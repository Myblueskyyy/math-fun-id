class Question {
  final String id;
  final String text;
  final List<String> options;
  final int correctAnswerIndex;
  final String explanation;

  Question({
    required this.id,
    required this.text,
    required this.options,
    required this.correctAnswerIndex,
    required this.explanation,
  });
}
