class ReflectiveMap<T> {
  final Map<T, T> map = Map();

  ReflectiveMap();

  factory ReflectiveMap.fromMap(Map<T, T> map) {
    var rm = ReflectiveMap();
    for (var entry in map.entries) {
      rm.addEntry(entry.key, entry.value);
    }

    return rm;
  }

  T operator [](T k) => map[k];
  void operator []=(T k, T v) {
    map[k] = v;
    map[v] = k;
  }

  bool hasEntry(T k, T v) {
    return (map.containsKey(k) && map[k] == v) ||
      (map.containsKey(v) && map[v] == k);
  }

  void addEntry(T k, T v) {
    if (hasEntry(k, v)) throw Exception("Entry $k -- $v already exists");
    if (containsKey(k) || containsKey(v)) throw Exception("Duplicate key error");
    map.addAll({k: v, v: k});
  }

  bool containsKey(T k) => map.containsKey(k);
}