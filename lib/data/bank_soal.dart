import '../models/pertanyaan.dart';
import '../models/category.dart';

class QuestionBank {
  static List<QuizCategory> get categories =>
      [

        // ─────────────────────────────────────────
        //  KATEGORI 1: LARI / RUNNING
        // ─────────────────────────────────────────
        QuizCategory(
          id: 'running',
          name: 'Lari/Running',
          icon: '🏃',
          imagePath: 'assets/images/running.jpg',
          questions: [
            Question(
              questionText: 'Lari jarak pendek disebut juga dengan?',
              options: [
                'a. Marathon',
                'b. Sprint',
                'c. Jogging',
                'd. Hiking',
              ],
              correctIndex: 1,
            ),
            Question(
              questionText: 'Berapa jarak lari marathon?',
              options: [
                'a. 21 Km',
                'b. 30 Km',
                'c. 42 Km',
                'd. 50 Km',
              ],
              correctIndex: 2,
            ),
            Question(
              questionText: 'Lari jarak menengah biasanya mencakup jarak?',
              options: [
                'a. 100m - 200m',
                'b. 400m - 800m',
                'c. 800m - 1500m',
                'd. 5 Km',
              ],
              correctIndex: 2,
            ),
            Question(
              questionText: 'Tujuan utama pemanasan sebelum lari adalah?',
              options: [
                'a. Membuat lelah',
                'b. Mencegah cidera',
                'c. Mengurangi napas',
                'd. Menambah berat badan',
              ],
              correctIndex: 1,
            ),
            Question(
              questionText: 'Gerakan kaki yang benar saat lari adalah?',
              options: [
                'a. Menghentak keras',
                'b. Diseret',
                'c. Ringan dan teratur',
                'd. Diangkat tinggi-tinggi',
              ],
              correctIndex: 2,
            ),
            Question(
              questionText: 'Sepatu yang digunakan untuk lari sebaiknya?',
              options: [
                'a. Sandal',
                'b. Sepatu formal',
                'c. Sepatu olahraga',
                'd. Sepatu boots',
              ],
              correctIndex: 2,
            ),
            Question(
              questionText: 'Lari santai dengan kecepatan rendah disebut?',
              options: [
                'a. Sprint',
                'b. Jogging',
                'c. Marathon',
                'd. Lompat Jauh',
              ],
              correctIndex: 1,
            ),
            Question(
              questionText: 'Bagian tubuh yang paling aktif saat lari adalah?',
              options: [
                'a. Mata',
                'b. Kaki',
                'c. Telinga',
                'd. Hidung',
              ],
              correctIndex: 1,
            ),
            Question(
              questionText: 'Manfaat utama olahraga lari adalah?',
              options: [
                'a. Menambah stress',
                'b. Menjaga kesehatan jantung',
                'c. Membuat lelah saja',
                'd. Mengurangi tinggi badan',
              ],
              correctIndex: 1,
            ),
            Question(
              questionText: 'Teknik pernapasan saat lari yang baik adalah?',
              options: [
                'a. Ditahan',
                'b. Tidak teratur',
                'c. Teratur dan dalam',
                'd. Cepat dan pendek',
              ],
              correctIndex: 2,
            ),
          ],
        ),

        // ─────────────────────────────────────────
        //  KATEGORI 2: BOLA BASKET
        // ─────────────────────────────────────────
        QuizCategory(
          id: 'basketball',
          name: 'Bola Basket',
          icon: '🏀',
          imagePath: 'assets/images/basketball.jpg',
          questions: [
            Question(
              questionText: 'Berapa jumlah pemain dalam satu tim basket di lapangan?',
              options: [
                'a. 4 pemain',
                'b. 5 pemain',
                'c. 6 pemain',
                'd. 7 pemain',
              ],
              correctIndex: 1,
            ),
            Question(
              questionText: 'Teknik dasar menggiring bola dalam basket disebut?',
              options: [
                'a. Passing',
                'b. Shooting',
                'c. Dribbling',
                'd. Blocking',
              ],
              correctIndex: 2,
            ),
            Question(
              questionText: 'Organisasi internasional yang mengatur olahraga basket adalah?',
              options: [
                'a. FIFA',
                'b. NBA',
                'c. IOC',
                'd. FIBA',
              ],
              correctIndex: 3,
            ),
            Question(
              questionText: 'Lama waktu permainan bola basket (FIBA) dalam satu pertandingan adalah?',
              options: [
                'a. 2 × 20 Menit',
                'b. 4 × 10 Menit',
                'c. 4 × 12 Menit',
                'd. 2 × 15 Menit',
              ],
              correctIndex: 1,
            ),
            Question(
              questionText: 'Lemparan ke dalam permainan setelah bola keluar lapangan disebut?',
              options: [
                'a. Free Throw',
                'b. Jump Ball',
                'c. Throw In',
                'd. Rebound',
              ],
              correctIndex: 2,
            ),
            Question(
              questionText: 'Nilai tembakan dari luar garis tiga poin adalah?',
              options: [
                'a. 1 Poin',
                'b. 2 Poin',
                'c. 3 Poin',
                'd. 4 Poin',
              ],
              correctIndex: 2,
            ),
            Question(
              questionText: 'Pelanggaran berjalan tanpa menggiring bola disebut?',
              options: [
                'a. Double Dribble',
                'b. Traveling',
                'c. Charging',
                'd. Blocking',
              ],
              correctIndex: 1,
            ),
            Question(
              questionText: 'Istilah untuk menangkap bola pantul dari ring disebut?',
              options: [
                'a. Assist',
                'b. Rebound',
                'c. Steal',
                'd. Dunk',
              ],
              correctIndex: 1,
            ),
            Question(
              questionText: 'Teknik mengoper bola kepada teman satu tim disebut?',
              options: [
                'a. Shooting',
                'b. Passing',
                'c. Dribbling',
                'd. Pivot',
              ],
              correctIndex: 1,
            ),
            Question(
              questionText: 'Posisi pemain yang bertugas mengatur serangan adalah?',
              options: [
                'a. Center',
                'b. Power Forward',
                'c. Point Guard',
                'd. Small Forward',
              ],
              correctIndex: 2,
            ),
          ],
        ),

        // ─────────────────────────────────────────
        //  KATEGORI 3: SEPAK BOLA
        //  Isi soal sepak bola di sini
        // ─────────────────────────────────────────
        QuizCategory(
          id: 'football',
          name: 'Sepak Bola',
          icon: '⚽',
          imagePath: 'assets/images/football.jpg',
          questions: [
            Question(
              questionText: 'Berapa lama sepak bola dimainkan dalam 1 pertandingan?',
              options: [
                'a. 45 Menit',
                'b. 25 Menit',
                'c. 60 Menit',
                'd. 90 Menit',
              ],
              correctIndex: 3,
            ),
            Question(
              questionText: 'Red Devil merupakan julukan untuk club apa?',
              options: [
                'a. Liverpool',
                'b. AC Milan',
                'c. Manchester United',
                'd. PSV',
              ],
              correctIndex: 2,
            ),
            Question(
              questionText: 'Klub mana yang berhasil hat-trick juara UCL (3 kali berturut-turut)?',
              options: [
                'a. Real Madrid',
                'b. Manchester City',
                'c. Bayern Munchen',
                'd. PSG',
              ],
              correctIndex: 0,
            ),
            Question(
              questionText: 'Siapa yang dijuluki "The King" di dunia sepak bola?',
              options: [
                'a. Lional Messi',
                'b. Pele',
                'c. Maradona',
                'd. Cristiano Ronaldo',
              ],
              correctIndex: 1,
            ),
            Question(
              questionText: 'Klub apa yang punya julukan "The Gunners"?',
              options: [
                'a. Arsenal',
                'b. Barcelona',
                'c. Tottenham',
                'd. Chelsea',
              ],
              correctIndex: 0,
            ),
            Question(
              questionText: 'Tim nasional negara mana yang memiliki trofi piala dunia terbanyak?',
              options: [
                'a. Perancis',
                'b. Argentina',
                'c. Brazil',
                'd. Jerman',
              ],
              correctIndex: 2,
            ),
            Question(
              questionText: 'Siapa pelatih yang dijuluki "The Special One"?',
              options: [
                'a. Pep Guardiola',
                'b. Zinaden Zidan',
                'c. Jose Mourinho',
                'd. Jurgen Klopp',
              ],
              correctIndex: 2,
            ),
            Question(
              questionText: 'Siapa pemain yang memenangkan Super Ballon dOr?',
              options: [
              'a. Bob Charlton',
              'b. Alfredo Di Stéfano',
              'c. Lionel Messi',
              'd. Lev Yashin',
              ],
              correctIndex: 1,
            ),
            Question(
              questionText: 'Apa nama organisasi sepakbola asia?',
              options: [
                'a. AFC',
                'b. Uefa',
                'c. Conmebol',
                'd. Concacaf',
              ],
              correctIndex: 0,
            ),
            Question(
              questionText: 'Klub mana yang memiliki gelar ACL (sekarang AFC Champions League Elite) terbanyak?',
              options: [
                'a. Al-Ain',
                'b. Pohang Steelers',
                'c. Al-Hilal',
                'd. Urawa Red Diamonds',
              ],
              correctIndex: 2,
            ),
            Question(
              questionText: 'Siapa kapten timnas indonesia saat ini?',
              options: [
                'a. Emil Audero',
                'b. Marten Paes',
                'c. Kevin Diks',
                'd. Jay Idzes',
              ],
              correctIndex: 3,
            ),
          ],
        ),
      ];
}