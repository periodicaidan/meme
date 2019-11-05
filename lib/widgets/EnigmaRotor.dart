import "dart:math";

import "package:flutter/material.dart";
import "package:provider/provider.dart";

import "package:enigma/utils/EnigmaButtonScheduler.dart";
//import "package:enigma/utils/RotorResetScheduler.dart";

class RotorPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var window = Paint()
      ..style = PaintingStyle.fill
      ..strokeJoin = StrokeJoin.round
      ..color = Colors.white;

    var center = Offset(size.width / 2, size.height / 2);
    var radius = min(size.width / 2, size.height / 2);

    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromCircle(
          center: center,
          radius: radius
        ),
        Radius.circular(12.0)
      ),
      window
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}

class EnigmaRotor extends StatelessWidget {
  static const double size = 60.0;
  final int index;

  EnigmaRotor(this.index);

  @override
  Widget build(BuildContext context) {
    final _provider = Provider.of<EnigmaButtonScheduler>(context);
    var startIndex = _provider.enigma.rotorSet.rotors[index].position;
    var faceText = _provider.enigma.charset[startIndex];

    return Container(
      width: size,
      height: size,
      child: CustomPaint(
        painter: RotorPainter(),
        child: Center(
          child: Text(faceText,
            style: TextStyle(
              color: Colors.black,
              fontSize: 32.0,
              fontFamily: "SourceCodePro"
            ),
          )
        ),
      )
    );
  }
}