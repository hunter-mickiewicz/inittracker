import 'package:init_tracker/combatant.dart';

class CombatantManager {
  List<Combatant>? combatants;
  Map<String, Combatant> sortedByInit = {};

  CombatantManager() {
    combatants = <Combatant>[];
  }

  void addCombatant(Combatant comb) {
    combatants?.add(comb);
  }

  void clearCombatants() {
    combatants?.clear();
  }

  void clearSorted() {
    sortedByInit.clear();
  }

  void sortByInit() {
    for (Combatant comb in combatants!) {
      sortedByInit[comb.name] = comb;
    }

    sortedByInit = Map.fromEntries(sortedByInit.entries.toList()
      ..sort((e2, e1) => e1.value.initiative.compareTo(e2.value.initiative)));
  }
}
