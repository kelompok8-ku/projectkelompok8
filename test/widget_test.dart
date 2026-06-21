import 'package:flutter_test/flutter_test.dart';

import 'package:travel_app/main.dart'; // Pastikan travel_app adalah nama project kamu

void main() {
  testWidgets('Cek Halaman Login', (WidgetTester tester) async {
    // Membangun aplikasi kita
    await tester.pumpWidget(const TripSnapApp());

    // Mengecek apakah ada tulisan 'TripSnap' di layar (artinya halaman login berhasil dimuat)
    expect(find.text('TripSnap'), findsWidgets);
  });
}