import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_app/screens/welcome_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      title: 'Quiz App',
      debugShowCheckedModeBanner: false,
      home: WelcomeScreen(),
    );
  }
}
