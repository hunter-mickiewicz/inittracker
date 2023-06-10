import 'package:flutter_test/flutter_test.dart';
import 'package:init_tracker/combatant.dart';
import 'package:init_tracker/combatant_manager.dart';

void main() {
  CombatantManager combMan = CombatantManager();
  test('Combatant Manager list starts off empty', () {
    expect(true, combMan.combatants?.isEmpty);
  });

  test('Adding combatant adds to list', () {
    combMan.addCombatant(Combatant("testName", -1));
    expect(true, combMan.combatants?.isNotEmpty);
  });

  //sort
}
