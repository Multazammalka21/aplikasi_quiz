import '../data/Bank_soal.dart';
import 'pertanyaan.dart';
import 'category.dart';

class QuizBrain {
  QuizCategory? _activeCategory;
  List<Question> _questions = [];
  int _questionIndex = 0;
  int _score = 0;
  bool? _lastAnswerCorrect;
  int? _lastAnswerIndex;

  // ── Getters ──────────────────────────────────────
  List<QuizCategory> get allCategories => QuestionBank.categories;
  QuizCategory? get activeCategory => _activeCategory;
  int get score => _score;
  int get questionIndex => _questionIndex;
  int get totalQuestions => _questions.length;
  bool? get lastAnswerCorrect => _lastAnswerCorrect;
  int? get lastAnswerIndex => _lastAnswerIndex;
  Question get currentQuestion => _questions[_questionIndex];
  double get progress =>
      _questions.isEmpty ? 0 : _questionIndex / _questions.length;

  // ── Pilih Kategori ────────────────────────────────
  void selectCategory(QuizCategory category) {
    _activeCategory = category;
    _questions = List.from(category.questions);
    _questionIndex = 0;
    _score = 0;
    _lastAnswerCorrect = null;
    _lastAnswerIndex = null;
  }

  // ── Cek apakah kuis sudah selesai ────────────────
  bool isFinished() {
    return _questionIndex >= _questions.length;
  }

  // ── Cek jawaban user ──────────────────────────────
  bool checkAnswer(int selectedIndex) {
    _lastAnswerIndex = selectedIndex;
    final isCorrect = selectedIndex == currentQuestion.correctIndex;
    _lastAnswerCorrect = isCorrect;
    if (isCorrect) _score++;
    return isCorrect;
  }

  // ── Lanjut ke soal berikutnya ─────────────────────
  void nextQuestion() {
    if (!isFinished()) {
      _questionIndex++;
      _lastAnswerCorrect = null;
      _lastAnswerIndex = null;
    }
  }

  // ── Ulangi kuis dari awal (kategori sama) ─────────
  void reset() {
    _questionIndex = 0;
    _score = 0;
    _lastAnswerCorrect = null;
    _lastAnswerIndex = null;
  }

  // ── Kembali ke halaman pemilihan kategori ─────────
  void resetToHome() {
    reset();
    _activeCategory = null;
    _questions = [];
  }

  // ── Label hasil akhir ─────────────────────────────
  String getResultLabel() {
    final pct = _score / _questions.length;
    if (pct == 1.0) return 'Sempurna! 🏆';
    if (pct >= 0.8) return 'Luar Biasa! 🌟';
    if (pct >= 0.6) return 'Bagus! 👍';
    if (pct >= 0.4) return 'Cukup 📚';
    return 'Yuk Belajar Lagi! 💪';
  }
}