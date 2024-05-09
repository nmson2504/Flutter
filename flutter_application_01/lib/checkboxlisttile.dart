import 'package:flutter/material.dart';

class MyCheckBoxListTile extends StatelessWidget {
  const MyCheckBoxListTile({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(useMaterial3: true),
      home: Scaffold(
        appBar: AppBar(title: const Text('CheckBoxListTile Sample')),
        body: const MyCBLT(),
      ),
    );
  }
}

class MyCBLT extends StatefulWidget {
  const MyCBLT({super.key});

  @override
  State<MyCBLT> createState() => _MyCBLTState();
}

class _MyCBLTState extends State<MyCBLT> {
  bool _isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CheckboxListTile(
          tileColor: const Color.fromARGB(255, 245, 188, 184),
          title: const Text('Checkbox List Tile'),
          subtitle: const Text('Subtitle'),
          secondary: const Icon(Icons.star),
          value: _isChecked,
          onChanged: (bool? newValue) {
            setState(() {
              _isChecked = newValue!;
              print(_isChecked);
            });
          },
        ),
        const Divider(),
        CheckboxListTile(
          // format checkbox
          checkColor: const Color.fromARGB(255, 44, 7, 255),
          fillColor: MaterialStateProperty.all<Color>(const Color.fromARGB(
              255, 243, 33, 33)), // Fill color when not pressed
          overlayColor: MaterialStateProperty.all<Color>(const Color.fromARGB(
              255, 154, 235, 157)), // Overlay color when pressed
          checkboxShape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6.0),
              side: const BorderSide(
                  width: 10, color: Color.fromARGB(255, 243, 33, 51))),
          // format ListTile
          tileColor: const Color.fromARGB(255, 160, 230, 249),
          contentPadding: const EdgeInsets.all(10),
          title: const Text('Checkbox List Tile'),
          subtitle: const Text('Subtitle'),
          secondary: const Icon(Icons.star),
          value: _isChecked,
          onChanged: (bool? newValue) {
            setState(() {
              _isChecked = newValue!;
              print(_isChecked);
            });
          },
        ),
      ],
    );
  }
}
//

