import 'package:flutter/material.dart';

class MyInkWell extends StatelessWidget {
  const MyInkWell({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(useMaterial3: true),
      home: Scaffold(
        appBar: AppBar(title: const Text('InkWell - InkResponse Sample')),
        body: const DemoInkWell001(),
      ),
    );
  }
}

//
//
class DemoInkWell001 extends StatefulWidget {
  const DemoInkWell001({super.key});

  @override
  State<DemoInkWell001> createState() => _DemoInkWell001State();
}

class _DemoInkWell001State extends State<DemoInkWell001> {
  int _volume = 0;
  int _count = 0;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
            child: Column(children: [
          //  // object 1 -  InkWell
          InkWell(
              splashColor: Colors.green,
              highlightColor: Colors.blue,
              child: const Icon(Icons.ring_volume, size: 50),
              onTap: () {
                setState(() {
                  _volume += 2;
                });
              }),
          Text('$_volume InkWell', style: const TextStyle(fontSize: 30)),
          const Divider(),
          //  // object 2 - InkResponse
          InkResponse(
              highlightShape: BoxShape.rectangle,
              splashColor: Colors.yellow,
              highlightColor:
                  const Color.fromARGB(255, 250, 66, 250).withOpacity(0.5),
              child: const Icon(Icons.add_circle,
                  size: 50, color: Color.fromARGB(255, 65, 7, 255)),
              onTap: () {
                setState(() {
                  _count += 1;
                });
              }),
          Text('$_count InkResponse', style: const TextStyle(fontSize: 30)),
          const Divider(),
          // object 3 - Ink - InkWell
          Ink(
              height: 60,
              width: 60,
              color: Colors.amber,
              child: InkWell(
                  splashColor: Colors.green,
                  highlightColor: Colors.blue,
                  child: const Icon(Icons.abc_sharp, size: 50),
                  onTap: () {
                    setState(() {
                      _volume += 2;
                    });
                  })),
          Text('$_volume Ink - InkWell', style: const TextStyle(fontSize: 30)),
          const Divider(),
          // object 4 - InkWell - Ink
          InkWell(
              splashColor: Colors.green,
              highlightColor: Colors.blue,
              onTap: () {
                setState(() {
                  _volume += 2;
                });
              },
              child: Ink(
                color: Colors.amber,
                child: const Icon(Icons.ring_volume, size: 60),
              )),
          Text('$_volume InkWell - Ink', style: const TextStyle(fontSize: 30)),
          const Divider(),

          // object 5 - InkResponse - Ink
          // lồng ngược lại Ink - InkResponse sẽ phát sinh lỗi
          InkResponse(
              splashColor: Colors.green,
              highlightColor: Colors.blue,
              onTap: () {
                setState(() {
                  _volume += 2;
                });
              },
              child: Ink(
                height: 100,
                width: 100,
                color: Colors.amber,
                child: const Icon(Icons.ring_volume, size: 50),
              )),
          Text('$_volume - InkResponse - Ink',
              style: const TextStyle(fontSize: 30)),
          // const Divider(),
        ]))
      ],
    );
  }
}
