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
    log(widget.comb!.name);
    log(widget.comb!.initiative.toString());

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
  _NewInitOrderState createState() => _NewInitOrderState(combMan: combMan);
}

class _NewInitOrderState extends State<NewInitOrder> {
  _NewInitOrderState({required this.combMan});

  CombatantManager? combMan;

  String combName = "";
  int combInit = -1;

  @override
  Widget build(BuildContext context) {
    List<Combatant>? combatants = combMan?.combatants;
    var _controller = TextEditingController();

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
                      //controller: _controller,
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
                      //controller: _controller,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          label: Text("Initiative")),
                      keyboardType: TextInputType.number,
                      onChanged: (init) {
                        setState(() {
                          combInit = int.tryParse(init)!;
                        });
                      },
                    ),
                  ),
                  OutlinedButton(
                      onPressed: () {
                        Combatant newComb = Combatant(combName, combInit);
                        setState(() {
                          combMan?.addCombatant(newComb);
                          _controller.clear();
                        });
                        combName = "";
                        combInit = -1;
                      },
                      child: const Text("Add"))
                ],
              ),
              const Divider(),
              OutlinedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("Finish"))
            ],
          ),
        ],
      ),
    );
  }
}
