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

  test('CombatantManager.clearCombatants() clears all combatants from list',
      () {
    combMan.clearCombatants();
    expect(true, combMan.combatants?.isEmpty);
  });

  test('sortByInit functions as intended', () {
    combMan.addCombatant(Combatant("Third", 10));
    combMan.addCombatant(Combatant("Fourth", 5));
    combMan.addCombatant(Combatant("Second", 15));
    combMan.addCombatant(Combatant("Fifth", 1));
    combMan.addCombatant(Combatant("First", 20));

    combMan.sortByInit();

    expect(
        "{First: Instance of 'Combatant', Second: Instance of 'Combatant', Third: Instance of 'Combatant', Fourth: Instance of 'Combatant', Fifth: Instance of 'Combatant'}",
        combMan.sortedByInit.toString());
  });
}
