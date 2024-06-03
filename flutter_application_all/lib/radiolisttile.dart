import 'package:flutter/material.dart';

class MyRadioListTile extends StatelessWidget {
  const MyRadioListTile({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(useMaterial3: true),
      home: Scaffold(
        appBar: AppBar(title: const Text('MyRadioListTile Sample')),
        body: const RadioListTileDemo(),
      ),
    );
  }
}

// kiểu  RadioListTile<Groceries>
enum Groceries {
  pickles,
  tomato,
  lettuce
} // để gán value cho các RadioListTile

Groceries? _groceryItem = Groceries.pickles; // để gán cho groupValue

class RadioListTile1 extends StatefulWidget {
  const RadioListTile1({super.key});

  @override
  State<RadioListTile1> createState() => _RadioListTile1State();
}

class _RadioListTile1State extends State<RadioListTile1> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        RadioListTile<Groceries>(
          value: Groceries.pickles,
          groupValue: _groceryItem,
          onChanged: (Groceries? value) {
            setState(() {
              _groceryItem = value;
              debugPrint('$_groceryItem');
            });
          },
          title: const Text('Pickles'),
          subtitle: const Text('Supporting text'),
        ),
        RadioListTile<Groceries>(
          value: Groceries.tomato,
          groupValue: _groceryItem,
          onChanged: (Groceries? value) {
            setState(() {
              _groceryItem = value;
              debugPrint('$_groceryItem');
            });
          },
          title: const Text('Tomato'),
          subtitle: const Text(
              'Longer supporting text to demonstrate how the text wraps and the radio is centered vertically with the text.'),
        ),
        RadioListTile<Groceries>(
          value: Groceries.lettuce,
          groupValue: _groceryItem,
          onChanged: (Groceries? value) {
            setState(() {
              _groceryItem = value;
              debugPrint('$_groceryItem');
            });
          },
          title: const Text('Lettuce'),
          subtitle: const Text(
              "Longer supporting text to demonstrate how the text wraps and how setting 'RadioListTile.isThreeLine = true' aligns the radio to the top vertically with the text."),
          isThreeLine: true,
        ),
      ],
    );
  }
}

// kiểu int từ list cho trước
class RadioListTileDemo extends StatefulWidget {
  const RadioListTileDemo({super.key});

  @override
  State<RadioListTileDemo> createState() => _RadioListTileDemoState();
}

class _RadioListTileDemoState extends State<RadioListTileDemo> {
  int selectedValue = 1;
  List<int> radioValues = [0, 1, 2];
  List<String> radioSubtitle = [
    "RadioListTile 0",
    "RadioListTile 1",
    "RadioListTile 2"
  ];
  @override
  Widget build(BuildContext context) {
    return Column(
      children: radioValues.map((value) {
        return RadioListTile<int>(
          value: value,
          groupValue: selectedValue,
          title: Text('Option $value'),
          subtitle: Text(radioSubtitle[value]),
          onChanged: (newValue) {
            setState(() {
              selectedValue = newValue!;
              debugPrint('$selectedValue');
            });
          },
        );
      }).toList(),
    );
  }
}
