import 'package:flutter/material.dart';

// Khai báo các loại button
class MySlider extends StatelessWidget {
  const MySlider({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Flutter Slider')),
        body: const SliderExample(),
      ),
    );
  }
}

class SliderExample extends StatefulWidget {
  const SliderExample({super.key});

  @override
  State<SliderExample> createState() => _SliderExampleState();
}

class _SliderExampleState extends State<SliderExample> {
  var _sliderValue = 0.0;
  double _currentSliderValue = 20.0;
  double _currentSliderValue1 = 20.0;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Divider(),
        Slider(
          value: _sliderValue,
          min: 0,
          max: 100,
          divisions: 20, // chia space trượt ra bao nhiêu phần
          label: _sliderValue
              .round()
              .toString(), // phải set divisions: mới có tác dụng
          onChanged: (newValue) {
            setState(() {
              _sliderValue = newValue;
            });
          },
        ),
        const Divider(),
        Slider(
          value: _currentSliderValue,
          max: 100,
          divisions: 10, // chia space trượt ra bao nhiêu phần
          label: _currentSliderValue.round().toString(),
          onChanged: (double value) {
            setState(() {
              _currentSliderValue = value;
            });
          },
        ),
        const Divider(),
        Slider(
          value: _currentSliderValue1,
          max: 100,
          divisions: 10, // chia space trượt ra bao nhiêu phần
          label: _currentSliderValue1.round().toString(),
          onChanged: (double value) {
            setState(() {
              _currentSliderValue1 = value;
            });
          },
          thumbColor: Colors.amber, // color of nút
          activeColor: Colors.blue, // Màu của vùng slider đã chọn
          inactiveColor: Colors.grey, // Màu của vùng slider chưa chọn
          secondaryActiveColor: Colors.lightGreen,
        ),
      ],
    );
  }
}
