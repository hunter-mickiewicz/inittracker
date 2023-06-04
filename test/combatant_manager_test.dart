import 'package:flutter_test/flutter_test.dart';
import 'package:init_tracker/combatant_manager.dart';

void main() {
  test('Combatant Manager list starts off empty', () {
    CombatantManager combMan = CombatantManager();
    expect(true, combMan.combatants?.isEmpty);
  });
}
