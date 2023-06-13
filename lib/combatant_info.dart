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

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (var cb in combMan!.sortedByInit.entries)
          Card(
              elevation: 10,
              color: Colors.lightGreen,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [Text(cb.key), Text(cb.value.toString())],
              )),
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
