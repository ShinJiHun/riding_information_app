import 'package:flutter_test/flutter_test.dart';

import 'package:riding_information_app/main.dart';

void main() {
  testWidgets('App loads and shows Home screen', (WidgetTester tester) async {
    await tester.pumpWidget(const RidingApp());

    expect(find.text('RidingInformation'), findsOneWidget);
  });
}
