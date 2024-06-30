import 'dart:ui';

import 'package:flutter/material.dart';
import "implicit.dart";
import "explicit.dart";
import "explicit2.dart";
import "explicit3.dart";
import 'curved_animation.dart';
import 'tween.dart';
import 'tween2.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        scrollBehavior: const MaterialScrollBehavior()
            .copyWith(dragDevices: PointerDeviceKind.values.toSet()),
        home: const MyApp());
  }
}
