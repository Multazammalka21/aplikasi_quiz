class Question {
  final String questionText;
  final List<String> options; // ['a. ...', 'b. ...', 'c. ...', 'd. ...']
  final int correctIndex;     // index jawaban benar (0=a, 1=b, 2=c, 3=d)

  Question({
    required this.questionText,
    required this.options,
    required this.correctIndex,
  });
}