import 'package:flutter_test/flutter_test.dart';
import 'package:sports_quiz/main.dart';

void main() {
  testWidgets('App smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const SportsQuizApp());

    // Verify that our app title is present.
    expect(find.text('Sports Quiz'), findsOneWidget);
    expect(find.text('Pilih Kategori'), findsOneWidget);
  });
}