import 'package:flutter_test/flutter_test.dart';
import 'package:init_tracker/init_order.dart';
import 'package:init_tracker/main.dart';

void main() {
  testWidgets('Structure exists', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    //MyApp() does not create the CombMan
    expect(find.text("New Initiative Order"), findsOneWidget);
  });

  testWidgets('Button creates Dialog properly', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    expect(find.byType(NewInitOrder), findsNothing);

    await tester.tap(find.text("New Initiative Order"));
    await tester.pumpAndSettle();
    expect(find.byType(NewInitOrder), findsOneWidget);

    expect(find.text("New Initiative Order"), findsOneWidget);
  });
}
