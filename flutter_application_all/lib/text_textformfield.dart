import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  const MyTextField({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      // theme: ThemeData(useMaterial3: true),
      home: Home1(),
    );
  }
}

// Home1 - demo basic

class Home1 extends StatelessWidget {
  const Home1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My TextField - TextFormField'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            child: TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: "My TextField",
                hintText: 'Enter a search term',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            child: TextFormField(
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'My TextFormField',
              ),
            ),
          ),
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

// Home2 - Retrieve the value of a text field
/// to retrieve the text a user has entered into a text field using the following steps:
// 1- Create a TextEditingController.
// 2- Supply the TextEditingController to a TextField
// Important: Call dispose of the TextEditingController when you’ve finished using it. This ensures that you discard any resources used by the object.
class Home2 extends StatefulWidget {
  const Home2({super.key});

  @override
  State<Home2> createState() => _Home2State();
}

class _Home2State extends State<Home2> {
  // Create a text controller and use it to retrieve the current value
  // of the TextField.
  final myController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Retrieve Text Input'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: TextField(
          controller: myController,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Retrieve Text Input',
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        // When the user presses the button, show an alert dialog containing
        // the text that the user has entered into the text field.
        onPressed: () {
          if (myController.text.isNotEmpty) {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  // Retrieve the text the that user has entered by using the
                  // TextEditingController.
                  content: Text(myController.text),
                );
              },
            );
          }
        },
        tooltip: 'Show value input!',
        child: const Icon(Icons.ac_unit),
      ),
    );
  }
}

// Home3 - Handle changes to a text field
/// How do you run a callback function every time the text changes? With Flutter, you have two options:
// 1- Supply an onChanged() callback to a TextField or a TextFormField.
// 2- Use a TextEditingController.

class Home3 extends StatefulWidget {
  const Home3({super.key});

  @override
  State<Home3> createState() => _Home3State();
}

class _Home3State extends State<Home3> {
  // Create a text controller and use it to retrieve the current value
  // of the TextField.
  final myController = TextEditingController();

// Listen to the TextEditingController and call the _printLatestValue() method when the text changes. Use the addListener() method for this purpose.
// Begin listening for changes when the _Home3State class is initialized, and stop listening when the _MyCustomFormState is disposed.
  @override
  void initState() {
    super.initState();
    // Start listening to changes.
    myController.addListener(_printLatestValue);
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the widget tree.
    // This also removes the _printLatestValue listener.
    myController.dispose();
    super.dispose();
  }

  void _printLatestValue() {
    final text = myController.text;
    debugPrint('Second text field: $text (${text.characters.length})');
    st2 = text;
    setState(() {}); // update UI
  }

  String st = '';
  String st2 = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Retrieve Text Input'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // TextField uses onChanged
            TextField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'TextField with onChanged',
              ),
              onChanged: (text) {
                st = text;
                debugPrint(
                    'First text field: $text (${text.characters.length})');
                setState(() {}); // update UI
              },
            ),
            const SizedBox(
              height: 20,
            ),
            // TextFormField uses myController.addListener
            TextFormField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'TextFormField with myController.addListener',
              ),
              controller: myController,
            ),
            const Divider(
              height: 20,
            ),
            Text('TextField: $st'),
            Text('TextFormField: $st2'),
          ],
        ),
      ),
    );
  }
}

// Home4 - Focus and text fields (default switching focus with Tab key)
// - To give focus to a text field as soon as it’s visible, use the autofocus property.
// - Focus a text field when a button is tapped, following steps:
// 1- Create a FocusNode.
// 2- Pass the FocusNode to a TextField.
// 3- Give focus to the TextField when a button is tapped.

class Home4 extends StatefulWidget {
  const Home4({super.key});

  @override
  State<Home4> createState() => _Home4State();
}

// Define a corresponding State class.
// This class holds data related to the form.
class _Home4State extends State<Home4> {
  // Define the focus node. To manage the lifecycle, create the FocusNode in
  // the initState method, and clean it up in the dispose method.
  late FocusNode myFocusNode;

  @override
  void initState() {
    super.initState();

    myFocusNode = FocusNode();
  }

  @override
  void dispose() {
    // Clean up the focus node when the Form is disposed.
    myFocusNode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Text Field Focus'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // The first text field is focused on as soon as the app starts.
            const TextField(
              autofocus: true,
            ),
            // The second text field is focused on when a user taps the
            // FloatingActionButton.
            TextField(
              focusNode: myFocusNode,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        // When the button is pressed,
        // give focus to the text field using myFocusNode.
        onPressed: () => myFocusNode.requestFocus(),
        tooltip: 'Focus Second Text Field',
        child: const Icon(Icons.edit),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

// Home5 -  toggle the focus between the two text fields

class Home5 extends StatefulWidget {
  const Home5({super.key});

  @override
  State<Home5> createState() => _Home5State();
}

class _Home5State extends State<Home5> {
  // Define the focus node. To manage the lifecycle, create the FocusNode for each TextField
  late FocusNode firstFocusNode;
  late FocusNode secondFocusNode;

  @override
  void initState() {
    super.initState();

    firstFocusNode = FocusNode();
    secondFocusNode = FocusNode();
  }

  @override
  void dispose() {
    firstFocusNode.dispose();
    secondFocusNode.dispose();

    super.dispose();
  }

  bool isSecondTextFieldFocused = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Text Field Toggle Focus'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // The first text field is focused on as soon as the app starts.
            TextField(
              autofocus: true,
              focusNode: firstFocusNode, // set focusNode
            ),
            // The second text field is focused on when a user taps the FloatingActionButton.
            TextField(
              focusNode: secondFocusNode, // set focusNode
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            isSecondTextFieldFocused =
                !isSecondTextFieldFocused; // switch value of isSecondTextFieldFocused
          });
          // request focus base on isSecondTextFieldFocused
          if (isSecondTextFieldFocused) {
            FocusScope.of(context).requestFocus(secondFocusNode);
          } else {
            FocusScope.of(context).requestFocus(firstFocusNode);
          }
        },
        tooltip: 'Toggle Focus Between Text Fields',
        child: const Icon(Icons.edit),
      ),
    );
  }
}
