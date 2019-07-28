import "ReflectiveMap.dart";

class Reflector extends ReflectiveMap<int> {
  Reflector() : super();

  factory Reflector.fromPairs(Iterable<String> pairs) {
    var A = "A".runes.first;
    var r = Reflector();
    for (var pair in pairs) {
      assert (pair.length == 2);
      var chars = pair.runes.toList();
      r.addEntry(chars[0] - A, chars[1] - A);
    }

    return r;
  }

  factory Reflector.fromMap(Map<int, int> map) {
    var r = Reflector();
    for (var entry in map.entries) {
      r.addEntry(entry.key, entry.value);
    }

    return r;
  }

  factory Reflector.fromString(String spaceSeparatedPairs) =>
    Reflector.fromPairs(spaceSeparatedPairs.split(" "));

  factory Reflector.reflectorB() =>
    Reflector.fromString("AY BR CU DH EQ FS GL IP JX KN MO TZ VW");
  
  factory Reflector.reflectorC() =>
    Reflector.fromString("AF BV CP DJ EI GO HY KR LZ MX NW TQ SU");

  factory Reflector.reflectorBThin() =>
    Reflector.fromString("AE BN CK DQ FU GY HW IJ LO MP RX SZ TV");
  
  factory Reflector.reflectorCThin() =>
    Reflector.fromString("AR BD CO EJ FN GT HK IV LM PW QZ SX UY");

  int traverse(int input) {
    print("Reflector: $input");
    return this[input];
  }

  @override
  String toString() {
    var strbuf = StringBuffer();
    var added = [];
    var A = "A".runes.first;
    for (var entry in map.entries) {
      if (!added.contains(entry.key) && !added.contains(entry.value)) {
        strbuf.writeCharCode(entry.key + A);
        strbuf.writeCharCode(entry.value + A);
        strbuf.write(" ");
        added.addAll([entry.key, entry.value]);
      }
    }

    return strbuf.toString().trim();
  }
}