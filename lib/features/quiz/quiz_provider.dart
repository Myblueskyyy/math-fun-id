import 'package:flutter/material.dart';
import '../../shared/models/question.dart';

class QuizProvider extends ChangeNotifier {
  List<Question> _questions = [];
  int _currentIndex = 0;
  int _score = 0;
  List<int?> _userAnswers = [];
  bool _isCompleted = false;

  List<Question> get questions => _questions;
  int get currentIndex => _currentIndex;
  int get score => _score;
  List<int?> get userAnswers => _userAnswers;
  bool get isCompleted => _isCompleted;
  
  Question get currentQuestion => _questions[_currentIndex];
  bool get isLastQuestion => _currentIndex == _questions.length - 1;

  void startQuiz(List<Question> questions) {
    _questions = questions;
    _currentIndex = 0;
    _score = 0;
    _userAnswers = List.filled(questions.length, null);
    _isCompleted = false;
    notifyListeners();
  }

  void answerQuestion(int answerIndex) {
    _userAnswers[_currentIndex] = answerIndex;
    if (answerIndex == currentQuestion.correctAnswerIndex) {
      _score++;
    }
    notifyListeners();
  }

  void nextQuestion() {
    if (_currentIndex < _questions.length - 1) {
      _currentIndex++;
      notifyListeners();
    } else {
      _isCompleted = true;
      notifyListeners();
    }
  }

  void reset() {
    _currentIndex = 0;
    _score = 0;
    _userAnswers = [];
    _isCompleted = false;
    notifyListeners();
  }
}
