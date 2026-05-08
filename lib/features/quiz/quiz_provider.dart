import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../shared/models/question.dart';
import '../../core/utils/audio_controller.dart';

enum QuizType {
  preTest,
  diskusi1,
  postTest1,
  diskusi2,
  postTest2,
  diskusi3,
  postTest3,
  simulation
}

class QuizProvider extends ChangeNotifier {
  List<Question> _questions = [];
  int _currentIndex = 0;
  int _correctAnswersCount = 0;
  List<int?> _userAnswers = [];
  bool _isCompleted = false;
  bool _isProcessingFeedback = false;
  QuizType? _currentQuizType;

  // Persistence
  Map<QuizType, int> scores = {};
  Map<QuizType, int> totals = {};

  List<Question> get questions => _questions;
  int get currentIndex => _currentIndex;
  int get correctAnswersCount => _correctAnswersCount;
  List<int?> get userAnswers => _userAnswers;
  bool get isCompleted => _isCompleted;
  bool get isProcessingFeedback => _isProcessingFeedback;
  QuizType? get currentQuizType => _currentQuizType;

  Question get currentQuestion => _questions[_currentIndex];
  bool get isLastQuestion => _currentIndex == _questions.length - 1;

  QuizProvider() {
    _loadProgress();
  }

  Future<void> _loadProgress() async {
    final prefs = await SharedPreferences.getInstance();
    for (var type in QuizType.values) {
      if (type == QuizType.simulation) continue;
      
      final score = prefs.getInt('${type.name}_score');
      final total = prefs.getInt('${type.name}_total');
      if (score != null && total != null) {
        scores[type] = score;
        totals[type] = total;
      }
    }
    notifyListeners();
  }

  Future<void> _saveProgress(QuizType type, int score, int total) async {
    if (type == QuizType.simulation) return;
    
    scores[type] = score;
    totals[type] = total;
    
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('${type.name}_score', score);
    await prefs.setInt('${type.name}_total', total);
    notifyListeners();
  }

  Future<void> resetAllData() async {
    scores.clear();
    totals.clear();
    final prefs = await SharedPreferences.getInstance();
    for (var type in QuizType.values) {
      if (type == QuizType.simulation) continue;
      await prefs.remove('${type.name}_score');
      await prefs.remove('${type.name}_total');
    }
    notifyListeners();
  }

  bool get isAllTestsCompleted {
    return scores.containsKey(QuizType.preTest) &&
        scores.containsKey(QuizType.diskusi1) &&
        scores.containsKey(QuizType.postTest1) &&
        scores.containsKey(QuizType.diskusi2) &&
        scores.containsKey(QuizType.postTest2) &&
        scores.containsKey(QuizType.diskusi3) &&
        scores.containsKey(QuizType.postTest3);
  }

  void startQuiz(
    List<Question> questions, {
    QuizType type = QuizType.simulation,
  }) {
    _questions = questions;
    _currentIndex = 0;
    _correctAnswersCount = 0;
    _userAnswers = List.filled(questions.length, null);
    _isCompleted = false;
    _isProcessingFeedback = false;
    _currentQuizType = type;
    notifyListeners();
  }

  void _proceedToNextState() {
    _isProcessingFeedback = false;
    if (isLastQuestion) {
      _isCompleted = true;
      if (_currentQuizType != null && _currentQuizType != QuizType.simulation) {
        _saveProgress(_currentQuizType!, _correctAnswersCount, _questions.length);
      }
    } else {
      _currentIndex++;
    }
    notifyListeners();
  }

  Future<void> answerQuestion(int answerIndex) async {
    if (_userAnswers[_currentIndex] != null || _isProcessingFeedback) return;

    _userAnswers[_currentIndex] = answerIndex;

    final isCorrect = answerIndex == currentQuestion.correctAnswerIndex;

    if (isCorrect) {
      _correctAnswersCount++;
      AudioController.instance.playSfx('correct_answer.mp3');
    } else {
      AudioController.instance.playSfx('wrong_answer.mp3');
    }

    _isProcessingFeedback = true;
    notifyListeners();

    await Future.delayed(const Duration(milliseconds: 2200));
    _proceedToNextState();
  }

  void reset() {
    _currentIndex = 0;
    _correctAnswersCount = 0;
    _userAnswers = [];
    _isCompleted = false;
    _isProcessingFeedback = false;
    notifyListeners();
  }
}
