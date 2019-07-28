class KeyboardFormat {
  List<List<String>> layout;

  List<String> get charset {
    var flattened = <String>[];
    for (var row in layout) {
      flattened.addAll(row);
    }

    return flattened..sort();
  }

  KeyboardFormat(this.layout);

  factory KeyboardFormat.fromRows(List<String> rows) {
    var layout = List<List<String>>();
    for (var row in rows) {
      layout.add(row.split(""));
    }

    return KeyboardFormat(layout);
  }

  /// QWERTY format for most of the English-speaking world
  factory KeyboardFormat.qwerty() => KeyboardFormat.fromRows([
    "QWERTYUIOP",
    "ASDFGHJKL",
    "ZXCVBNM"
  ]);

  /// AZERTY format for France and Croatia
  factory KeyboardFormat.azerty() => KeyboardFormat.fromRows([
    "AZERTYUIOP",
    "QSDFGHJKLM",
    "WXCVBN"
  ]);

  /// QWERTZ format for German-speaking countries
  factory KeyboardFormat.qwertz() => KeyboardFormat.fromRows([
    "QWERTZUIOPÜ",
    "ASDFGHJKLÖÄ",
    "YXCVBNM"
  ]);

  /// The keyboard layout for the Enigma Machines used in WWII
  /// A modified QWERTZ format without the Umlaute and
  /// with L and P moved to the bottom row
  factory KeyboardFormat.enigma() => KeyboardFormat.fromRows([
    "QWERTZUIO",
    "ASDFGHJK",
    "PYXCVBNML"
  ]);
}