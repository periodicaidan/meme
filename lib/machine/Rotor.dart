import "dart:math";

enum RotorDirection {
  Forward,
  Backward
}

/// The [Rotor] (Walzer) was a wheeled component with cris-crossing wires
/// inside, that spun with every keypress on the Enigma machine
class Rotor {
  final List<int> mapping;
  int startPosition;
  int position;
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

  Rotor(int numChars, [int startPosition = 0]) :
    mapping = List.generate(numChars, (i) => i) {
    this.startPosition = startPosition;
    position = this.startPosition;
  }

  factory Rotor.random(int numChars) {
    var rng = Random();
    var r = Rotor(numChars);
    r.mapping.shuffle(rng);

    return r;
  }

  factory Rotor.fromIter(Iterable<int> iter, [int startPosition = 0]) {
    var r = Rotor(iter.length, startPosition);
    r.mapping.setRange(0, r.mapping.length, iter);
    return r;
  }

  factory Rotor.latin(String charset, String turnover, [int startPosition = 0]) {
    var A = "A".runes.first;
    var r = Rotor.fromIter(charset.runes.map((rune) => rune - A), startPosition);
    r.turnover = turnover.runes.first - A;
    return r;
  }

  factory Rotor.rotorI([int startPosition = 0]) =>
    Rotor.latin("EKMFLGDQVZNTOWYHXUSPAIBRCJ", "R", startPosition);
  factory Rotor.rotorII([int startPosition = 0]) =>
    Rotor.latin("AJDKSIRUXBLHWTMCQGZNPYFVOE", "F", startPosition);
  factory Rotor.rotorIII([int startPosition = 0]) =>
    Rotor.latin("BDFHJLCPRTXVZNYEIWGAKMUSQO", "W", startPosition);
  factory Rotor.rotorIV([int startPosition = 0]) =>
    Rotor.latin("ESOVPZJAYQUIRHXLNFTGKDCMWB", "K", startPosition);
  factory Rotor.rotorV([int startPosition = 0]) =>
    Rotor.latin("VZBRGITYUPSDNHLXAWMJQOFECK", "A", startPosition);

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
        output = mapping[input];
        break;

      case RotorDirection.Backward:
        output = inverse[input];
        break;
    }

    return output;
  }

  void reset() => this.position = this.startPosition;
}
