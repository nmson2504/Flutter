import 'package:flutter/material.dart';
import 'test_function.dart';

// Padding, Margin & DefaultTextStyle
class PaddingAndMargin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
            title: // Text('Padding & Margin Example'),
                const Card(
          margin: EdgeInsets.all(40.0), // Khoảng cách xung quanh thẻ
          child: Column(
            children: [
              ListTile(title: Text('PaddingAndMargin')),
              Padding(
                padding: EdgeInsets.all(5.0), // Lề cho nội dung bên trong
                child: Text('Content'),
              ),
            ],
          ),
        )),
        // call 1 trong 2 widget in this
        // body: DefaultTextStyleDemo(),
        body: PaddingAndMarginThamSo(20),
      ),
    );
  }
}
////////////

/// set value cho margin, padding qua tham số truyền vào widger
class PaddingAndMarginThamSo extends StatelessWidget {
  double pixel = 0;
  PaddingAndMarginThamSo(this.pixel);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(50.0),
      color: Colors.amber,
      child: Padding(
        // padding: EdgeInsets.all(10.0), // set cùng value cho 4 cạnh
        // padding: EdgeInsets.fromLTRB(10, 10, 20,20), // set value cho từng cạnh: Left - Top - Right - Bottom
        // padding: EdgeInsets.only(left: 30), // set value cho các cạnh chỉ định
        // padding: EdgeInsets.only(left: 30, bottom: 30),
        padding: EdgeInsets.symmetric(
            horizontal: pixel), // set value 2 cạnh đối xứng (symmetric)
        // padding: EdgeInsets.symmetric(horizontal: 10, vertical: 40),
        // child: Text('Flutter self-taught'),
        child: const Text('Flutter'),
      ),
    );
  }
}

///// dùng DefaultTextStyle.of(context).style lấy TextStyle hiện tại của widget cha áp dụng cho widget con
class DefaultTextStyleDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TextStyle currentTextStyle = DefaultTextStyle.of(context).style;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'DefaultTextStyleDemo',
          style: currentTextStyle, // Sử dụng TextStyle hiện tại của widget cha
        ),
        ElevatedButton(
          onPressed: () {
            clearScreen();
            TextStyle textStyle = DefaultTextStyle.of(context).style;

            // print('Font size: ${textStyle.fontSize}');
            // print('Font weight: ${textStyle.fontWeight}');
            // print('Color: ${textStyle.color}');
            // In ra các giá trị khác của TextStyle tùy ý

            printText_Para_Style(context: context);
          },
          child: const Text('Print Text Style Values'),
        ),
        Text('${getText_Para_Style(context: context)}'),
      ],
    );
  }
}
