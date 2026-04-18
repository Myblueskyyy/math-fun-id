import 'dart:async';
import 'package:flutter/material.dart';
import '../../shared/models/question.dart';
import '../../core/utils/audio_controller.dart';

enum QuizType { preTest, postTest, simulation }

class QuizProvider extends ChangeNotifier {
  List<Question> _questions = [];
  int _currentIndex = 0;
  int _correctAnswersCount = 0;
  List<int?> _userAnswers = [];
  bool _isCompleted = false;

  bool _isProcessingFeedback = false; // To freeze UI during the 1.5s delay

  QuizType? _currentQuizType;
  int? preTestScore;
  int? postTestScore;
  int preTestTotal = 0;
  int postTestTotal = 0;

  List<Question> get questions => _questions;
  int get currentIndex => _currentIndex;
  int get correctAnswersCount => _correctAnswersCount;
  List<int?> get userAnswers => _userAnswers;
  bool get isCompleted => _isCompleted;
  bool get isProcessingFeedback => _isProcessingFeedback;
  QuizType? get currentQuizType => _currentQuizType;

  Question get currentQuestion => _questions[_currentIndex];
  bool get isLastQuestion => _currentIndex == _questions.length - 1;

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
      if (_currentQuizType == QuizType.preTest) {
        preTestScore = _correctAnswersCount;
        preTestTotal = _questions.length;
      } else if (_currentQuizType == QuizType.postTest) {
        postTestScore = _correctAnswersCount;
        postTestTotal = _questions.length;
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

    await Future.delayed(const Duration(milliseconds: 1500));
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
