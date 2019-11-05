class PlugBoard {
  final Map<int, int> connections = Map();
  int get totalConnections => connections.length;

  PlugBoard();

  PlugBoard.fromPairs(String spaceSeparatedPairs) {
    var A = "A".runes.first;
    connections.addEntries(spaceSeparatedPairs.split(" ").map((s) {
      var chars = s.runes.toList();
      return MapEntry(chars[0] - A, chars[1] - A);
    }));
  }

  bool isPlugged(int plug) {
    return connections.containsKey(plug) || connections.containsValue(plug);
  }

  bool hasConnection(int from, int to) {
    return (connections.containsKey(from) && connections[from] == to) ||
      (connections.containsKey(to) && connections[to] == from);
  }

  void connect(int from, int to) {
    if (from == to) {
      throw ArgumentError("Cannot connect a plug to itself");
    }

    if (isPlugged(from) || isPlugged(to)) {
      throw Exception("One or both slots are occupied");
    }

    connections.addAll({from: to, to: from});
  }

  void disconnect(int from, int to) {
    connections.removeWhere((k, v) =>
      (k == from && v == to) || (k == to && v == from)
    );
  }

  void reconnect(int originalPlug, int newPlug) {
    connections.forEach((k, v) {
      if (k == originalPlug) {
        k = newPlug;
      } else if (v == originalPlug) {
        v = newPlug;
      }
    });
  }

  int traverse(int input) =>
    isPlugged(input) ? connections[input] : input;

  @override
  String toString() {
    var strbuf = StringBuffer();
    var A = "A".runes.first;
    for (var entry in connections.entries) {
      strbuf.writeCharCode(entry.key + A);
      strbuf.writeCharCode(entry.value + A);
      strbuf.write(" ");
    }

    return strbuf.toString().trim();
  }
}