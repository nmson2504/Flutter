import 'package:flutter/material.dart';

class MyCheckBox extends StatelessWidget {
  const MyCheckBox({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(useMaterial3: true),
      home: Scaffold(
        appBar: AppBar(title: const Text('CheckBox Sample')),
        body: const CheckBox1(),
      ),
    );
  }
}

//

class CheckBox1 extends StatefulWidget {
  const CheckBox1({super.key});

  @override
  State<CheckBox1> createState() => _CheckBox1State();
}

class _CheckBox1State extends State<CheckBox1> {
  bool _isChecked = true;

  void _handleCheckbox(bool value) {
    if (value != null) {
      setState(() {
        _isChecked = value;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // Set color chung cho nhiều sự kiện
    Color getColorGeneral(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
        MaterialState.selected,
      };
      if (states.any(interactiveStates.contains)) {
        return Colors.blue;
      }
      return Colors.red;
    }

// Set color riêng cho từng sự kiện
    Color getColorSeparately(Set<MaterialState> states) {
      if (states.contains(MaterialState.pressed)) {
        // Nếu được nhấn
        return Colors.blue;
      } else if (states.contains(MaterialState.hovered)) {
        // Nếu được hover
        return Colors.green;
      } else if (states.contains(MaterialState.focused)) {
        // Nếu được focus
        return Colors.orange;
      } else if (states.contains(MaterialState.selected)) {
        // Nếu được chọn
        return Color.fromARGB(255, 54, 233, 236);
      }
      // Trạng thái mặc định
      return Colors.red;
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Checkbox(
          value: _isChecked,
          onChanged: (newValue) {
            _handleCheckbox(newValue!);
          },
        ),
        Text('Checkbox is $_isChecked'),
        Checkbox(
          value: _isChecked,
          onChanged: null, // bị mờ đi
        ),
        Text('Checkbox is $_isChecked'),
        Checkbox(
          value: _isChecked,
          onChanged: (bool? ts) {
            setState(() {
              _isChecked = ts!;
            });
          },
        ),
        Text('Checkbox is $_isChecked'),

        // set color inline
        Checkbox(
          checkColor:
              const Color.fromARGB(255, 247, 189, 185), // color dấu check

          // fillColor: MaterialStateProperty.resolveWith((getColor)),
          focusColor: const Color.fromARGB(255, 154, 167, 165),
          hoverColor: const Color.fromARGB(255, 195, 201, 238),
          value: _isChecked,
          onChanged: (bool? ts) {
            _handleCheckbox(ts!);
          },
        ),
        Text('Checkbox set color inline - is $_isChecked'),
        Checkbox(
          checkColor: Colors.red, // color dấu check
          fillColor: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states) {
              if (states.contains(MaterialState.selected)) {
                // Màu nền khi Checkbox được chọn
                return const Color.fromARGB(
                    255, 208, 243, 33); // Thay đổi thành màu bạn muốn
              }
              // Màu nền mặc định khi Checkbox không được chọn
              return Colors.grey; // Thay đổi thành màu bạn muốn
            },
          ),
          // fillColor: MaterialStateProperty.resolveWith((getColor)),
          focusColor: const Color.fromARGB(255, 154, 167, 165),
          hoverColor: const Color.fromARGB(255, 195, 201, 238),
          value: _isChecked,
          onChanged: (bool? ts) {
            _handleCheckbox(ts!);
          },
        ),
        Text('Checkbox set color MaterialStateProperty - is $_isChecked'),

        // set color với MaterialStateProperty qua hàm
        Checkbox(
          fillColor: MaterialStateProperty.resolveWith((getColorGeneral)),
          value: _isChecked,
          onChanged: (bool? ts) {
            setState(() {
              _isChecked = ts!;
            });
          },
        ),
        Text('Checkbox getColorGeneral $_isChecked'),
        Checkbox(
          fillColor: MaterialStateProperty.resolveWith((getColorSeparately)),
          value: _isChecked,
          onChanged: (bool? ts) {
            setState(() {
              _isChecked = ts!;
            });
          },
        ),
        Text('Checkbox getColorSeparately - is $_isChecked'),
      ],
    );
  }
}
