import 'package:flutter/material.dart';

class MyDropDownMenu extends StatelessWidget {
  const MyDropDownMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(useMaterial3: true),
      home: Scaffold(
        appBar: AppBar(title: const Text('DropDownMenu  Sample')),
        body: const DropDownMenu1(),
      ),
    );
  }
}

//
class DropDownMenu0 extends StatefulWidget {
  const DropDownMenu0({super.key});

  @override
  State<DropDownMenu0> createState() => _DropDownMenu0State();
}

String selectedOption = 'Option 1';

class _DropDownMenu0State extends State<DropDownMenu0> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          DropdownMenu<String>(
            requestFocusOnTap: true, // để input text được trên virtual device
            initialSelection:
                selectedOption, // T? initialSelection - giá trị default
            onSelected: (String? newValue) {
              setState(() {
                selectedOption = newValue!;
              });
            },
            // required List<DropdownMenuEntry<T>> dropdownMenuEntries - build list items
            dropdownMenuEntries: <String>['Option 1', 'Option 2', 'Option 3']
                .map<DropdownMenuEntry<String>>((String value) {
              return DropdownMenuEntry<String>(value: value, label: value);
            }).toList(),
          ),
          Text(
            'Bạn đã chọn: $selectedOption',
            style: const TextStyle(fontSize: 18),
          ),
        ],
      ),
    );
  }
}

//

List<IconData> _iconList = [
  Icons.nature,
  Icons.one_k_plus,
  Icons.tab,
  Icons.auto_awesome_motion,
  Icons.call_end_sharp,
  Icons.equalizer_rounded,
  Icons.wifi_lock,
  Icons.mail,
];

class DropDownMenu1 extends StatefulWidget {
  const DropDownMenu1({super.key});

  @override
  State<DropDownMenu1> createState() => _DropDownMenu1State();
}

const List<String> list = <String>['One', 'Two', 'Three', 'Four'];

class _DropDownMenu1State extends State<DropDownMenu1> {
  String dropdownValue = list.first;
  int index = -1;
  @override
  Widget build(BuildContext context) {
    return DropdownMenu<String>(
      requestFocusOnTap: true, // để input text được trên virtual device
      initialSelection: list.first, // T? initialSelection - giá trị default
      label: const Text('Select item'), // Label cho DropdownMenu box
      leadingIcon: const Icon(
          Icons.select_all), // icon ngay trước(liền trái) DropdownMenu box
      onSelected: (String? value) {
        // This is called when the user selects an item.
        setState(() {
          dropdownValue = value!;
        });
      },

      // required List<DropdownMenuEntry<T>> dropdownMenuEntries - build list items
      dropdownMenuEntries: list.map<DropdownMenuEntry<String>>((String value) {
        if (index < _iconList.length - 1) {
          index++; // Lấy giá trị index và tăng nó sau đó
        }
        return DropdownMenuEntry<String>(
            value:
                value, // This value must be unique across all entries in a [DropdownMenu].
            label: value, // The label displayed in the center of the menu item.
            leadingIcon:
                Icon(_iconList[index]), // icon ngay trước(liền trái) item
            trailingIcon:
                const Icon(Icons.check_outlined)); // icon sát lề phải item
      }).toList(),
    );
  }
}

//
enum ColorLabel {
  blue('Blue', Colors.blue),
  pink('Pink', Colors.pink),
  green('Green', Colors.green),
  yellow('Yellow', Colors.yellow),
  grey('Grey', Colors.grey);

  const ColorLabel(this.label, this.color);
  final String label;
  final Color color;
}

enum IconLabel {
  smile('Smile', Icons.sentiment_satisfied_outlined),
  cloud('Cloud', Icons.cloud_outlined),
  brush('Brush', Icons.brush_outlined),
  heart('Heart', Icons.favorite);

  const IconLabel(this.label, this.icon);
  final String label;
  final IconData icon;
}

class DropDownMenu2 extends StatefulWidget {
  const DropDownMenu2({super.key});

  @override
  State<DropDownMenu2> createState() => _DropDownMenu2State();
}

class _DropDownMenu2State extends State<DropDownMenu2> {
  final TextEditingController colorController = TextEditingController();
  final TextEditingController iconController = TextEditingController();
  ColorLabel? selectedColor;
  IconLabel? selectedIcon;

  @override
  Widget build(BuildContext context) {
    final List<DropdownMenuEntry<ColorLabel>> colorEntries =
        <DropdownMenuEntry<ColorLabel>>[];
    for (final ColorLabel color in ColorLabel.values) {
      colorEntries.add(
        DropdownMenuEntry<ColorLabel>(
            value: color, label: color.label, enabled: color.label != 'Grey'),
      );
    }

    final List<DropdownMenuEntry<IconLabel>> iconEntries =
        <DropdownMenuEntry<IconLabel>>[];
    for (final IconLabel icon in IconLabel.values) {
      iconEntries
          .add(DropdownMenuEntry<IconLabel>(value: icon, label: icon.label));
    }

    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              DropdownMenu<ColorLabel>(
                requestFocusOnTap:
                    true, // để input text được trên virtual device
                initialSelection: ColorLabel.green,
                controller: colorController,
                label: const Text('Color'),
                dropdownMenuEntries: colorEntries,
                onSelected: (ColorLabel? color) {
                  setState(() {
                    selectedColor = color;
                  });
                },
              ),
              const SizedBox(width: 20),
              DropdownMenu<IconLabel>(
                requestFocusOnTap:
                    true, // để input text được trên virtual device
                controller: iconController,
                enableFilter: true,
                leadingIcon: const Icon(Icons.search),
                label: const Text('Icon'),
                dropdownMenuEntries: iconEntries,
                inputDecorationTheme: const InputDecorationTheme(
                  filled: true,
                  contentPadding: EdgeInsets.symmetric(vertical: 5.0),
                ),
                onSelected: (IconLabel? icon) {
                  setState(() {
                    selectedIcon = icon;
                  });
                },
              )
            ],
          ),
        ),
        if (selectedColor != null && selectedIcon != null)
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                  'You selected a ${selectedColor?.label} ${selectedIcon?.label}'),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Icon(
                  selectedIcon?.icon,
                  color: selectedColor?.color,
                ),
              )
            ],
          )
        else
          const Text('Please select a color and an icon.')
      ],
    );
  }
}
