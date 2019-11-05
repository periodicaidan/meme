/// MEME/lib/widgets/EnigmaBulb.dart
///
/// Table of Contents
/// [CircleBulb] : A circular widget that serves as a bulb
/// [EnigmaBulb] : A light bulb on the enigma machine
/// [_EnigmaBulbState] : Holds the state of the above

import "dart:math";

import "package:flutter/material.dart";
import "package:provider/provider.dart";
import "package:enigma/utils/EnigmaButtonScheduler.dart";

class CircleBulb extends CustomPainter {

  Color fillColor;
  Color borderColor;
  Color textColor;
  Color activeColor;
  double padding;
  bool active = false;

  CircleBulb({
    this.fillColor,
    this.borderColor,
    this.textColor,
    this.activeColor,
    this.padding
  });

  @override
  void paint(Canvas canvas, Size size) {
    var line = Paint()
      ..color = borderColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    var fill = Paint()
      ..color = fillColor
      ..style = PaintingStyle.fill;

    var center = Offset(size.width / 2, size.height / 2);
    double radius = min(size.width / 2, size.height / 2);

    canvas.drawCircle(center, radius, fill);
    canvas.drawCircle(center, radius, line);
  }

  @override
  bool shouldRepaint(CircleBulb old) => active != old.active;
}

class EnigmaBulb extends StatefulWidget {
  final String char;

  EnigmaBulb(this.char);

  @override
  _EnigmaBulbState createState() => _EnigmaBulbState();
}

class _EnigmaBulbState extends State<EnigmaBulb> {
  bool active = false;

  _EnigmaBulbState();

  void toggle() {
    setState(() {
      active = !active;
    });
  }

  @override
  Widget build(BuildContext context) {
    final _provider = Provider.of<EnigmaButtonScheduler>(context);
    return Container(
      width: 38.0,
      height: 38.0,
      padding: EdgeInsets.all(4.0),
      child: CustomPaint(
        painter: CircleBulb(
          fillColor: _provider.active && widget.char == _provider.outputChar
            ? Colors.yellow : Colors.black87,
          borderColor: Colors.white70,
          textColor: Colors.white70,
        ),
        child: Center(
          child: Text(
            widget.char,
            style: TextStyle(
              color: (_provider.active && widget.char == _provider.outputChar)
                ? Colors.black : Colors.white70,
              fontWeight: FontWeight.bold,
              fontSize: 14.0
            )
          )
        ),
      ),
    );
  }
}