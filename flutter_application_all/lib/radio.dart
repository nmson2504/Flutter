import 'package:flutter/material.dart';
// import 'package:logger/logger.dart';

// final logger = Logger();

class MyRadio extends StatelessWidget {
  const MyRadio({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(useMaterial3: true),
      home: Scaffold(
        appBar: AppBar(title: const Text('Radio Sample')),
        body: const Radio2(),
      ),
    );
  }
}

//
// Kiẻu String:  Radio<String>
class Radio1 extends StatefulWidget {
  const Radio1({super.key});

  @override
  State<Radio1> createState() => _Radio1State();
}

class _Radio1State extends State<Radio1> {
  // định nghĩa biến gán cho groupValue
  String selectedOption = 'Option 1';

  void _handleRadioValueChange(String value) {
    setState(() {
      selectedOption = value;
      debugPrint(selectedOption);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        RadioListTile<String>(
          // định nghĩa kiểu String
          title: const Text('Option 1'),
          value:
              'Option 1', // value và groupValue phải cùng kiểu với kiểu String đã khai báo ở trên
          groupValue: selectedOption, //
          onChanged: (nValue) {
            _handleRadioValueChange(nValue!);
          },
        ),
        RadioListTile<String>(
          title: const Text('Option 2'),
          value: 'Option 2',
          groupValue: selectedOption,
          onChanged: (nValue) {
            _handleRadioValueChange(nValue!);
          },
        ),
        RadioListTile<String>(
          title: const Text('Option 3'),
          value: 'Option 3',
          groupValue: selectedOption,
          onChanged: (nValue) {
            _handleRadioValueChange(nValue!);
          },
        ),
      ],
    );
  }
}

// Cách khác - Kiểu int
class Radio2 extends StatefulWidget {
  const Radio2({super.key});

  @override
  State<Radio2> createState() => _Radio2State();
}

class _Radio2State extends State<Radio2> {
  // định nghĩa biến gán cho groupValue
  int selectedOption = 1;

  void _handleRadioValueChange(int value) {
    setState(() {
      selectedOption = value;
      // print(selectedOption);
      debugPrint('$selectedOption');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        RadioListTile<int>(
          // định nghĩa kiểu int
          title: const Text('Option 1'),
          value:
              1, // value và groupValue phải cùng kiểu với kiểu int đã khai báo ở trên
          groupValue: selectedOption, //
          onChanged: (nValue) {
            _handleRadioValueChange(nValue!);
          },
        ),
        RadioListTile<int>(
          title: const Text('Option 2'),
          value: 2,
          groupValue: selectedOption,
          onChanged: (nValue) {
            _handleRadioValueChange(nValue!);
          },
        ),
        RadioListTile<int>(
          title: const Text('Option 3'),
          value: 3,
          groupValue: selectedOption,
          onChanged: (nValue) {
            _handleRadioValueChange(nValue!);
          },
        ),
      ],
    );
  }
}

// Cách khác - kiểu tự định nghĩa:  Radio<SingingCharacter>

enum SingingCharacter { lafayette, jefferson }

class RadioExample extends StatefulWidget {
  const RadioExample({super.key});

  @override
  State<RadioExample> createState() => _RadioExampleState();
}

class _RadioExampleState extends State<RadioExample> {
  // định nghĩa biến gán cho groupValue
  SingingCharacter? _character = SingingCharacter.lafayette;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ListTile(
          title: const Text('Lafayette'),
          leading: Radio<SingingCharacter>(
            // định nghĩa kiểu SingingCharacter
            // value và groupValue phải cùng kiểu với kiểu SingingCharacter đã khai báo ở trên
            value: SingingCharacter.lafayette,
            groupValue: _character,
            onChanged: (SingingCharacter? value) {
              setState(() {
                _character = value;
                print(_character);
              });
            },
          ),
        ),
        ListTile(
          title: const Text('Thomas Jefferson'),
          leading: Radio<SingingCharacter>(
            value: SingingCharacter.jefferson,
            groupValue: _character,
            onChanged: (SingingCharacter? value) {
              setState(() {
                _character = value;
                print(_character);
              });
            },
          ),
        ),
      ],
    );
  }
}
