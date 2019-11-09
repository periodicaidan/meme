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
import "utils/ResetButtonScheduler.dart";

void main() => runApp(MEME());

class MEME extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "MEME",
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
  final String title;
  Enigma enigma;

  HomePage({Key key, this.title}) : super(key: key) {
    enigma = Enigma.defaultConfig(_keyboardFormat.charset);
  }

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    var rotors = <EnigmaRotor>[];
    for (var i = 0; i < widget.enigma.numRotors; i++) {
      rotors.insert(0, EnigmaRotor(i));
    }

    return MultiProvider(
      providers: [
        ChangeNotifierProvider<EnigmaButtonScheduler>.value(
          value: EnigmaButtonScheduler(widget.enigma)
        ),
        ChangeNotifierProvider<ResetButtonScheduler>.value(
          value: ResetButtonScheduler(widget.enigma)
        ),
      ],
//      builder: (context) => EnigmaButtonScheduler(widget.enigma),
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          leading: OpenDrawerButton(),
          actions: <Widget>[
            RotorResetButton(widget.enigma, rotors),
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

class RotorResetButton extends StatelessWidget {
  final Enigma enigma;
  final List<EnigmaRotor> rotors;

  RotorResetButton(this.enigma, this.rotors);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.refresh),
      onPressed: () {
        Provider.of<ResetButtonScheduler>(context).activate();
      },
      tooltip: "Reset",
    );
  }
}

class OpenDrawerButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.menu),
      onPressed: () {
        Scaffold.of(context).openDrawer();
      }
    );
  }
}

