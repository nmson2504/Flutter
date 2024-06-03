import 'package:flutter/material.dart';

class MyWrap extends StatelessWidget {
  const MyWrap({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Flutter Wrap')),
        body: const MyWrap0(),
        // backgroundColor: Color.fromARGB(255, 235, 217, 163),
      ),
    );
  }
}

class MyWrap0 extends StatelessWidget {
  const MyWrap0({super.key});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      direction:
          Axis.vertical, // phương ngang hay dọc. default is Axis.horizontal
      // textDirection: TextDirection.rtl, // chiều xếp childs object .ltr or rtl
      verticalDirection: VerticalDirection
          .down, // chiều xếp childs object up - up to down; down - up to down
      alignment: WrapAlignment
          .spaceAround, // cách xếp đặt vị trí các elements của range chưa được lấp đầy (thường là range cuối)
      crossAxisAlignment: WrapCrossAlignment
          .center, // cách gióng hàng theo phuong crossAxis của 1 range
      spacing: 8.0, // gap between adjacent chips
      runSpacing: 4.0, // gap between lines
      children: <Widget>[
        Chip(
          avatar: CircleAvatar(
              backgroundColor: Colors.blue.shade900, child: const Text('A')),
          label: const Text('Hamilton'),
        ),
        Chip(
          avatar: CircleAvatar(
              backgroundColor: Colors.blue.shade900, child: const Text('B')),
          label: const Text('Lafayette-nmson'),
        ),
        Chip(
          avatar: CircleAvatar(
              backgroundColor: Colors.blue.shade900, child: const Text('C')),
          label: const Text('Mulligan'),
        ),
        Chip(
          avatar: CircleAvatar(
              backgroundColor: Colors.blue.shade900, child: const Text('D')),
          label: const Text('Laurens'),
        ),
        Chip(
          avatar: CircleAvatar(
              backgroundColor: Colors.blue.shade900, child: const Text('E')),
          label: const Text('LafayetteS'),
        ),
        Chip(
          avatar: CircleAvatar(
              backgroundColor: Colors.blue.shade900, child: const Text('F')),
          label: const Text('MulliganS'),
        ),
        Chip(
          avatar: CircleAvatar(
              backgroundColor: Colors.blue.shade900, child: const Text('G')),
          label: const Text('LaurensS'),
        ),
      ],
    );
  }
}

class MyWrap1 extends StatelessWidget {
  const MyWrap1({super.key});

  @override
  Widget build(BuildContext context) {
    return Wrap(
        spacing: 8.0, // Khoảng cách giữa các phần tử con theo chiều ngang
        runSpacing: 12.0, // Khoảng cách giữa các dãy con theo chiều dọc
        children: List.generate(10, (index) {
          return Chip(
            label: Text('Item $index'),
            avatar: CircleAvatar(
              backgroundColor: Colors.blue,
              child: Text('$index'),
            ),
          );
        }));
  }
}
