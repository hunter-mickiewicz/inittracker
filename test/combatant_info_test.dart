import 'package:flutter_test/flutter_test.dart';
import 'package:init_tracker/combatant_info.dart';
import 'package:init_tracker/combatant_manager.dart';

void main() {
  CombatantManager combMan = CombatantManager();
  testWidgets('Structure exists', (WidgetTester tester) async {
    await tester.pumpWidget(CombatantInfo(
      combMan: combMan,
    ));

    //MyApp() does not create the CombMan
    expect(find.text("New Initiative Order"), findsOneWidget);
  });
}
