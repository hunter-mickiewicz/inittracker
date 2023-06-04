import 'package:init_tracker/combatant.dart';

class CombatantManager {
  List<Combatant>? combatants;

  CombatantManager() {
    combatants = <Combatant>[];
  }

  void addCombatant(Combatant comb) {
    combatants?.add(comb);
  }
}
