class Combatant {
  String name = "";
  int initiative = -1;
  int? health;

  Combatant(String nm, int init) {
    name = nm;
    initiative = init;
  }

  String getName() {
    return name;
  }

  Map<String, dynamic> toJson() => {'name': name, 'health': health};

  Combatant.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        health = json['health'];
}
