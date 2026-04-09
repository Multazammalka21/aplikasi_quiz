import 'pertanyaan.dart';

class QuizCategory {
  final String id;
  final String name;
  final String icon;
  final String imagePath;
  final List<Question> questions;

  QuizCategory({
    required this.id,
    required this.name,
    required this.icon,
    required this.imagePath,
    required this.questions,
  });
}