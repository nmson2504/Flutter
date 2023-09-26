import 'package:flutter/material.dart';
// import 'package:logger/logger.dart';

// final logger = Logger();

class MyTextField extends StatelessWidget {
  const MyTextField({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(useMaterial3: true),
      home: Scaffold(
        appBar: AppBar(title: const Text('TextField Sample')),
        body: const TextField0(),
      ),
    );
  }
}

//
class TextField0 extends StatefulWidget {
  const TextField0({super.key});

  @override
  State<TextField0> createState() => _TextField0State();
}

class _TextField0State extends State<TextField0> {
  final TextEditingController _textEditingController = TextEditingController();
  String _inputText = "";

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: <Widget>[
          TextField(
            controller: _textEditingController,
            decoration: const InputDecoration(labelText: 'Enter text'),
            onChanged: (text) {
              setState(() {
                _inputText = text;
              });
            },
          ),
          const SizedBox(height: 20),
          Text('You entered: $_inputText',
              style: const TextStyle(fontSize: 18)),
        ],
      ),
    );
  }
}
