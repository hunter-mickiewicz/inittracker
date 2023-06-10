import 'package:flutter_test/flutter_test.dart';
import 'package:init_tracker/combatant.dart';

void main() {
  test('Initializer modifies variables correctly', () {
    Combatant cb = Combatant("test", 15);

    expect(true, cb.name == "test");
    expect(true, cb.initiative == 15);
  });
}
