import 'package:flutter/material.dart';

class DefaultTextStyleDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('DefaultTextStyle Example'),
        ),
        body: const Center(
          child: DefaultTextStyle(
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w500,
              color: Color.fromARGB(255, 183, 12, 225),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Hello'),
                Text('World'),
                Text('Flutter'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
