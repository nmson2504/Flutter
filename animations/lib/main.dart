import 'dart:ui';

import 'package:animations/transform_demo.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import "implicit.dart";
import "explicit.dart";
import "explicit2.dart";
import "explicit3.dart";
import 'curved_animation.dart';
import 'tween.dart';
import 'tween2.dart';
import 'listener.dart';
import 'animated_widget.dart';
import 'animated_builder.dart';
import 'animated_demoxxx.dart';
import 'multi_animation.dart';
import 'implicit1.dart';
import 'temp.dart';
import 'hero_animation.dart';
import 'hero_animation2.dart';
import 'hero_animation3.dart';
import 'animated_switcher.dart';
import 'translate_demo.dart';
import 'flip_demo.dart';

void main() {
  runApp(DevicePreview(
    enabled: !kReleaseMode,
    builder: (context) => const MyDemoAnimations(), // Wrap your app
  ));
  // runApp(const MyHero());
}

// run 1 apps required scroll - drag
class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        scrollBehavior: const MaterialScrollBehavior().copyWith(dragDevices: PointerDeviceKind.values.toSet()),
        home: const MyDemoFlip());
  }
}
