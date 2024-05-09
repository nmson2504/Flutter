import 'package:flutter/material.dart';

class MyRow extends StatelessWidget {
  const MyRow({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Flutter Row')),
        body: const MyWidget6(),
        // backgroundColor: Color.fromARGB(255, 235, 217, 163),
      ),
    );
  }
}
//---------------------------

class MyRowReverse2 extends StatelessWidget {
  const MyRowReverse2({super.key});

  @override
  Widget build(BuildContext context) {
    return const MyReversedRow();
  }
}

class MyReversedRow extends StatefulWidget {
  const MyReversedRow({super.key});

  @override
  _MyReversedRowState createState() => _MyReversedRowState();
}

class _MyReversedRowState extends State<MyReversedRow> {
  bool reversed = false;
  List<Widget> children = [
    Container(
      color: Colors.red,
      width: 50,
      height: 50,
    ),
    Container(
      color: Colors.green,
      width: 50,
      height: 50,
    ),
    Container(
      color: Colors.blue,
      width: 50,
      height: 50,
    ),
  ];

  void toggleOrder() {
    setState(() {
      reversed = !reversed;
      children = reversed ? children.reversed.toList() : children;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: children,
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: toggleOrder,
          child: Text(reversed ? 'Restore Order' : 'Reverse Order'),
        ),
      ],
    );
  }
}

//---------------------------
class MyRowReverse extends StatelessWidget {
  const MyRowReverse({super.key});

  @override
  Widget build(BuildContext context) {
    List<Widget> children = [
      Container(
        color: Colors.red,
        width: 50,
        height: 50,
      ),
      Container(
        color: Colors.green,
        width: 50,
        height: 50,
      ),
      Container(
        color: Colors.blue,
        width: 50,
        height: 50,
      ),
    ];
    ElevatedButton(child: const Text("BTN 02"), onPressed: () {});
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: children.reversed.toList(), // Đảo ngược danh sách widget con
    );
  }
}

class MyWidget1 extends StatelessWidget {
  const MyWidget1({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromARGB(255, 222, 228, 231),
      child: Row(children: [
        ElevatedButton(child: const Text("BTN 1"), onPressed: () {}),
        const Icon(Icons.ac_unit, size: 64, color: Colors.blue),
        ElevatedButton(
            onPressed: () {},
            style: ButtonStyle(
                minimumSize: MaterialStateProperty.all(const Size.square(100))),
            child: const Text("Button 2")),
        ElevatedButton(child: const Text("BTN 3"), onPressed: () {}),
      ]),
    );
  }
}

class MyWidget3 extends StatelessWidget {
  const MyWidget3({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 300,
      color: const Color.fromARGB(255, 249, 122, 17),
      child: Row(
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline
              .alphabetic, // Add this line to avoid errors: l(crossAxisAlignment, CrossAxisAlignment.baseline) || textBaseline != null': textBaseline is required if you specify the crossAxisAlignment with CrossAxisAlignment.baseline)
          children: [
            ElevatedButton(child: const Text("BTN 1"), onPressed: () {}),
            const Icon(Icons.ac_unit, size: 64, color: Colors.blue),
            ElevatedButton(
                onPressed: () {},
                style: ButtonStyle(
                    minimumSize:
                        MaterialStateProperty.all(const Size.square(60))),
                child: const Text("Button 2")),
            ElevatedButton(child: const Text("BTN 3"), onPressed: () {}),
          ]),
    );
  }
}

class MyWidget4 extends StatelessWidget {
  const MyWidget4({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      color: const Color.fromARGB(255, 249, 122, 17),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        ElevatedButton(child: const Text("BTN 1"), onPressed: () {}),
        const Icon(Icons.ac_unit, size: 64, color: Colors.blue),
        ElevatedButton(
            onPressed: () {},
            style: ButtonStyle(
                minimumSize: MaterialStateProperty.all(const Size.square(60))),
            child: const Text("Button 2")),
        ElevatedButton(child: const Text("BTN 3"), onPressed: () {}),
      ]),
    );
  }
}

class MyWidget2 extends StatelessWidget {
  const MyWidget2({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      // width: 200,
      // height: 600,
      color: const Color.fromARGB(255, 240, 195, 57),
      child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          verticalDirection: VerticalDirection.up, // Đổi hướng sắp xếp dọc
          children: [
            ElevatedButton(child: const Text("BTN 01"), onPressed: () {}),
            const Icon(
              Icons.ac_unit,
              size: 64,
              color: Colors.blue,
            ),
            ElevatedButton(child: const Text("BTN 02"), onPressed: () {}),
            ElevatedButton(child: const Text("BTN 03"), onPressed: () {}),
          ]),
    );
  }
}

// Align từng elements
class MyWidget5 extends StatelessWidget {
  const MyWidget5({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      color: const Color.fromARGB(255, 240, 195, 57),
      child: Row(
          // crossAxisAlignment: CrossAxisAlignment.stretch,
          // verticalDirection: VerticalDirection.up, // Đổi hướng sắp xếp dọc
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child:
                  ElevatedButton(child: const Text("BTN 01"), onPressed: () {}),
            ),
            const Padding(
              padding: EdgeInsets.only(bottom: 50),
              child: Icon(
                Icons.ac_unit,
                size: 64,
                color: Colors.blue,
              ),
            ),
            Container(
                alignment: Alignment.center,
                child: ElevatedButton(
                    child: const Text("BTN 02"), onPressed: () {})),
            Container(
                alignment: Alignment.bottomRight,
                child: ElevatedButton(
                    child: const Text("BTN 03"), onPressed: () {})),
          ]),
    );
  }
}

// Align từng elements với CrossAxisAlignment.stretch
class MyWidget6 extends StatelessWidget {
  const MyWidget6({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      color: const Color.fromARGB(255, 240, 195, 57),
      child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          // verticalDirection: VerticalDirection.up, // Đổi hướng sắp xếp dọc
          children: [
            ElevatedButton(child: const Text("BTN 01"), onPressed: () {}),
            Container(
              width: 150,
              color: Colors.green[100],
              alignment: Alignment.topCenter,
              child: const Icon(
                Icons.ac_unit,
                size: 64,
                color: Colors.blue,
              ),
            ),
            Container(
                color: Colors.black45,
                width: 200,
                alignment: const AlignmentDirectional(0, 1),
                child: ElevatedButton(
                    child: const Text("BTN 02"), onPressed: () {})),
            Container(
                alignment: const AlignmentDirectional(0, -0.5),
                child: ElevatedButton(
                    child: const Text("BTN 03"), onPressed: () {})),
          ]),
    );
  }
}

class MyVerticalDirection extends StatelessWidget {
  const MyVerticalDirection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      verticalDirection:
          VerticalDirection.up, // Đổi hướng sắp xếp dọc trong column
      children: [
        Container(
          color: Colors.red,
          width: 50,
          height: 50,
        ),
        Container(
          color: Colors.green,
          width: 50,
          height: 50,
        ),
        Container(
          color: Colors.blue,
          width: 50,
          height: 50,
        ),
        Container(
          color: Colors.yellow,
          width: 50,
          height: 50,
        ),
      ],
    );
  }
}
