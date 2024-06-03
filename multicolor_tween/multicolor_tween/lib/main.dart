import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import "tween_sequence_box.dart";
import 'rainbow_color_tween_box.dart';
import 'rainbow_box.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const MyHomePage(
        title: 'Flutter Demo Home Page',
        key: null,
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: const DefaultTextStyle(
        style: TextStyle(
          inherit: true,
          fontSize: 20.0,
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              // TweenSequenceBox(
              //   key: null,
              // ),
              RainbowColorTweenBox(
                key: null,
              ),
              RainbowBox(
                key: null,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
