import 'package:flutter/material.dart';

class MySizedBox extends StatelessWidget {
  const MySizedBox({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(title: const Text('Flutter SizedBox')),
          body: SizedBox(
            width: 300,
            height: double
                .maxFinite, // double.infinity - giá trị vô cực, full hết màn hình
            /* 
            cực âm: double.negativeInfinity, double.minPositive
            cực dương: double.infinity, double.maxFinite
             */
            child: Container(
              color: Colors.blue,
              child: const Center(
                child: Text('SizedBox Example'),
              ),
            ),
          )),
    );
  }
}

class MySizedBoxSpace extends StatelessWidget {
  const MySizedBoxSpace({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Flutter SizedBox Space')),
        body: const Row(children: [
          Text(
            'text 001',
            style: TextStyle(backgroundColor: Colors.deepOrange),
          ),
          SizedBox(
            width: 10,
          ),
          Text(
            'text 011',
            style: TextStyle(backgroundColor: Colors.deepOrange),
          ),
          SizedBox(
            width: 10,
          ),
          Text(
            'text 101',
            style: TextStyle(backgroundColor: Colors.deepOrange),
          ),
          SizedBox(
            width: 10,
          ),
          Text(
            'text 111',
            style: TextStyle(backgroundColor: Colors.deepOrange),
          ),
        ]),
      ),
    );
  }
}

class MySizedBoxShrink extends StatelessWidget {
  const MySizedBoxShrink({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(title: const Text('Flutter SizedBox 2')),
          body: ConstrainedBox(
              constraints: const BoxConstraints(
                // Min: 80x20 - ghi đè lên các thuộc tính tương đương của object con
                // *Nếu ko set values cặp thuộc tính minWidth/minHeight thì object con sẽ ko show ra
                minWidth: 200.0,
                minHeight: 200.0,
              ),
              child: SizedBox.shrink(
                child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(
                            255, 250, 253, 66), // cũ là primary
                        foregroundColor: const Color.fromARGB(163, 14, 246, 2),
                        fixedSize: const Size(300, 300),
                        minimumSize: const Size(200, 200)),
                    child: const Text('Button')),
              ))),
    );
  }
}

class MySizedBoxSize extends StatelessWidget {
  const MySizedBoxSize({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(title: const Text('Flutter SizedBox.fromSize')),
            body: SizedBox.fromSize(
              size: const Size(200, 200),
              child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(
                        255, 250, 253, 66), // cũ là primary
                  ),
                  child: const Text('Button SizedBox.fromSize')),
            )));
  }
}
