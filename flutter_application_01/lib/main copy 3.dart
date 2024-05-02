import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
      theme: ThemeData(
        //fontFamily: 'Playfair Display',
        textTheme: const TextTheme(
          bodyLarge: TextStyle(fontSize: 18.0),
          bodyMedium: TextStyle(fontSize: 26.0),
          bodySmall: TextStyle(fontSize: 26.0),
          // ...  // and so on for every text style
        ),
      ),
      // Các thuộc tính khác của MaterialApp...
      title: 'Text widget demo', // ko show len duoc???
      home: SafeArea(
          child: Scaffold(
              appBar: AppBar(
                  backgroundColor: Colors.blue,
                  title: const Text('Text widget')),
              body: const Center(
                  child: Text('MaterialApp - SafeArea - Scaffold'))))));
}
