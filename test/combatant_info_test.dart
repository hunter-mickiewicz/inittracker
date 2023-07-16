// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:init_tracker/combatant.dart';
import 'package:init_tracker/combatant_info.dart';
import 'package:init_tracker/combatant_manager.dart';

void main() {
  CombatantManager combMan = CombatantManager();
  Combatant comb1 = Combatant("test1", 20);
  Combatant comb2 = Combatant("test2", 15);
  Combatant comb3 = Combatant("test3", 10);

  combMan.addCombatant(comb1);
  combMan.addCombatant(comb2);
  combMan.addCombatant(comb3);

  /*testWidgets('Structure exists', (WidgetTester tester) async {
    await tester.pumpWidget(CombatantInfo(combMan: combMan));

    expect(find.byType(HighCombatant), findsOneWidget);
  });*/
}
