import "dart:async";
import "dart:io";
import "dart:convert";

import "package:flutter/material.dart";
import "package:shared_preferences/shared_preferences.dart";
import "package:path_provider/path_provider.dart";

import "package:enigma/utils/SharedPreferencesBuilder.dart";
import "package:enigma/machine/enigmatic.dart";

class ConfigPage extends StatelessWidget {
  Future<String> get _localPath async {
    final dir = await getApplicationDocumentsDirectory();
    return dir.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File("$path/enigma.json");
  }

  Future<Enigma> readFile() async {
    try {
      final file = await _localFile;
      String contents = await file.readAsString();
      final config = json.decode(contents);
      return Enigma(
        config["charset"].split(""),
        PlugBoard.fromPairs(config["plugBoard"]),
        RotorSet(
          config["charset"].length,
          config["rotors"].map((r) =>
            Rotor.latin(
              r["charset"],
              r["turnover"]
            )
              ..position = r["position"]
          ),
          Reflector.fromPairs(config["reflector"])
        )
      );
    } catch (err) {
      return Enigma.defaultConfig(Enigma.latinAlphabet.split(""));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () => Scaffold.of(context).openDrawer(),
        ),
        title: Text("Configure Enigma")
      ),
      body: SharedPreferencesBuilder(
        pref: null,
        builder: null
      ),
    );
  }
}