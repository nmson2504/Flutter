import 'package:flutter/material.dart';

class MySwitchListTile extends StatelessWidget {
  const MySwitchListTile({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(useMaterial3: true),
      home: Scaffold(
        appBar: AppBar(title: const Text('SwitchListTile Sample')),
        body: const SwitchListTile1(),
      ),
    );
  }
}

class SwitchListTile1 extends StatefulWidget {
  const SwitchListTile1({super.key});

  @override
  State<SwitchListTile1> createState() => _SwitchListTile1State();
}

class _SwitchListTile1State extends State<SwitchListTile1> {
  // bool switchValue1 = true;
  // bool switchValue2 = true;
  // bool switchValue3 = true;
  bool valueInit = true;
  late bool switchValue1 = valueInit,
      switchValue2 = valueInit,
      switchValue3 = valueInit;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SwitchListTile(
          title: const Text('Lights'),
          value: switchValue1,
          onChanged: (bool value) {
            setState(() {
              switchValue1 = value;
              debugPrint('$switchValue1');
            });
          },
          secondary: const Icon(Icons.lightbulb_outline),
        ),
        const Divider(),
        SwitchListTile(
          title: const Text('Station'),
          value: switchValue2,
          onChanged: (bool value) {
            setState(() {
              switchValue2 = value;
              debugPrint('$switchValue2');
            });
          },
          secondary: const Icon(Icons.ev_station),
        ),
        const Divider(),
        SwitchListTile(
          title: const Text('account_balance_sharp'),
          value: switchValue3,
          onChanged: (bool value) {
            setState(() {
              switchValue3 = value;
              debugPrint('$switchValue3');
            });
          },
          secondary: const Icon(Icons.account_balance_sharp),
        ),
        const Divider(),
      ],
    );
  }
}

//
class SwitchListTile2 extends StatefulWidget {
  const SwitchListTile2({super.key});

  @override
  State<SwitchListTile2> createState() => _SwitchListTile2State();
}

class _SwitchListTile2State extends State<SwitchListTile2> {
  bool valueInit = true;
  late bool switchValue1 = valueInit,
      switchValue2 = valueInit,
      switchValue3 = valueInit;
// Gán title: qua biến - đọc lại giá trị title: khi cần
  Widget titleWidget0 = const Text('Light'); // Giá trị của thuộc tính title
  Widget titleWidget1 = const Text('Station'); // Giá trị của thuộc tính title
  Widget titleWidget2 = const Text('Sharp'); // Giá trị của thuộc tính title
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SwitchListTile(
          title: titleWidget0, // Sử dụng biến titleWidget
          value: switchValue1,
          onChanged: (bool value) {
            setState(() {
              switchValue1 = value;
              debugPrint('$switchValue1');
              if (switchValue1) {
                String? titleValue = (titleWidget0 as Text).data;
                debugPrint('$titleValue');
              }
            });
          },
          secondary: const Icon(Icons.lightbulb_outline),
          subtitle: const Text(
              'This sample demonstrates how SwitchListTile positions the switch widget relative to the text in different configurations.'),
        ),
        const Divider(),
        SwitchListTile(
          title: titleWidget1,
          value: switchValue2,
          onChanged: (bool value) {
            setState(() {
              switchValue2 = value;
              debugPrint('$switchValue2');
              if (switchValue2) {
                String? titleValue = (titleWidget1 as Text).data;
                debugPrint('$titleValue');
              }
            });
          },
          secondary: const Icon(Icons.ev_station),
          subtitle: const Text(
              "Longer supporting text to demonstrate how the text wraps and how setting 'SwitchListTile.isThreeLine = true' aligns the switch to the top vertically with the text."),
        ),
        const Divider(),
        SwitchListTile(
          title: titleWidget2,
          value: switchValue3,
          onChanged: (bool value) {
            setState(() {
              switchValue3 = value;
              debugPrint('$switchValue3');
              if (switchValue3) {
                String? titleValue = (titleWidget2 as Text).data;
                debugPrint('$titleValue');
              }
            });
          },
          secondary: const Icon(Icons.account_balance_sharp),
          subtitle: const Text(
              "Longer supporting text to demonstrate how the text wraps and how settihe text."),
        ),
        const Divider(),
      ],
    );
  }
}
