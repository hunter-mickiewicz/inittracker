// ignore_for_file: library_private_types_in_public_api, must_be_immutable

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:init_tracker/combatant_manager.dart';

import 'combatant.dart';

class CombDisplay extends StatefulWidget {
  CombDisplay({super.key, required this.comb});
  Combatant? comb;

  @override
  State<CombDisplay> createState() => _CombDisplayState();
}

class _CombDisplayState extends State<CombDisplay> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(widget.comb!.name),
          Text(widget.comb!.initiative.toString())
        ],
      ),
    );
  }
}

class NewInitOrder extends StatefulWidget {
  NewInitOrder({super.key, required this.combMan});

  CombatantManager? combMan;

  @override
  // ignore: no_logic_in_create_state
  _NewInitOrderState createState() => _NewInitOrderState(combMan: combMan);
}

class _NewInitOrderState extends State<NewInitOrder> {
  _NewInitOrderState({required this.combMan});

  CombatantManager? combMan;

  String combName = "";
  int combInit = -1;
  final TextEditingController _initController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    List<Combatant>? combatants = combMan?.combatants;

    return MaterialApp(home: Builder(builder: (BuildContext context) {
      return Dialog(
        child: ListView(
          shrinkWrap: true,
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (combatants != null)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [Text("Name"), Text("Initiative")],
                  ),
                if (combatants != null)
                  for (var comb in combatants)
                    Card(
                      child: Builder(
                        builder: (context) {
                          return CombDisplay(comb: comb);
                        },
                      ),
                    ),
                const Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _nameController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          label: Text("Combatant"),
                        ),
                        onChanged: (text) {
                          setState(() {
                            combName = text;
                          });
                        },
                      ),
                    ),
                    Expanded(
                      child: TextField(
                        controller: _initController,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            label: Text("Initiative")),
                        keyboardType: TextInputType.number,
                        onChanged: (init) {
                          setState(() {
                            try {
                              if (init == null) {
                                throw ("Parse Error");
                              }
                              combInit = int.tryParse(init)!;
                            } catch (e) {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return Dialog(
                                        child: ListView(
                                      shrinkWrap: true,
                                      children: [
                                        Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              const Text(
                                                  "Initiative must be a number!"),
                                              OutlinedButton(
                                                  onPressed: () {
                                                    setState(() {
                                                      _initController.clear();
                                                      Navigator.of(context,
                                                              rootNavigator:
                                                                  true)
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
                        },
                      ),
                    ),
                    OutlinedButton(
                        onPressed: () {
                          Combatant newComb = Combatant(combName, combInit);
                          setState(() {
                            combMan?.addCombatant(newComb);
                            _initController.clear();
                            _nameController.clear();
                          });
                          combName = "";
                          combInit = -1;
                        },
                        child: const Text("Add"))
                  ],
                ),
                const Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    OutlinedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text("Finish")),
                    OutlinedButton(
                        onPressed: () {
                          combMan?.combatants?.clear();
                          Navigator.pop(context);
                        },
                        child: const Text("Cancel"))
                  ],
                )
              ],
            ),
          ],
        ),
      );
    }));
  }
}
