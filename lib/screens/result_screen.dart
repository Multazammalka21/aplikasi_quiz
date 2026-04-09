import 'package:flutter/material.dart';
import '../models/quiz_brain.dart';
import 'quiz_screen.dart';
import 'home_screen.dart';

class ResultScreen extends StatefulWidget {
  final QuizBrain quizBrain;

  const ResultScreen({super.key, required this.quizBrain});

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animController;
  late Animation<double> _fadeAnim;
  late Animation<double> _scaleAnim;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    _fadeAnim = CurvedAnimation(
      parent: _animController,
      curve: Curves.easeOut,
    );
    _scaleAnim = Tween<double>(begin: 0.85, end: 1.0).animate(
      CurvedAnimation(parent: _animController, curve: Curves.elasticOut),
    );
    _animController.forward();
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  // Disesuaikan agar tetap berputar di Oranye dan Hijau
  Color get _accentColor {
    const map = {
      'running': Color(0xFFFF6B35),
      'football': Color(0xFF2ECC71),
      'motorsport': Color(0xFFFF6B35),
      'basketball': Color(0xFF2ECC71),
    };
    return map[widget.quizBrain.activeCategory?.id] ?? const Color(0xFF2ECC71);
  }

  // Skor baik = Hijau, Skor kurang = Oranye
  Color _scoreColor(double pct) {
    if (pct >= 0.6) return const Color(0xFF2ECC71);
    return const Color(0xFFFF6B35);
  }

  String _resultEmoji(double pct) {
    if (pct == 1.0) return '🏆';
    if (pct >= 0.8) return '🌟';
    if (pct >= 0.6) return '👍';
    if (pct >= 0.4) return '📚';
    return '💪';
  }

  @override
  Widget build(BuildContext context) {
    final score = widget.quizBrain.score;
    final total = widget.quizBrain.totalQuestions;
    final pct = score / total;
    final label = widget.quizBrain.getResultLabel();
    final cat = widget.quizBrain.activeCategory!;

    return Scaffold(
      // Bungkus body dengan Container untuk gradasi background
      body: Container(
        decoration: BoxDecoration(
          // ── PERPADUAN BACKGROUND HITAM, ORANYE, DAN HIJAU ──
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            stops: const [0.0, 0.5, 1.0],
            colors: [
              const Color(0xFFFF6B35).withOpacity(0.2), // Oranye (Kiri atas)
              Colors.black,                             // Hitam (Tengah)
              const Color(0xFF2ECC71).withOpacity(0.2), // Hijau (Kanan bawah)
            ],
          ),
        ),
        child: Stack(
          children: [
            // ── Background Dekorasi Tambahan (Glow) ──────────────
            Positioned(
              top: -100,
              left: -100,
              child: Container(
                width: 300,
                height: 300,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color(0xFFFF6B35).withOpacity(0.15), // Glow Oranye
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFFFF6B35).withOpacity(0.2),
                      blurRadius: 60,
                      spreadRadius: 30,
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: -80,
              right: -80,
              child: Container(
                width: 260,
                height: 260,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color(0xFF2ECC71).withOpacity(0.15), // Glow Hijau
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF2ECC71).withOpacity(0.2),
                      blurRadius: 60,
                      spreadRadius: 30,
                    ),
                  ],
                ),
              ),
            ),

            SafeArea(
              child: Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                child: Column(
                  children: [
                    // ── Top label ────────────────
                    FadeTransition(
                      opacity: _fadeAnim,
                      child: Row(
                        children: [
                          Container(
                            width: 4,
                            height: 20,
                            decoration: BoxDecoration(
                              color: _accentColor,
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                          const SizedBox(width: 10),
                          const Text(
                            'HASIL KUIS',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 2,
                            ),
                          ),
                          const Spacer(),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              color: _accentColor.withOpacity(0.12),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                  color: _accentColor.withOpacity(0.3)),
                            ),
                            child: Text(
                              cat.name,
                              style: TextStyle(
                                color: _accentColor,
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const Spacer(),

                    // ── Skor utama ───────────────
                    ScaleTransition(
                      scale: _scaleAnim,
                      child: FadeTransition(
                        opacity: _fadeAnim,
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(vertical: 36),
                          decoration: BoxDecoration(
                            color: const Color(0xFF161B2E), // Warna Kartu Asli
                            borderRadius: BorderRadius.circular(28),
                            border: Border.all(
                              color: _scoreColor(pct).withOpacity(0.3),
                              width: 1.5,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: _scoreColor(pct).withOpacity(0.12),
                                blurRadius: 30,
                                offset: const Offset(0, 10),
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              Text(
                                _resultEmoji(pct),
                                style: const TextStyle(fontSize: 52),
                              ),
                              const SizedBox(height: 16),
                              Text(
                                label,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 0.3,
                                ),
                              ),
                              const SizedBox(height: 24),

                              // Skor besar
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    '$score',
                                    style: TextStyle(
                                      color: _scoreColor(pct),
                                      fontSize: 72,
                                      fontWeight: FontWeight.bold,
                                      height: 1,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 10),
                                    child: Text(
                                      ' / $total',
                                      style: const TextStyle(
                                        color: Color(0xFF4A5568),
                                        fontSize: 28,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 6),
                              Text(
                                'Jawaban Benar',
                                style: TextStyle(
                                  color: Colors.white.withOpacity(0.4),
                                  fontSize: 13,
                                ),
                              ),

                              const SizedBox(height: 24),

                              // Progress bar skor
                              Padding(
                                padding:
                                const EdgeInsets.symmetric(horizontal: 32),
                                child: Column(
                                  children: [
                                    Stack(
                                      children: [
                                        Container(
                                          height: 8,
                                          decoration: BoxDecoration(
                                            color: const Color(0xFF1E2738),
                                            borderRadius:
                                            BorderRadius.circular(8),
                                          ),
                                        ),
                                        FractionallySizedBox(
                                          widthFactor: pct,
                                          child: Container(
                                            height: 8,
                                            decoration: BoxDecoration(
                                              gradient: LinearGradient(
                                                colors: [
                                                  _scoreColor(pct),
                                                  _scoreColor(pct)
                                                      .withOpacity(0.6),
                                                ],
                                              ),
                                              borderRadius:
                                              BorderRadius.circular(8),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: _scoreColor(pct)
                                                      .withOpacity(0.4),
                                                  blurRadius: 8,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 10),
                                    Text(
                                      '${(pct * 100).toStringAsFixed(0)}% Benar',
                                      style: TextStyle(
                                        color: _scoreColor(pct),
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    const Spacer(),

                    // ── Tombol ───────────────────
                    FadeTransition(
                      opacity: _fadeAnim,
                      child: Column(
                        children: [
                          // Ulangi kuis
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {
                                widget.quizBrain.reset();
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => QuizScreen(
                                        quizBrain: widget.quizBrain),
                                  ),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: _accentColor,
                                foregroundColor: Colors.white,
                                padding:
                                const EdgeInsets.symmetric(vertical: 16),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                elevation: 0,
                                shadowColor: _accentColor.withOpacity(0.5),
                              ),
                              child: const Text(
                                '🔄  Ulangi Kuis',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 0.3,
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(height: 12),

                          // Pilih kategori lain
                          SizedBox(
                            width: double.infinity,
                            child: OutlinedButton(
                              onPressed: () {
                                widget.quizBrain.resetToHome();
                                Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => HomeScreen(
                                        quizBrain: widget.quizBrain),
                                  ),
                                      (route) => false,
                                );
                              },
                              style: OutlinedButton.styleFrom(
                                foregroundColor: Colors.white70,
                                side: BorderSide(
                                  color: const Color(0xFF2A3350),
                                  width: 1.5,
                                ),
                                padding:
                                const EdgeInsets.symmetric(vertical: 16),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                              ),
                              child: const Text(
                                '🏠  Pilih Kategori Lain',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: 0.3,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 8),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}