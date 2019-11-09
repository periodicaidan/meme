/// MEME/lib/widgets/EnigmaButton.dart
///
/// Table of Contents
/// [EnigmaButtonState] : An enumeration of the possible states of a button
/// [EnigmaButton] : A button on the enigma machine
/// [_EnigmaButtonState] : The state of the above
/// [CircleButtonRaised] : The appearance of a raised button
/// [CircleButtonPressed] : The appearance of a pressed button

import "dart:math";

import "package:flutter/material.dart";
import "package:provider/provider.dart";

import "package:enigma/utils/EnigmaButtonScheduler.dart";


enum EnigmaButtonState {
  Raised,
  Pressed,
  Disabled
}


class EnigmaButton extends StatefulWidget {
  final String char;

  EnigmaButton(this.char);

  @override
  _EnigmaButtonState createState() => _EnigmaButtonState();
}

class _EnigmaButtonState extends State<EnigmaButton> {
  EnigmaButtonState _buttonState = EnigmaButtonState.Raised;

  @override
  Widget build(BuildContext context) {
    final _provider = Provider.of<EnigmaButtonScheduler>(context);
    return Container(
      width: 39.0,
      height: 53.0,
      padding: EdgeInsets.all(6.0),
      child: GestureDetector(
        onTapDown: (details) {
          setState(() => _buttonState = EnigmaButtonState.Pressed);
          _provider.activate(widget.char);
        },
        onTapCancel: () {
          setState(() => _buttonState = EnigmaButtonState.Raised);
          _provider.deactivate();
        },
        onTapUp: (details) {
          setState(() => _buttonState = EnigmaButtonState.Raised);
          _provider.deactivate();
        },
        child: Builder(
          builder: (context) {
            CustomPainter p;
            double dy;
            switch (_buttonState) {
              case EnigmaButtonState.Raised:
                p = CircleButtonRaised();
                dy = -0.5;
              break;

              case EnigmaButtonState.Pressed:
                p = CircleButtonPressed();
                dy = 0.2;
              break;

              case EnigmaButtonState.Disabled:
              default:
                p = CircleButtonPressed();
                dy = 0.2;
              break;
            }
            return CustomPaint(
              painter: p,
              child: Align(
                alignment: Alignment(0.0, dy),
                child: Text(widget.char,
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 12.0,
                    fontWeight: FontWeight.bold
                  ),
                )
              )
            );
          }
        )
      ),
    );
  }
}

class CircleButtonRaised extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var face = Paint()
      ..style = PaintingStyle.fill
      ..color = Colors.black87;

    var faceEdge = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0
      ..color = Colors.grey[400];

    var side = Paint()
      ..style = PaintingStyle.fill
      ..color = Colors.grey[600];

    var middle = Offset(size.width / 2, size.height / 2);
    double radius = min(size.width / 2, size.height / 2);
    var circleCenter = Offset(middle.dx, radius);

    // Stick the button stands on
    canvas.drawLine(
      middle,
      Offset(middle.dx, size.height),
      Paint()
        ..style = PaintingStyle.stroke
        ..color = Colors.black
        ..strokeWidth = 10.0
        ..strokeCap = StrokeCap.round
    );
    // The side of the button
    canvas.drawCircle(
      Offset(
        circleCenter.dx,
        circleCenter.dy + 5.0
      ),
      radius + 1.0,
      side
    );
    // The button's face
    canvas.drawCircle(circleCenter, radius, face);
    // The edge of the button's face
    canvas.drawCircle(circleCenter, radius, faceEdge);
  }

  @override
  bool shouldRepaint(CustomPainter old) {
    return true;
  }
}

class CircleButtonPressed extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var face = Paint()
      ..style = PaintingStyle.fill
      ..color = Colors.black87;

    var faceEdge = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0
      ..color = Colors.grey[400];

    var side = Paint()
      ..style = PaintingStyle.fill
      ..color = Colors.grey[600];

    var middle = Offset(size.width / 2, size.height / 2);
    double radius = min(size.width / 2, size.height / 2);
    var sideWidth = 5.0;
    var circleCenter = Offset(middle.dx, size.height - radius - sideWidth);

    // The side of the button
    canvas.drawCircle(
      Offset(
        circleCenter.dx,
        circleCenter.dy + sideWidth
      ),
      radius + 1.0, side
    );

    // The face of the button
    canvas.drawCircle(circleCenter, radius, face);

    // Edge of the face
    canvas.drawCircle(circleCenter, radius, faceEdge);

  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}