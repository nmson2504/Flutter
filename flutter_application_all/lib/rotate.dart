import 'package:flutter/material.dart';
import 'dart:math' as math;

class MyRotate extends StatelessWidget {
  const MyRotate({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Flutter Rotate Object')),
        body: const DemoTonghop(),
        // backgroundColor: Color.fromARGB(255, 235, 217, 163),
      ),
    );
  }
}

// RotatedBoxDemo

class RotatedBoxDemo extends StatefulWidget {
  const RotatedBoxDemo({super.key});

  @override
  State<RotatedBoxDemo> createState() => _RotatedBoxDemoState();
}

class _RotatedBoxDemoState extends State<RotatedBoxDemo> {
  // Variable to track the number of rotations
  // Rotations back clockwise using negative numbers
  int rotations = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('RotatedBox Demo'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            const Text(
                'Text line 1 -  Rotate the child by the specified number of turns'),
            const Text(
                'Text line 2 -  Rotate the child by the specified number of turns'),
            const Text(
                'Text line 3 - Rotate the child by the specified number of turns'),
            const SizedBox(
              height: 20,
            ),
            RotatedBox(
              quarterTurns:
                  rotations, // Rotate the child by the specified number of turns
              child: Container(
                color: Colors.amber,
                width: 100,
                height: 50,
                child: const Center(
                  child: Text(
                    'Rotated Object',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                // Update the rotations variable and trigger a rebuild
                setState(() {
                  rotations += -1;
                });
              },
              child: const Text('Click to rotate'),
            ),
          ],
        ),
      ),
    );
  }
}

// TransformDemo - Transform.rotate
/// Creates a widget that transforms its child using a rotation around the center.
/// The angle argument gives the rotation in clockwise radians.
/// Rotations back clockwise using negative values
class TransformDemo extends StatefulWidget {
  const TransformDemo({super.key});

  @override
  State<TransformDemo> createState() => _TransformDemoState();
}

class _TransformDemoState extends State<TransformDemo> {
  double rotationAngle = 0; // đơn vị radian. 1 radian = 180/pi(xấp xỉ 57 độ)
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Transform Demo'),
        ),
        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            const Text(
                'Text line 1 -  Transform.rotate the child by the specified number of turns'),
            const Text(
                'Text line 2 -  Transform.rotate the child by the specified number of turns'),
            const Text(
                'Text line 3 - Transform.rotate the child by the specified number of turns'),
            const SizedBox(
              height: 20,
            ),
            Transform.rotate(
              angle: rotationAngle,
              child: Container(
                width: 100,
                height: 100,
                color: Colors.blue,
                child: const Center(
                  child: Text(
                    'Rotated',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            // rotationAngle tăng thêm 45 độ (hoặc 45.0 * (3.14159 / 180.0) radians),
            // 3.14159 / 180.0 là hệ số chuyển đổi từ độ sang radian, vì Transform.rotate yêu cầu góc xoay ở đơn vị radian.
            // Nếu ko dùng độ thì có thể chia đường tròn(2pi) thành nhiều phần, vdu 1/2pi, 3/2pi,...
            // Vd chia đường tròn ra làm 8 phần(45 độ), xoay 1/8 thì lấy 1/8 * 2*3.1459 or 1/4 * 3.1459
            ElevatedButton(
              onPressed: () {
                setState(() {
                  // Rotate 45 degrees on each button click
                  // rotationAngle += 45.0 * (3.14159 / 180.0);
                  rotationAngle += 1 / 8 * 2 * 3.14159;
                });
              },
              child: const Text('Rotate'),
            ),
          ],
        )));
  }
}

// TransformDemo1 - Transform với thuộc tính transform
/// Creates a widget that transforms its child using a rotation around the center.
/// The angle argument gives the rotation in clockwise radians.

class TransformDemo1 extends StatefulWidget {
  const TransformDemo1({super.key});

  @override
  State<TransformDemo1> createState() => _TransformDemo1State();
}

class _TransformDemo1State extends State<TransformDemo1> {
  double rotationAngle = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Transform1 Demo'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Transformed'),
            const SizedBox(height: 20),

            /// . Thuộc tính alignment được sử dụng để đặt vị trí của Transform trong Container, trong khi transform được sử dụng để xoay và làm biến đổi ma trận của Transform. Trong trường hợp này, Matrix4.skewY(0.3) sẽ làm nghiêng theo trục Y, và rotateZ(-math.pi / 12.0) sẽ xoay theo trục Z.
            Transform(
              alignment: Alignment.topCenter,
              transform: Matrix4.skewY(0.2)..rotateZ(rotationAngle),
              child: Container(
                width: 100,
                height: 100,
                color: Colors.red,
                child: const Center(
                  child: Text(
                    'Transformed Box',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  // Xoay 45 độ mỗi lần nút được nhấn
                  rotationAngle += math.pi / 4;
                });
              },
              child: const Text('Rotate'),
            ),
          ],
        ),
      ),
    );
  }
}

// Demo tổng hợp Transform.translate - Transform.scale - Transform.rotate
class DemoTonghop extends StatefulWidget {
  const DemoTonghop({super.key});

  @override
  State<DemoTonghop> createState() => _DemoTonghopState();
}

class _DemoTonghopState extends State<DemoTonghop> {
  double translateX = 0.0;
  double translateY = 0.0;
  double scaleFactor = 1;
  double myAngle = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: const Text("Transforms"),
      ),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            buildTranslate(),
            buildScale(),
            buildRotate(),
          ],
        ),
      ),
    );
  }

  Widget buildTranslate() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Transform.translate(
          // Transform.translate widget is specifying the amount by which the child (in this case, an Icon with the Icons.star symbol) will be translated or moved along the x and y axes.
          offset: Offset(translateX, translateY),
          child: const Icon(
            Icons.star,
            color: Colors.blue,
            size: 50,
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              icon: const Icon(Icons.keyboard_arrow_up),
              color: Colors.blue,
              onPressed: () {
                translate(1);
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: const Icon(
                    Icons.keyboard_arrow_left,
                  ),
                  color: Colors.blue,
                  onPressed: () {
                    translate(4);
                  },
                ),
                const SizedBox(
                  width: 25,
                ),
                IconButton(
                  icon: const Icon(Icons.keyboard_arrow_right),
                  color: Colors.blue,
                  onPressed: () {
                    translate(2);
                  },
                ),
              ],
            ),
            IconButton(
              icon: const Icon(
                Icons.keyboard_arrow_down,
              ),
              color: Colors.blue,
              onPressed: () {
                translate(3);
              },
            ),
          ],
        )
      ],
    );
  }

  translate(int i) {
    switch (i) {
      case 1:
        setState(() {
          translateY -= 10;
        });
        break;
      case 2:
        setState(() {
          translateX += 10;
        });
        break;
      case 3:
        setState(() {
          translateY += 10;
        });
        break;
      case 4:
        setState(() {
          translateX -= 10;
        });
        break;
      default:
        break;
    }
  }

  Widget buildScale() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Creates a widget that scales its child along the 2D plane.
        Transform.scale(
          scale: scaleFactor,
          child: const Icon(
            Icons.star,
            color: Colors.green,
            size: 50,
          ),
        ),
        TextButton(
          child: const Text(
            "Scale",
            style: TextStyle(color: Colors.green),
          ),
          onPressed: () {
            scale();
          },
        ),
      ],
    );
  }

  scale() async {
    /// var i - number of iterations increment scaleFactor - max scaleFactor of widget
    /// Daration - speed change scaleFactor
    for (var i = 0; i < 40; i++) {
      await Future.delayed(const Duration(milliseconds: 20), () {
        setState(() {
          scaleFactor += 0.1;
        });
      });
    }
    for (var i = 0; i < 40; i++) {
      await Future.delayed(const Duration(milliseconds: 20), () {
        setState(() {
          scaleFactor -= 0.1;
        });
      });
    }
  }

  Widget buildRotate() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Creates a widget that transforms its child using a rotation around the center.
        // The angle argument gives the rotation in clockwise radians.
        // rotation back clockwise using negative values
        Transform.rotate(
          angle: myAngle,
          child: const Icon(
            Icons.arrow_upward,
            color: Colors.orange,
            size: 50,
          ),
        ),
        TextButton(
          child: const Text(
            "Rotate",
            style: TextStyle(color: Colors.orange),
          ),
          onPressed: () {
            rotate();
          },
        ),
      ],
    );
  }

  rotate() async {
    // xoay 1 vòng, mỗi nấc 1/8 đường tròn trong 0,5s
    for (var i = 0; i < 8; i++) {
      await Future.delayed(const Duration(milliseconds: 500), () {
        setState(() {
          // -math.pi / 12.0;
          // myAngle += 45.0 * (3.14159 / 180.0);
          myAngle += 1 / 8 * 2 * 3.14159;
        });
      });
    }
  }
}
