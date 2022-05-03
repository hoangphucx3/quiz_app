import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:quiz_app/models/questions.dart';
import 'package:quiz_app/screens/score_screen.dart';

class QuestionController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation _animation;

  Animation get animation => _animation;

  late PageController _pageController;
  PageController get pageController => _pageController;

  final List<Question> _questions = demoData
      .map((e) => Question(
          id: e['id'],
          answer: e['answer'],
          question: e['question'],
          options: e['options']))
      .toList();

  List<Question> get question => _questions;

  bool _isAnswered = false;
  bool get isAnswered => _isAnswered;

  late int _correctAnswer;
  int get correctAnswer => _correctAnswer;

  late int _selectedAnswer;
  int get selectedAnswer => _selectedAnswer;

  final RxInt _questionNumber = 1.obs;
  RxInt get questionNumber => _questionNumber;

  int _numOfCorrectAnswer = 0;
  int get numberOfCorrectAnswer => _numOfCorrectAnswer;

  @override
  void onInit() {
    _animationController =
        AnimationController(duration: const Duration(seconds: 15), vsync: this);
    _animation = Tween<double>(begin: 0, end: 1).animate(_animationController)
      ..addListener(() {
        update();
      });
    _animationController.forward().whenComplete(() => nextQuestion());
    _pageController = PageController();
    super.onInit();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    _animationController.dispose();
    _pageController.dispose();
  }

  void checkAnswer(Question question, int selectedIndex) {
    _isAnswered = true;
    _correctAnswer = question.answer;
    _selectedAnswer = selectedIndex;
    if(_correctAnswer == _selectedAnswer) {
      _numOfCorrectAnswer++;
    }
    _animationController.stop();
    update();

    Future.delayed(const Duration(seconds: 3), () {
      nextQuestion();
    });
  }

  void nextQuestion() {
    if(_questionNumber.value != _questions.length) {
      _isAnswered = false;
      _pageController.nextPage(duration: const Duration(milliseconds: 500), curve: Curves.ease);

      _animationController.reset();
      _animationController.forward().whenComplete(() => nextQuestion());
    } else {
      Get.to(() => const ScoreScreen());
    }
  }

  void updateQuestionNumber(int index) {
    _questionNumber.value = index +1;
  }
}
