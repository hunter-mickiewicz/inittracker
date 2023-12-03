import 'dart:developer';

import 'init_order.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:init_tracker/main.dart';

import 'combatant.dart';
import 'combatant_manager.dart';

class TrackerOptions extends StatefulWidget {
  TrackerOptions({super.key});

  State<TrackerOptions> createState() => _TrackerOptionsState();
}

class _TrackerOptionsState extends State<TrackerOptions> {
  Future<void> newInitOrder() async {
    combMan?.combatants?.clear();
    await showDialog(
        context: context,
        builder: (BuildContext context) => NewInitOrder(combMan: combMan));
    setState(() {});
  }

  @override
  Widget build(BuildContext ctx) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        OutlinedButton(
            onPressed: () {
              newInitOrder();
            },
            child: const Text("Add Combatantssssss"))
      ],
    );
  }
}
