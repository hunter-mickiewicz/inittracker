import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:init_tracker/combatant.dart';
import 'package:init_tracker/combatant_manager.dart';
import 'package:init_tracker/init_order.dart';

void main() {
  CombatantManager combMan = CombatantManager();
  testWidgets('Structure exists', (WidgetTester tester) async {
    await tester.pumpWidget(NewInitOrder(combMan: combMan));
    expect(find.text("Finish"), findsOneWidget);
    expect(find.text("Name"), findsOneWidget);
    expect(find.text("Initiative"), findsNWidgets(2));
    expect(find.text("Name"), findsOneWidget);
    expect(find.text("Combatant"), findsOneWidget);
    expect(find.text("Cancel"), findsOneWidget);
    expect(find.text("Add"), findsOneWidget);
  });

  testWidgets('Empty CombatantManager means no one is listed',
      (WidgetTester tester) async {
    await tester.pumpWidget(NewInitOrder(combMan: combMan));
    expect(find.byType(ListTile), findsNothing);
  });

  testWidgets('Adding Combatant displays properly',
      (WidgetTester tester) async {
    combMan.addCombatant(Combatant("CombName", 15));
    await tester.pumpWidget(NewInitOrder(combMan: combMan));

    expect(find.byType(CombDisplay), findsOneWidget);
    expect(find.text("CombName"), findsOneWidget);
    expect(find.text("15"), findsOneWidget);
  });

  testWidgets('Add adds Combatant to CombatManager',
      (WidgetTester tester) async {
    combMan.combatants?.clear();
    await tester.pumpWidget(NewInitOrder(combMan: combMan));
    await tester.tap(find.text("Add"));

    expect(true, combMan.combatants?.isNotEmpty);
  });

  testWidgets('Cancel removes Combatants from CombatantManager',
      (WidgetTester tester) async {
    combMan.addCombatant(Combatant("CombName", 15));
    await tester.pumpWidget(NewInitOrder(combMan: combMan));
    await tester.tap(find.text("Cancel"));

    expect(true, combMan.combatants?.isEmpty);
  });

  testWidgets('Finish retains Combatants on CombatantManager',
      (WidgetTester tester) async {
    combMan.addCombatant(Combatant("CombName", 15));
    await tester.pumpWidget(NewInitOrder(combMan: combMan));
    await tester.tap(find.text("Finish"));

    expect(true, combMan.combatants?.isNotEmpty);
  });
}
