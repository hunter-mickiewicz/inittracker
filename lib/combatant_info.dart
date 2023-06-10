//This is the class which will display combatant info on the main page

import 'package:flutter/material.dart';

import 'combatant.dart';

// ignore: must_be_immutable
class CombatantInfo extends StatefulWidget {
  CombatantInfo({super.key, required this.comb});
  Combatant? comb;

  @override
  State<CombatantInfo> createState() => _CombatantInfoState();
}

class _CombatantInfoState extends State<CombatantInfo> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}
