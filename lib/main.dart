import 'package:flutter/material.dart';
import 'models/quiz_brain.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const SportsQuizApp());
}

class SportsQuizApp extends StatelessWidget {
  const SportsQuizApp({super.key});

  @override
  Widget build(BuildContext context) {
    final quizBrain = QuizBrain();

    return MaterialApp(
      title: 'Sports Quiz',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF6C5CE7),
          brightness: Brightness.dark,
        ),
        scaffoldBackgroundColor: const Color(0xFF0D1117),
      ),
      home: HomeScreen(quizBrain: quizBrain),
    );
  }
}