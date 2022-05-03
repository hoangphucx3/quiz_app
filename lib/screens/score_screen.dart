import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_app/controller/question_controller.dart';

class ScoreScreen extends StatelessWidget {
  const ScoreScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    QuestionController _controller = Get.put(QuestionController());
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/images/bg_quiz.jpg',
            fit: BoxFit.cover,
            height: double.infinity,
            alignment: Alignment.center,
          ),
          Column(
            children: [
              const Spacer(flex: 3),
              const Text('Score', style: TextStyle(color: Colors.white, fontSize: 40),),
              const Spacer(),
              Text('${_controller.numberOfCorrectAnswer*10}/${_controller.question.length*10}', style: const TextStyle(color: Colors.white, fontSize: 30),),
              const Spacer(flex: 3),

            ],
          ),
        ],
      ),
    );
  }
}
