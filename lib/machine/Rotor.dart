import "dart:math";

enum RotorDirection {
  Forward,
  Backward
}

/// The [Rotor] (Walzer) was a wheeled component with cris-crossing wires
/// inside, that spun with every keypress on the Enigma machine
class Rotor {
  final List<int> mapping;
  int position = 0;
  int turnover;
  Map<String, dynamic> get json => {
    "position": position,
    "mapping": mapping,
    "turnover": turnover
  };

  List<int> get inverse =>
    List.generate(mapping.length, (i) => mapping.indexOf(i));

  String get configuration {
    var cfg = StringBuffer();

    for (int i = 0; i < mapping.length; i++) {
      var loc = (i + position) % mapping.length;
      cfg.writeln("${loc + 1} -- ${mapping[loc] + 1}");
    }

    return cfg.toString();
  }

  Rotor(int numChars) :
    mapping = List.generate(numChars, (i) => i);

  factory Rotor.random(int numChars) {
    var rng = Random();
    var r = Rotor(numChars);
    r.mapping.shuffle(rng);

    return r;
  }

  factory Rotor.fromIter(Iterable<int> iter) {
    var r = Rotor(iter.length);
    r.mapping.setRange(0, r.mapping.length, iter);
    return r;
  }

  factory Rotor.latin(String charset, String turnover) {
    var A = "A".runes.first;
    var r = Rotor.fromIter(charset.runes.map((rune) => rune - A));
    r.turnover = turnover.runes.first - A;
    return r;
  }

  factory Rotor.rotorI() => Rotor.latin("EKMFLGDQVZNTOWYHXUSPAIBRCJ", "R");
  factory Rotor.rotorII() => Rotor.latin("AJDKSIRUXBLHWTMCQGZNPYFVOE", "F");
  factory Rotor.rotorIII() => Rotor.latin("BDFHJLCPRTXVZNYEIWGAKMUSQO", "W");
  factory Rotor.rotorIV() => Rotor.latin("ESOVPZJAYQUIRHXLNFTGKDCMWB", "K");
  factory Rotor.rotorV() => Rotor.latin("VZBRGITYUPSDNHLXAWMJQOFECK", "A");

  void step() {
    mapping.insert(0, mapping.removeLast());
    position = (position + 1) % mapping.length;
  }

  void progress(int numSteps) {
    numSteps %= mapping.length;
    for (int i = 0; i < numSteps; i++) step();
  }

  void set(int newPos) => progress(newPos - position);

  int traverse(int input, [RotorDirection direction = RotorDirection.Forward]) {
    int output;
    switch (direction) {
      case RotorDirection.Forward:
        print("Rotor Mapping (Forward): ${List.from(mapping)..sort()}");
        print("Rotor Inverse (Forward): $inverse");
        output = mapping[input];
        print("Rotor (Forward): $output");
        break;

      case RotorDirection.Backward:
        output = inverse[input];
        print("Rotor Mapping (Backward): ${List.from(mapping)..sort()}");
        print("Rotor Inverse (Backward): $inverse");
        print("Rotor (Backward): $output");
        break;
    }

    return output;
  }
}
