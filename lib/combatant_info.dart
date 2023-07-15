//This is the class which will display combatant info on the main page

import 'dart:developer';

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
  Widget combType(MapEntry<String, Combatant> cb, int i) {
    if (i == 0) {
      return LowCombatant(cb: cb);
    } else {
      return LowCombatant(cb: cb);
    }
  }

  Widget displayCombatants() {
    int i = 0;

    return SizedBox(
        child: Column(children: [
      for (var cb in combMan!.sortedByInit.entries) combType(cb, i++)
    ]));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        displayCombatants(),
        //for (var cb in combMan!.sortedByInit.entries) LowCombatant(cb: cb),
        OutlinedButton(
            onPressed: () {
              setState(() {
                combMan!.clearSorted();
              });
            },
            child: const Text("Clear Initiative")),
        OutlinedButton(onPressed: () {}, child: const Text("Next"))
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
    //return MaterialApp(home: Builder(builder: (BuildContext context) {
    return SizedBox(
        //This is potentially something that needs fixing since it's a static
        height: 60,
        child: Card(
            elevation: 10,
            color: Colors.lightGreen,
            child: ListTile(
              leading: Text(cb.key),
              title: Text(cb.value.initiative.toString()),
              subtitle: Text("Initiative: ${cb.value.initiative}"),
              //trailing: Text("trailing"),
            )));
    //}));
  }
}
