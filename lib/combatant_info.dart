//This is the class which will display combatant info on the main page

import 'package:flutter/material.dart';

import 'combatant.dart';
import 'combatant_manager.dart';

// ignore: must_be_immutable
class CombatantInfo extends StatefulWidget {
  CombatantInfo({super.key, required this.combMan});
  CombatantManager? combMan;

  @override
  // ignore: no_logic_in_create_state
  State<CombatantInfo> createState() => _CombatantInfoState(combMan: combMan);
}

class _CombatantInfoState extends State<CombatantInfo> {
  _CombatantInfoState({required this.combMan});

  CombatantManager? combMan;

  //displays highCombatant for first in map, as well as buttons
  void combType(Combatant cb) {
    if (combMan?.combatants?[0] == cb) {
      //LowCombatant(cb: cb);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (var cb in combMan!.sortedByInit.entries) LowCombatant(cb: cb),
        OutlinedButton(
            onPressed: () {
              setState(() {
                combMan!.clearSorted();
              });
            },
            child: const Text("Clear Initiative")),
      ],
    );
  }
}

class LowCombatant extends StatelessWidget {
  const LowCombatant({
    super.key,
    required this.cb,
  });

  final MapEntry<String, Combatant> cb;

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 10,
        color: Colors.lightGreen,
        child: ListTile(
          leading: Text(cb.key),
          title: Text(cb.value.initiative.toString()),
          subtitle: Text("Initiative: ${cb.value.initiative}"),
          trailing: Text("trailing"),
        ));
  }
}
