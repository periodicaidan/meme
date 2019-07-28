import "dart:math";

import "package:flutter/material.dart";
import "package:provider/provider.dart";

import "package:enigma/utils/EnigmaButtonScheduler.dart";

class RotorPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var window = Paint()
      ..style = PaintingStyle.fill
      ..strokeJoin = StrokeJoin.round
      ..color = Colors.white;

    var center = Offset(size.width / 2, size.height / 2);
    var radius = min(size.width / 2, size.height / 2);

    canvas.drawRect(Rect.fromCircle(center: center, radius: radius), window);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }

}

class EnigmaRotor extends StatelessWidget {
  static const double size = 60.0;
  final int index;

  EnigmaRotor(this.index);

  @override
  Widget build(BuildContext context) {
    final _provider = Provider.of<EnigmaButtonScheduler>(context);
    var faceText = _provider.enigma.charset[_provider.enigma.rotorSet.rotors[index].position];
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