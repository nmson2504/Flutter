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
        body: const TextField1(),
      ),
    );
  }
}

// TextField0 - Retrieve the value of a text field
/// to retrieve the text a user has entered into a text field using the following steps:
// 1- Create a TextEditingController.
// 2- Supply the TextEditingController to a TextField
// Important: Call dispose of the TextEditingController when you’ve finished using it. This ensures that you discard any resources used by the object.

// Lifecycle
// Upon completion of editing, like pressing the "done" button on the keyboard, two actions take place:
// 1st: Editing is finalized. The default behavior of this step includes an invocation of onChanged. That default behavior can be overridden. See onEditingComplete for details.
// 2nd: onSubmitted is invoked with the user's input value.
// onSubmitted can be used to manually move focus to another input widget when a user finishes with the currently focused input widget.
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
            // The text field calls the onChanged callback whenever the user changes the text in the field.
            onChanged: (text) {
              setState(() {
                _inputText = text;
              });
            },
          ),
          const SizedBox(height: 20),
          Text('You entered: $_inputText',
              style: const TextStyle(fontSize: 18)),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            child: TextField(
              obscureText:
                  true, // Whether to hide the text being edited (e.g., for passwords).
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Password',
              ),
            ),
          )
        ],
      ),
    );
  }
}

//
// The text field calls the onChanged callback whenever the user changes the text in the field. If the user indicates that they are done typing in the field (e.g., by pressing a button on the soft keyboard), the text field calls the onSubmitted callback.
class TextField1 extends StatefulWidget {
  const TextField1({super.key});

  @override
  State<TextField1> createState() => _TextField1State();
}

class _TextField1State extends State<TextField1> {
  final TextEditingController _controller = TextEditingController();
  final TextEditingController _controller1 = TextEditingController();

  // @override
  // void initState() {
  //   super.initState();
  //   _controller = TextEditingController();
  //   _controller1 = TextEditingController();
  // }

  @override
  void dispose() {
    _controller.dispose();
    _controller1.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            TextField(
              controller: _controller,
              onSubmitted: (String value) async {
                await showDialog<void>(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Thanks!'),
                      content: Text(
                          'You typed "$value", which has length ${value.characters.length}.'),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text('OK'),
                        ),
                      ],
                    );
                  },
                );
              },
            ),
            TextField(
              controller: _controller1,
              onEditingComplete: () async {
                await showDialog<void>(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Thanks!'),
                      content: Text(
                          'You typed "${_controller1.text}", which has length ${_controller1.text.characters.length}.'),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text('OK'),
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
