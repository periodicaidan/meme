import "package:flutter/material.dart";

import "package:enigma/machine/Enigma.dart";

class EnigmaButtonScheduler with ChangeNotifier {
  bool active = false;
  String inputChar;
  String outputChar;
  final Enigma enigma;

  EnigmaButtonScheduler(this.enigma);

  void activate(String char) {
    active = true;
    inputChar = char;
    outputChar = enigma.codec(char);

    notifyListeners();
  }

  void deactivate() {
    active = false;
    inputChar = null;
    outputChar = null;

    notifyListeners();
  }
}