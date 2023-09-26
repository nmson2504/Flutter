// ignore_for_file: file_names
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
              body: const Center(
                  child: Text(
                'Hello world welll..',
                style: TextStyle(fontSize: 24),
              ))))));
}
