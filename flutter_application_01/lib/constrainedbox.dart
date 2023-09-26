import 'package:flutter/material.dart';

class MyConstrainedBox extends StatelessWidget {
  const MyConstrainedBox({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(title: const Text('Flutter SizedBox 2')),
          body: ConstrainedBox(
            constraints: const BoxConstraints(
              minWidth: 100, // Chiều rộng tối thiểu
              maxWidth: 200, // Chiều rộng tối đa
              minHeight: 50, // Chiều cao tối thiểu
              maxHeight: 150, // Chiều cao tối đa
            ),
            child: Container(
              color: Colors.blue,
              child: const Center(
                child: Text('ConstrainedBox Example'),
              ),
            ),
          )),
    );
  }
}
