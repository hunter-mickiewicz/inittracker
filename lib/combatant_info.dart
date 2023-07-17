//This is the class which will display combatant info on the main page

// ignore_for_file: unused_import

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
      return HighCombatant(cb: cb);
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
    return Directionality(
      textDirection: TextDirection.ltr,
      child: ListView(
        shrinkWrap: true,
        children: [
          displayCombatants(),
          //for (var cb in combMan!.sortedByInit.entries) LowCombatant(cb: cb),
          Column(
            children: [
              if (combMan!.sortedByInit.isNotEmpty)
                OutlinedButton(
                    onPressed: () {
                      setState(() {
                        combMan!.clearSorted();
                      });
                    },
                    child: const Text("Clear Initiative")),
              if (combMan!.sortedByInit.isNotEmpty)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    OutlinedButton(
                        onPressed: () {
                          int mapLength =
                              combMan!.sortedByInit.entries.length - 1;
                          MapEntry<String, Combatant> bottomComb =
                              combMan?.sortedByInit.entries.elementAt(mapLength)
                                  as MapEntry<String, Combatant>;

                          combMan?.sortedByInit.remove(bottomComb.key);

                          CombatantManager newCombMan = CombatantManager();

                          newCombMan.sortedByInit[bottomComb.value.name] =
                              bottomComb.value;

                          for (var cb in combMan!.sortedByInit.entries) {
                            newCombMan.sortedByInit[cb.value.name] = cb.value;
                          }

                          combMan = newCombMan;

                          setState(() {
                            combMan?.sortedByInit[bottomComb.key] =
                                bottomComb.value;
                          });
                        },
                        child: const Text("Previous")),
                    OutlinedButton(
                        onPressed: () {
                          MapEntry<String, Combatant> topComb =
                              combMan?.sortedByInit.entries.elementAt(0)
                                  as MapEntry<String, Combatant>;

                          combMan?.sortedByInit.remove(topComb.key);

                          setState(() {
                            combMan?.sortedByInit[topComb.key] = topComb.value;
                          });
                        },
                        child: const Text("Next")),
                  ],
                ),
            ],
          )
        ],
      ),
    );
  }
}

class HighCombatant extends StatelessWidget {
  const HighCombatant({
    super.key,
    required this.cb,
  });
  final MapEntry<String, Combatant> cb;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 100,
        child: Card(
            elevation: 30,
            color: const Color.fromRGBO(120, 175, 54, 1),
            child: ListTile(
              leading: Text(cb.key),
              title: Text(cb.value.initiative.toString()),
              subtitle: Text("Initiative: ${cb.value.initiative}"),
            )));
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
    return SizedBox(
        height: 60,
        width: 200,
        child: Card(
            elevation: 10,
            color: const Color.fromRGBO(139, 195, 74, 1),
            child: ListTile(
              leading: Text(cb.key),
              title: Text(cb.value.initiative.toString()),
              subtitle: Text("Initiative: ${cb.value.initiative}"),
              onTap: () {},
            )));
  }
}
