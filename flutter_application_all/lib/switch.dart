import 'package:flutter/material.dart';

class MySwitch extends StatelessWidget {
  const MySwitch({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(useMaterial3: true),
      home: Scaffold(
        appBar: AppBar(title: const Text('Switch Sample')),
        body: const SwitchExample(),
      ),
    );
  }
}

class SwitchExample extends StatefulWidget {
  const SwitchExample({super.key});

  @override
  State<SwitchExample> createState() => _SwitchExampleState();
}

class _SwitchExampleState extends State<SwitchExample> {
  // định nghĩa các thuôc tính, hàm cho Switch sử dụng
  // * thuộc tính value: nếu các switch gán trùng tên biến thì các switch này sẽ update trạng thái cùng lúc với nhau
  // switch 1
  bool light = false;
// switch 2
  bool _isSwitchOn = true;
  void _toggleSwitch(bool value) {
    setState(() {
      _isSwitchOn = value;
    });
  }

  // switch 3
  bool light_3 = false;
  final MaterialStateProperty<Icon?> thumbIcon =
      MaterialStateProperty.resolveWith<Icon?>(
    (Set<MaterialState> states) {
      if (states.contains(MaterialState.selected)) {
        return const Icon(Icons.check);
      }
      return const Icon(Icons.close);
    },
  );
// switch 4
  bool light_4 = false;
  // switch 5
  bool light_5 = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('Switch Status: $light'),
        Switch(
          // This bool value toggles the switch.
          value: light, // set value true/false ban đầu
          activeColor: Colors.red,
          onChanged: (bool value) {
            // This is called when the user toggles the switch.
            setState(() {
              light = value; // switch value (true/false) khi click switch
            });
          },
        ),
        const Divider(),
        Text('Switch Status: $_isSwitchOn'),
        Switch(
          value: _isSwitchOn, // set value true/false ban đầu
          onChanged:
              _toggleSwitch, // switch value (true/false) khi click switch qua hàm _toggleSwitch
        ),
        Switch(
          thumbIcon: thumbIcon, // edit icon cho 2 trạng thái true/false
          value: light_3,
          onChanged: (bool value) {
            setState(() {
              light_3 = value;
            });
          },
        ),
        Text('Switch Status: $light_4'),
        Switch(
          value: light_4,
          onChanged: (bool value) {
            setState(() {
              light_4 = value;
            });
          },

          activeColor: Colors.green, // Màu nút khi switch bật
          inactiveThumbColor:
              Color.fromARGB(255, 215, 215, 215), // Màu nút bấm khi switch tắt
          inactiveTrackColor: Colors.red, // Màu đường dẫn khi switch tắt
          activeTrackColor: Colors.amber, // Màu đường dẫn khi switch bật
          // set màu qua thumbColor:
          thumbColor: MaterialStateProperty.resolveWith<Color>(
              (Set<MaterialState> states) {
            if (states.contains(MaterialState.selected)) {
              return Colors
                  .blue; // Màu nút bấm khi switch bật - ghi đè activeColor:
            }
            return Colors
                .grey; // Màu nút bấm khi switch tắt - ghi đè inactiveThumbColor:
          }),
        ),
        Text('Switch 5 Status: $light_5'),
        Switch(
          value: light_5,
          onChanged: (bool value) {
            setState(() {
              light_5 = value;
            });
          },
          thumbColor: MaterialStateProperty.resolveWith<Color>(
              (Set<MaterialState> states) {
            if (states.contains(MaterialState.disabled)) {
              return Colors.grey; // Màu nút bấm khi switch bị vô hiệu hóa
            }
            if (states.contains(MaterialState.hovered)) {
              return Colors.blue; // Màu nút bấm khi switch được hover
            }
            if (states.contains(MaterialState.focused)) {
              return Colors
                  .green; // Màu nút bấm khi switch được tập trung vào (bấm tab để chuyển focus)
            }
            if (states.contains(MaterialState.selected)) {
              return Colors.green; // Màu nút bấm khi switch bật
            }
            return const Color.fromARGB(
                255, 85, 66, 65); // Màu nút bấm khi switch tắt
          }),
          trackColor: MaterialStateProperty.resolveWith<Color>(
              (Set<MaterialState> states) {
            if (states.contains(MaterialState.disabled)) {
              return Colors.grey; // Màu đường dẫn khi switch bị vô hiệu hóa
            }
            if (states.contains(MaterialState.hovered)) {
              return Colors.lightBlue; // Màu đường dẫn khi switch được hover
            }
            if (states.contains(MaterialState.focused)) {
              return Colors
                  .lightGreen; // Màu đường dẫn khi switch được tập trung vào
            }
            if (states.contains(MaterialState.selected)) {
              return Colors.lightGreen; // Màu đường dẫn khi switch bật
            }
            return const Color.fromARGB(
                255, 224, 160, 160); // Màu đường dẫn khi switch tắt
          }),
        ),
      ],
    );
  }
}
