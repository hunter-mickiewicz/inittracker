//This is the class which will display combatant info on the main page

// ignore_for_file: unused_import

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:init_tracker/main.dart';

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
                    child: const Text("End Fight")),
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
                            combMan?.sortedByInit[bottomComb.value.name] =
                                bottomComb.value;
                          });
                        },
                        child: const Text("Previous")),
                    OutlinedButton(
                        onPressed: () {
                          MapEntry<String, Combatant> topComb =
                              combMan?.sortedByInit.entries.elementAt(0)
                                  as MapEntry<String, Combatant>;

                          combMan?.sortedByInit.remove(topComb.value.name);

                          setState(() {
                            combMan?.sortedByInit[topComb.value.name] =
                                topComb.value;
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

class ModifyCombatant extends StatefulWidget {
  const ModifyCombatant({super.key, required this.cb, required this.combMan});

  final CombatantManager combMan;
  final Combatant cb;

  @override
  State<ModifyCombatant> createState() => _ModifyCombatantState();
}

class _ModifyCombatantState extends State<ModifyCombatant> {
  final TextEditingController _initController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  String originalName = "";
  int originalInitiative = -1;
  String newName = "";
  int newInitiative = -1;

  @override
  Widget build(BuildContext context) {
    originalName == ""
        ? originalName = widget.cb.name
        : originalName = originalName;
    originalInitiative == -1
        ? originalInitiative = widget.cb.initiative
        : originalInitiative = originalInitiative;

    return Dialog(
        child: ListView(shrinkWrap: true, children: [
      SizedBox(
        width: 200,
        child: Column(
          children: [
            TextField(
                controller: _nameController,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  label: Text("Name: $originalName"),
                ),
                onChanged: (text) {
                  setState(() {
                    newName = text;
                  });
                }),
            TextField(
                controller: _initController,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  label: Text("Initiative: $originalInitiative"),
                ),
                keyboardType: TextInputType.number,
                onChanged: (text) {
                  setState(() {
                    try {
                      // ignore: unnecessary_null_comparison
                      if (text == null) {
                        throw ("Parse Error");
                      }
                      newInitiative = int.tryParse(text)!;
                      //Doesn't update on front page
                    } catch (e) {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return Dialog(
                                child: ListView(
                              shrinkWrap: true,
                              children: [
                                Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Text(
                                          "Initiative must be a number!"),
                                      OutlinedButton(
                                          onPressed: () {
                                            setState(() {
                                              _initController.clear();
                                              Navigator.of(context,
                                                      rootNavigator: true)
                                                  .pop();
                                            });
                                          },
                                          child: const Text("Okay"))
                                    ])
                              ],
                            ));
                          });
                    }
                  });
                }),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                OutlinedButton(
                    onPressed: () {
                      newName == ""
                          ? widget.cb.name = widget.cb.name
                          : widget.cb.name = newName;
                      newInitiative == -1
                          ? widget.cb.initiative = widget.cb.initiative
                          : widget.cb.initiative = newInitiative;
                      widget.combMan.sortedByInit.remove(originalName);
                      Navigator.of(context, rootNavigator: true).pop();

                      //Removing/adding correctly
                      setState(() {
                        combMan?.sortedByInit[widget.cb.name] = widget.cb;
                      });
                      log(combMan?.sortedByInit.toString() as String);
                    },
                    child: const Text("Confirm")),
                OutlinedButton(
                    onPressed: () {
                      setState(() {
                        widget.cb.name = originalName;
                        widget.cb.initiative = originalInitiative;
                        combMan?.sortedByInit[widget.cb.name] = widget.cb;
                        Navigator.of(context, rootNavigator: true).pop();
                      });
                    },
                    child: const Text("Cancel")),
              ],
            ),
            OutlinedButton(
                onPressed: () {}, child: const Text("Delete Combatant")),
          ],
        ),
      )
    ]));
  }
}

class HighCombatant extends StatefulWidget {
  const HighCombatant({
    super.key,
    required this.cb,
  });
  final MapEntry<String, Combatant> cb;

  @override
  State<HighCombatant> createState() => _HighCombatantState();
}

class _HighCombatantState extends State<HighCombatant> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 100,
        child: Card(
          elevation: 30,
          color: const Color.fromRGBO(120, 175, 54, 1),
          child: ListTile(
            leading: Text(widget.cb.key),
            title: Text(widget.cb.value.initiative.toString()),
            subtitle: Text("Initiative: ${widget.cb.value.initiative}"),
            onTap: () {
              setState(() {
                showDialog(
                    context: context,
                    builder: (BuildContext context) => ModifyCombatant(
                          cb: widget.cb.value,
                          combMan: combMan as CombatantManager,
                        ));
              });
            },
          ),
        ));
  }
}

class LowCombatant extends StatefulWidget {
  const LowCombatant({
    super.key,
    required this.cb,
  });

  final MapEntry<String, Combatant> cb;

  @override
  State<LowCombatant> createState() => _LowCombatantState();
}

class _LowCombatantState extends State<LowCombatant> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 60,
        width: 200,
        child: Card(
            elevation: 10,
            color: const Color.fromRGBO(139, 195, 74, 1),
            child: ListTile(
              leading: Text(widget.cb.key),
              title: Text(widget.cb.value.initiative.toString()),
              subtitle: Text("Initiative: ${widget.cb.value.initiative}"),
              onTap: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) => ModifyCombatant(
                          cb: widget.cb.value,
                          combMan: combMan as CombatantManager,
                        ));
              },
            )));
  }
}
