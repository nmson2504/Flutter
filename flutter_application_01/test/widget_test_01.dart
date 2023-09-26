// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
          child: Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.blue,
                title: const Text('My App 001'),
              ),
              body: Center(child: MyWidget(false))))));
}

class MyWidget extends StatelessWidget {
  final bool load_state;
  MyWidget(this.load_state);
  @override
  Widget build(BuildContext context) {
    return load_state
        ? CircularProgressIndicator()
        : Text('loading state $load_state');
  }
}
