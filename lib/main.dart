import "dart:ui";

import "package:flutter/material.dart";
import "package:flutter/foundation.dart";
import "package:shared_preferences/shared_preferences.dart";

import "package:provider/provider.dart";

import "package:enigma/machine/Enigma.dart";
import "package:enigma/utils/KeyboardFormats.dart";
import "package:enigma/utils/EnigmaButtonScheduler.dart";
import "package:enigma/widgets/EnigmaWidgets.dart";
import "package:enigma/ConfigPage.dart";

void main() => runApp(MEME());

class MEME extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Enigma Emu',
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.blue,
      ),
      initialRoute: "/",
      routes: {
        "/": (context) => HomePage(title: "Enigma"),
        "/config": (context) => ConfigPage(),
      },
    );
  }
}

class HomePage extends StatefulWidget {
  final KeyboardFormat _keyboardFormat = KeyboardFormat.enigma();
  Enigma enigma;

  HomePage({Key key, this.title}) : super(key: key) {
    enigma = Enigma.defaultConfig(_keyboardFormat.charset);
  }

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    var rotors = <EnigmaRotor>[];
    for (var i = 0; i < widget.enigma.rotorSet.rotors.length; i++) {
      rotors.insert(0, EnigmaRotor(i));
    }

    return ChangeNotifierProvider(
      builder: (context) => EnigmaButtonScheduler(widget.enigma),
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          leading: IconButton(
            icon: Icon(Icons.menu),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            }
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.refresh),
              onPressed: () {},
              tooltip: "Reset",
            )
          ],
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: rotors,
            ),
            Container(
              child: Column(
                children: widget._keyboardFormat.layout.map((row) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: row.map((ch) {
                      return EnigmaBulb(ch);
                    }).toList(),
                  );
                }).toList(),
              )
            ),

            Container(
              child: Column(
                children: widget._keyboardFormat.layout.map((row) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: row.map((ch) {
                      return EnigmaButton(ch);
                    }).toList(),
                  );
                }).toList(),
              )
            )
          ],
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              ListTile(
                title: Text("Enigma Machine")
              ),
              ListTile(
                title: Text("Configuration")
              ),
              ListTile(
                title: Text("About")
              )
            ]
          )
        ),
      ),
    );
  }
}