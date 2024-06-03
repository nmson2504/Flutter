import 'package:flutter/material.dart';

class MyDropDownButton extends StatelessWidget {
  const MyDropDownButton({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(useMaterial3: true),
      home: Scaffold(
        appBar: AppBar(title: const Text('MyDropDownButton  Sample')),
        body: const MyDropDownButton1(),
      ),
    );
  }
}

//
class MyDropDownButton0 extends StatefulWidget {
  const MyDropDownButton0({super.key});

  @override
  State<MyDropDownButton0> createState() => _MyDropDownButton0State();
}

class _MyDropDownButton0State extends State<MyDropDownButton0> {
  String selectedOption = 'Option 1'; // Giá trị mặc định được chọn
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          DropdownButton<String>(
            value: selectedOption, // set value mặc định
            onChanged: (String? newValue) {
              // required ValueChanged<T?>? onChanged - xử lý event khi click chọn thay đổi item
              setState(() {
                selectedOption = newValue!;
              });
            },
            //  required List<DropdownMenuItem<T>>? items - define various items that are to be defined in dropdown menu/list
            items: <String>['Option 1', 'Option 2', 'Option 3']
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
          Container(
            alignment: Alignment.bottomRight,
            child: Text(
              'Bạn đã chọn: $selectedOption',
              style: const TextStyle(fontSize: 18),
            ),
          ),
        ],
      ),
    );
  }
}

//
class MyDropDownButton1 extends StatefulWidget {
  const MyDropDownButton1({super.key});

  @override
  State<MyDropDownButton1> createState() => _MyDropDownButton1();
}

const List<String> list = <String>['One', 'Two', 'Three', 'Four'];
String dropdownValue = list.first;

class _MyDropDownButton1 extends State<MyDropDownButton1> {
  String selectedOption = dropdownValue; // Giá trị mặc định được chọn

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          DropdownButton<String>(
            value: dropdownValue,
            icon: const Icon(Icons.arrow_downward),
            elevation: 16,
            style: const TextStyle(color: Colors.deepPurple),
            underline: Container(
              height: 2,
              color: Colors.deepPurpleAccent,
            ),
            disabledHint: const Text('still disable'),
            hint: const Text('click choice option'),
            // onChanged: (null), // dropdown button will be disabled
            onChanged: (String? value) {
              // This is called when the user selects an item.
              setState(() {
                dropdownValue = value!;
                selectedOption = value;
              });
            },
            items: list.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
          Container(
            alignment: Alignment.bottomRight,
            child: Text(
              'Bạn đã chọn: $selectedOption',
              style: const TextStyle(fontSize: 18),
            ),
          ),
        ],
      ),
    );
  }
}

//
