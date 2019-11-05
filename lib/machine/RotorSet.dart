import "Rotor.dart";
import "Reflector.dart";

class RotorSet {
  final List<Rotor> rotors;
  final Reflector reflector;
  Rotor get entryRotor => rotors.first;

  RotorSet(int numChars, this.rotors, this.reflector);

  void add(Rotor rotor, [int idx]) =>
    idx == null ? rotors.add(rotor) : rotors.insert(idx, rotor);

  void addAll(Iterable<Rotor> rotors) {
    for (var rotor in rotors) {
      add(rotor);
    }
  }

  void step() {
    entryRotor.step();

    int i = 1;
    var current = entryRotor;

    while (current.position == current.turnover && i < rotors.length) {
      var next = rotors[i++];
      next.step();
      current = next;
    }
  }

  int traverse(int input) {
    var output = input;
    for (var rotor in rotors) output = rotor.traverse(output);
    output = reflector.traverse(output);
    for (var rotor in rotors.reversed)
      output = rotor.traverse(output, RotorDirection.Backward);

    step();
    return output;
  }
}