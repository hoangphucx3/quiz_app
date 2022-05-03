import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:quiz_app/constants.dart';
import 'package:quiz_app/controller/question_controller.dart';
import 'package:quiz_app/models/questions.dart';

class QuestionScreen extends StatelessWidget {
  const QuestionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    QuestionController _questionController = Get.put(QuestionController());
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: Brightness.light),
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          ElevatedButton(
            onPressed: () {
              _questionController.nextQuestion();
            },
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.transparent),
              elevation: MaterialStateProperty.all(0),
            ),
            child: const Text(
              'Skip',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          Image.asset(
            'assets/images/bg_quiz.jpg',
            fit: BoxFit.cover,
            height: double.infinity,
            alignment: Alignment.center,
          ),
          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: ProgressBar()),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Obx(
                      () => Text.rich(
                        TextSpan(
                          text: 'Question ${_questionController.questionNumber.value}',
                          style: const TextStyle(color: Colors.white, fontSize: 26),
                          children: [
                            TextSpan(
                                text: '/${_questionController.question.length}',
                                style: const TextStyle(fontSize: 20)),
                          ],
                        ),
                      ),
                ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Divider(
                    thickness: 2,
                    color: Colors.white54,
                  ),
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: PageView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    controller: _questionController.pageController,
                    onPageChanged: _questionController.updateQuestionNumber,
                    itemCount: _questionController.question.length,
                    itemBuilder: (context, index) => QuestionCard(
                        question: _questionController.question[index]),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class QuestionCard extends StatelessWidget {
  const QuestionCard({
    Key? key,
    required this.question,
  }) : super(key: key);

  final Question question;

  @override
  Widget build(BuildContext context) {
    QuestionController _controller = Get.put(QuestionController());
    return Container(
      padding: const EdgeInsets.all(15),
      margin: const EdgeInsets.symmetric(horizontal: 20),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        children: [
          Text(
            question.question,
            style: const TextStyle(fontSize: 20),
          ),
          ...List.generate(
            question.options.length,
            (index) => Option(
                index: index + 1,
                text: question.options[index],
                press: () {
                  _controller.checkAnswer(question, index+1);
                }),
          ),
        ],
      ),
    );
  }
}

class Option extends StatelessWidget {
  const Option(
      {Key? key, required this.index, required this.text, required this.press})
      : super(key: key);

  final int index;
  final String text;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<QuestionController>(
        init: QuestionController(),
        builder: (qzController) {
          Color getRightColor() {
            if (qzController.isAnswered) {
              if (index == qzController.correctAnswer) {
                return Colors.green;
              } else if (index == qzController.selectedAnswer &&
                  qzController.selectedAnswer != qzController.correctAnswer) {
                return Colors.red;
              }
            }
            return Colors.grey;
          }

          IconData getRightIcon() {
            return getRightColor() == Colors.red ? Icons.close : Icons.done;
          }

          return InkWell(
            onTap: press,
            child: Container(
              margin: const EdgeInsets.only(top: 15),
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                border: Border.all(color: getRightColor()),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '$index. $text',
                    style: TextStyle(fontSize: 18, color: getRightColor()),
                  ),
                  Container(
                    width: 25,
                    height: 25,
                    decoration: BoxDecoration(
                      color: getRightColor() == Colors.grey
                          ? Colors.transparent
                          : getRightColor(),
                      shape: BoxShape.circle,
                      border: Border.all(color: getRightColor()),
                    ),
                    child: getRightColor() == Colors.grey
                        ? null
                        : Icon(
                            getRightIcon(),
                            size: 16,
                            color: Colors.white,
                          ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}

class ProgressBar extends StatelessWidget {
  const ProgressBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 35,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFF3F4768), width: 3),
      ),
      child: GetBuilder<QuestionController>(
        init: QuestionController(),
        builder: ((controller) {
          return Stack(
            children: [
              LayoutBuilder(
                builder: (context, constraints) => Container(
                  width: constraints.maxWidth * controller.animation.value,
                  decoration: BoxDecoration(
                    gradient: mGradientColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
              Positioned.fill(
                right: 15,
                left: 15,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${(controller.animation.value * 15).round()} sec',
                      style: const TextStyle(color: Colors.white, fontSize: 18),
                    ),
                    const Icon(
                      Icons.access_time,
                      color: Colors.white,
                      size: 22,
                    ),
                  ],
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
