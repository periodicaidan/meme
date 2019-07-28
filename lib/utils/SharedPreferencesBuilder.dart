/**
 * Based on this gist from Simon Lightfoot:
 * https://gist.github.com/slightfoot/d549282ac0a5466505db8ffa92279d25#file-prefs-dart
 */

import "dart:async";

import "package:flutter/material.dart";
import "package:shared_preferences/shared_preferences.dart";

class SharedPreferencesBuilder<T> extends StatelessWidget {
  final String pref;
  final AsyncWidgetBuilder<T> builder;

  const SharedPreferencesBuilder({
    Key key,
    @required this.pref,
    @required this.builder
  }) : super(key: key);

  Future<T> get _future async =>
    (await SharedPreferences.getInstance()).get(pref);


  @override
  Widget build(BuildContext context) {
    return FutureBuilder<T>(
      future: _future,
      builder: (context, snapshot) => this.builder(context, snapshot),
    );
  }
}