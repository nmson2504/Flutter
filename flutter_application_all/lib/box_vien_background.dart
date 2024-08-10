import 'package:flutter/material.dart';

// Khai báo các loại button
class MyBoxTongHop extends StatelessWidget {
  const MyBoxTongHop({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyBox1(),
    );
  }
}

// Với các widget đơn giản
class MyBox1 extends StatelessWidget {
  const MyBox1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Box with Border"),
      ),
      body: Column(
        children: [
          // Container with BoxDecoration
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.black, // Màu viền
                width: 2.0, // Độ dày viền
              ),
            ),
            child: const Center(
              child: Text('Container with BoxDecoration'),
            ),
          ),
          // Container with BoxDecoration - borderRadius
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.orange,
                width: 2.0,
              ),
              borderRadius: BorderRadius.circular(8.0), // Bo tròn các góc
            ),
            child: const Center(
              child: Text('Rounded Border'),
            ),
          ),
// Container with boxShadow
          Container(
            width: 150,
            height: 150,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: Colors.blue,
                width: 2.0,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: const Center(child: Text('Box tròn')),
          ),

          // Card with BorderSide
          Card(
            elevation: 4.0,
            shape: RoundedRectangleBorder(
              side: const BorderSide(
                color: Colors.red,
                width: 2.0,
              ),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: const SizedBox(
              width: 100,
              height: 100,
              child: Center(
                child: Text('Card with Border'),
              ),
            ),
          ),
          // DecoratedBox with BoxDecoration
          DecoratedBox(
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.green,
                width: 4.0,
              ),
            ),
            child: const SizedBox(
              width: 100,
              height: 100,
              child: Center(
                child: Text('Decorated Box'),
              ),
            ),
          )
        ],
      ),
    );
  }
}
