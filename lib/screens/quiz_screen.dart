import 'package:flutter/material.dart';
import '../models/quiz_brain.dart';
import 'result_screen.dart';

class QuizScreen extends StatefulWidget {
  final QuizBrain quizBrain;

  const QuizScreen({super.key, required this.quizBrain});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen>
    with SingleTickerProviderStateMixin {
  bool _answered = false;
  int? _selectedIndex;
  late AnimationController _animController;
  late Animation<double> _fadeAnim;
  late Animation<Offset> _slideAnim;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );
    _fadeAnim = CurvedAnimation(
      parent: _animController,
      curve: Curves.easeOut,
    );
    _slideAnim = Tween<Offset>(
      begin: const Offset(0, 0.06),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animController,
      curve: Curves.easeOut,
    ));
    _animController.forward();
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  Color get _accentColor {
    const map = {
      'running': Color(0xFFFF6B35),    // Oranye
      'football': Color(0xFF2ECC71),   // Hijau
      'motorsport': Color(0xFFFF6B35), // Oranye
      'basketball': Color(0xFF2ECC71), // Hijau
    };
    return map[widget.quizBrain.activeCategory?.id] ?? const Color(0xFF2ECC71);
  }

  void _onAnswerSelected(int index) {
    if (_answered) return;

    widget.quizBrain.checkAnswer(index);

    setState(() {
      _answered = true;
      _selectedIndex = index;
    });

    Future.delayed(const Duration(milliseconds: 1300), () {
      if (!mounted) return;
      widget.quizBrain.nextQuestion();

      if (widget.quizBrain.isFinished()) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => ResultScreen(quizBrain: widget.quizBrain),
          ),
        );
      } else {
        _animController.reset();
        setState(() {
          _answered = false;
          _selectedIndex = null;
        });
        _animController.forward();
      }
    });
  }

  Color _buttonColor(int index) {
    if (!_answered) return const Color(0xFF121212); // Hitam pekat
    final correct = widget.quizBrain.currentQuestion.correctIndex;
    if (index == correct) return const Color(0xFF0D2B1A); // Hijau sangat gelap
    if (index == _selectedIndex) return const Color(0xFF33150A); // Oranye sangat gelap
    return const Color(0xFF121212);
  }

  Color _buttonBorderColor(int index) {
    if (!_answered) return const Color(0xFF333333); // Abu-abu gelap
    final correct = widget.quizBrain.currentQuestion.correctIndex;
    if (index == correct) return const Color(0xFF2ECC71); // Hijau (Benar)
    if (index == _selectedIndex) return const Color(0xFFFF6B35); // Oranye (Salah)
    return const Color(0xFF333333);
  }

  Widget _buttonTrailing(int index) {
    if (!_answered) {
      return Container(
        width: 28,
        height: 28,
        decoration: BoxDecoration(
          border: Border.all(color: const Color(0xFF333333), width: 1.5),
          shape: BoxShape.circle,
        ),
        child: Center(
          child: Text(
            ['A', 'B', 'C', 'D'][index],
            style: const TextStyle(
              color: Color(0xFF8899AA),
              fontSize: 11,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      );
    }
    final correct = widget.quizBrain.currentQuestion.correctIndex;
    if (index == correct) {
      return const Icon(Icons.check_circle_rounded,
          color: Color(0xFF2ECC71), size: 24); // Ikon Hijau
    }
    if (index == _selectedIndex) {
      return const Icon(Icons.cancel_rounded,
          color: Color(0xFFFF6B35), size: 24); // Ikon Oranye
    }
    return Container(
      width: 28,
      height: 28,
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFF333333), width: 1.5),
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Text(
          ['A', 'B', 'C', 'D'][index],
          style: const TextStyle(
            color: Color(0xFF4A5568),
            fontSize: 11,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final brain = widget.quizBrain;
    final question = brain.currentQuestion;
    final cat = brain.activeCategory!;

    return Scaffold(
      backgroundColor: Colors.black, // Background Hitam Utama
      body: Stack(
        children: [
          // ── Background dekorasi ──────────────
          Positioned(
            top: -80,
            right: -80,
            child: Container(
              width: 250,
              height: 250,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _accentColor.withOpacity(0.06),
              ),
            ),
          ),

          SafeArea(
            child: Padding(
              padding:
              const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ── Top Bar ──────────────────
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: const Color(0xFF121212), // Hitam pekat
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                                color: const Color(0xFF333333), width: 1),
                          ),
                          child: const Icon(Icons.arrow_back_ios_new,
                              color: Colors.white70, size: 16),
                        ),
                      ),
                      const SizedBox(width: 14),
                      Text(
                        cat.name,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          letterSpacing: 0.3,
                        ),
                      ),
                      const Spacer(),
                      // Skor badge
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 14, vertical: 7),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              _accentColor.withOpacity(0.3),
                              _accentColor.withOpacity(0.1),
                            ],
                          ),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                              color: _accentColor.withOpacity(0.5), width: 1),
                        ),
                        child: Row(
                          children: [
                            const Text('⭐',
                                style: TextStyle(fontSize: 13)),
                            const SizedBox(width: 5),
                            Text(
                              '${brain.score}',
                              style: TextStyle(
                                color: _accentColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 24),

                  // ── Progress ─────────────────
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Soal ${brain.questionIndex + 1}/${brain.totalQuestions}',
                        style: const TextStyle(
                          color: Color(0xFF8899AA),
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        '${(brain.progress * 100).toStringAsFixed(0)}%',
                        style: TextStyle(
                          color: _accentColor,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Stack(
                    children: [
                      Container(
                        height: 6,
                        decoration: BoxDecoration(
                          color: const Color(0xFF222222), // Background progress
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 400),
                        curve: Curves.easeOut,
                        height: 6,
                        width: MediaQuery.of(context).size.width *
                            brain.progress,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              _accentColor,
                              _accentColor.withOpacity(0.6),
                            ],
                          ),
                          borderRadius: BorderRadius.circular(6),
                          boxShadow: [
                            BoxShadow(
                              color: _accentColor.withOpacity(0.4),
                              blurRadius: 6,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 28),

                  // ── Kartu Pertanyaan ─────────
                  FadeTransition(
                    opacity: _fadeAnim,
                    child: SlideTransition(
                      position: _slideAnim,
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          color: const Color(0xFF121212), // Hitam pekat
                          borderRadius: BorderRadius.circular(24),
                          border: Border.all(
                            color: _accentColor.withOpacity(0.25),
                            width: 1.5,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: _accentColor.withOpacity(0.08),
                              blurRadius: 24,
                              offset: const Offset(0, 8),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 5),
                              decoration: BoxDecoration(
                                color: _accentColor.withOpacity(0.12),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                'SOAL ${brain.questionIndex + 1}',
                                style: TextStyle(
                                  color: _accentColor,
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1.5,
                                ),
                              ),
                            ),
                            const SizedBox(height: 16),
                            Text(
                              question.questionText,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 17,
                                fontWeight: FontWeight.w600,
                                height: 1.6,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),

                  // ── Pilihan Jawaban ──────────
                  Expanded(
                    child: FadeTransition(
                      opacity: _fadeAnim,
                      child: SlideTransition(
                        position: _slideAnim,
                        child: ListView.separated(
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: question.options.length,
                          separatorBuilder: (_, __) =>
                          const SizedBox(height: 10),
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () => _onAnswerSelected(index),
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 250),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 18, vertical: 15),
                                decoration: BoxDecoration(
                                  color: _buttonColor(index),
                                  borderRadius: BorderRadius.circular(16),
                                  border: Border.all(
                                    color: _buttonBorderColor(index),
                                    width: 1.5,
                                  ),
                                  boxShadow: _answered &&
                                      index ==
                                          question.correctIndex
                                      ? [
                                    BoxShadow(
                                      color: const Color(0xFF2ECC71)
                                          .withOpacity(0.2),
                                      blurRadius: 12,
                                    )
                                  ]
                                      : [],
                                ),
                                child: Row(
                                  children: [
                                    _buttonTrailing(index),
                                    const SizedBox(width: 14),
                                    Expanded(
                                      child: Text(
                                        question.options[index],
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          height: 1.4,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}