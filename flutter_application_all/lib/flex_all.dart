import 'package:flutter/material.dart';

class MyFlex extends StatelessWidget {
  const MyFlex({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Flutter Row')),
        body: const MyFlexibleRowFit(),
        // backgroundColor: Color.fromARGB(255, 235, 217, 163),
      ),
    );
  }
}

class MyWidgetFlex extends StatelessWidget {
  const MyWidgetFlex({super.key});

  @override
  Widget build(BuildContext context) {
    return Flex(
      direction: Axis.horizontal, // hoặc Axis.horizontal
      children: [
        Flexible(
            flex: 2,
            child: Container(
              color: Colors.red,
              child: const Text('Flexible 1'),
            )),
        Flexible(
            flex: 1,
            child: Container(
              color: Colors.green,
              child: const Text('Flexible 2'),
            )),
        Flexible(
            flex: 3,
            child: Container(
              color: Colors.blue,
              child: const Text('Flexible 3'),
            )),
      ],
    );
  }
}

class MyFlexibleRow extends StatelessWidget {
  const MyFlexibleRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
          // flex: 2,
          child: Container(
            color: Colors.red,
            child: const Text('Flexible 1'),
          ),
        ),
        Flexible(
          flex: 1,
          child: Container(
            color: Colors.green,
            child: const Text('Flexible 2'),
          ),
        ),
        Flexible(
          flex: 3,
          child: Container(
            color: Colors.blue,
            child: const Text('Flexible 3'),
          ),
        ),
      ],
    );
  }
}

class MyFlexibleRowFit extends StatelessWidget {
  const MyFlexibleRowFit({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromARGB(255, 195, 188, 195),
      // height: 600,
      // width: 400,
      child: Column(
        children: <Widget>[
          Flexible(
              flex: 2,
              fit: FlexFit.tight,
              child: Container(
                height: 100,
                width: 400,
                color: Colors.green,
              )),
          Flexible(
            flex: 2,
            fit: FlexFit.tight,
            child: Container(
              color: Colors.blue,
            ),
          ),
          Flexible(
            flex: 1,
            fit: FlexFit.tight,
            child: Container(
              color: const Color.fromARGB(255, 243, 110, 33),
            ),
          ),
        ],
      ),
    );
  }
}

class MyFlexibleCol extends StatelessWidget {
  const MyFlexibleCol({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromARGB(255, 195, 188, 195),
      height: 600,
      child: Column(
        children: <Widget>[
          Flexible(
              flex: 1,
              child: Container(
                height: 150,
                color: const Color.fromARGB(255, 249, 224, 32),
              )),
          Flexible(
              // flex: 1, // default flex = 1
              // flex: 3,
              child: Container(
            height: 150,
            color: Colors.green,
          )),
          Flexible(
              flex: 3,
              child: Container(
                // height: 220,
                color: Colors.blue,
              )),
        ],
      ),
    );
  }
}

class MyWidgetSpacer extends StatelessWidget {
  const MyWidgetSpacer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      color: Colors.amber,
      child: Column(
        children: [
          OutlinedButton(onPressed: () {}, child: const Text('Button A')),
          const Spacer(), // = Spacer(flex: 1),
          OutlinedButton(onPressed: () {}, child: const Text('Button B')),
          const Spacer(flex: 2),
          OutlinedButton(onPressed: () {}, child: const Text('Button C')),
          const Spacer(flex: 2),
          OutlinedButton(onPressed: () {}, child: const Text('Button D')),
        ],
      ),
    );
  }
}

class MyWidget1 extends StatelessWidget {
  const MyWidget1({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      // width: 200,
      height: 70,
      color: const Color.fromARGB(255, 240, 195, 57),
      child: Row(children: [
        Expanded(
            child:
                ElevatedButton(child: const Text("BTN 1"), onPressed: () {})),
        Expanded(
            flex: 1,
            child:
                ElevatedButton(child: const Text("BTN 2"), onPressed: () {})),
        Expanded(
            flex: 0,
            child:
                ElevatedButton(child: const Text("BTN 3"), onPressed: () {})),
        Expanded(
            flex: 2,
            child:
                ElevatedButton(child: const Text("BTN 4"), onPressed: () {})),
        ElevatedButton(child: const Text("BTN 5"), onPressed: () {}),
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
      height: 70,
      color: const Color.fromARGB(255, 240, 195, 57),
      child: Row(children: [
        Expanded(
            child:
                ElevatedButton(child: const Text("BTN 1"), onPressed: () {})),
        ElevatedButton(child: const Text("BTN 2"), onPressed: () {}),
        Expanded(
            flex: 0,
            child:
                ElevatedButton(child: const Text("BTN 3"), onPressed: () {})),
        Expanded(
            flex: 0,
            child:
                ElevatedButton(child: const Text("BTN 4"), onPressed: () {})),
        ElevatedButton(child: const Text("BTN 5"), onPressed: () {}),
      ]),
    );
  }
}

class MyWidget3 extends StatelessWidget {
  const MyWidget3({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      height: 500,
      color: const Color.fromARGB(255, 240, 195, 57),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          verticalDirection: VerticalDirection.down,
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(child: const Text("BTN 0"), onPressed: () {}),
            ElevatedButton(child: const Text("BTN 2"), onPressed: () {}),
            ElevatedButton(child: const Text("BTN 3"), onPressed: () {}),
            ElevatedButton(child: const Text("BTN 4"), onPressed: () {}),
            ElevatedButton(child: const Text("BTN 5"), onPressed: () {}),
          ]),
    );
  }
}
