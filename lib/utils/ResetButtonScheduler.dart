import "package:flutter/material.dart";
import "package:flutter/foundation.dart";
import "../machine/Enigma.dart";

class ResetButtonScheduler with ChangeNotifier {
  bool active = false;
  final Enigma enigma;

  ResetButtonScheduler(this.enigma);

  void activate() {
    enigma.rotorSet.reset();
    notifyListeners();
  }
}