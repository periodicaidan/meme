import "Rotor.dart";
import "RotorSet.dart";
import "PlugBoard.dart";
import "Reflector.dart";

// todo: This needs a lot more APIs
class Enigma {
  final PlugBoard plugBoard;
  final RotorSet rotorSet;
  final List<String> charset;
  static const String LatinAlphabet = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
  int get numRotors => rotorSet.rotors.length;

  Enigma(Iterable<String> chars, this.plugBoard, this.rotorSet) :
    charset = chars.toList();

  factory Enigma.defaultConfig(Iterable<String> charset) {
    var e = Enigma(
      charset,
      PlugBoard(),
      RotorSet(
        charset.length,
        [Rotor.rotorI(12), Rotor.rotorII(5), Rotor.rotorIII(20)],
        Reflector.reflectorB()
      )
    );

    return e;
  }

  Enigma.builder(this.charset) :
    plugBoard = PlugBoard(),
    rotorSet = RotorSet(LatinAlphabet.length, [], Reflector());

  void addRotor(Rotor rotor, [int idx]) => rotorSet.add(rotor, idx);
  void addRotors(Iterable<Rotor> rotors) => rotorSet.addAll(rotors);

  void configure() {
    // todo
  }

  /// This is the function that does all of the encoding and decoding
  /// I'm using "codec" as a verb because there's no verb that encompasses
  /// both encoding and decoding (to my knowledge, at least)
  String codec(String input) {
    var output = charset.indexOf(input);
    output = plugBoard.traverse(output);
    output = rotorSet.traverse(output);
    output = plugBoard.traverse(output);
    return charset[output];
  }

  Map<String, dynamic> toJson() => {
    "charset": charset.join(),
    "rotors": rotorSet.rotors.map((r) => r.json).toList(),
    "reflector": rotorSet.reflector.toString(),
    "plugBoard": plugBoard.toString()
  };
}

main() {
  final enigma = Enigma.defaultConfig(Enigma.LatinAlphabet.split(""));
  var input = 'A';
  for (var i = 0; i < 1000; i++) {
    print(input);
    input = enigma.codec(input);
  }

  print(enigma.toJson());
}