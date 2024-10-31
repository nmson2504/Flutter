import 'package:flutter/material.dart';
import 'package:device_preview/device_preview.dart';

class MyDemoFlip extends StatelessWidget {
  const MyDemoFlip({super.key});

  @override
  Widget build(BuildContext context) {
    var mapC = {
      1: () => const FlipImage(),
      2: () => const FlipImageWithScale(),
      3: () => const MyHomePage(),
      4: () => const MyTransform(),
      // 5: () => const AnimatedSwitcher04(),
      // 6: () => const BasicHeroAnimation5(),
      // 7: () => const BasicHeroAnimation6(),
      // 8: () => const MyHomePage(title: 'Hero with placeholderBuilder'),
      // 9: () => const HeroPlaceholderDemoApp(),
      // 10: () => const BasicHeroAnimation3(),
    };
    int n = 4; // Giá trị n có thể thay đổi
    // Kiểm tra nếu map chứa key n
    Widget bodyWidget;
    if (mapC.containsKey(n)) {
      bodyWidget = mapC[n]!(); // Gọi hàm trả về Widget
    } else {
      bodyWidget = const Center(child: Text('Không tìm thấy widget'));
    }

    return MaterialApp(
      useInheritedMediaQuery: true,
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
      home: bodyWidget, // Truyền Widget vào body
    );
  }
}

/* 
RotationTransition - Creates a rotation transition.
 */

class FlipImage extends StatefulWidget {
  const FlipImage({super.key});

  @override
  _FlipImageState createState() => _FlipImageState();
}

class _FlipImageState extends State<FlipImage> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: RotationTransition(
          turns: Tween(begin: 0.0, end: 0.5).animate(_controller), // Xoay 180 độ (0.5 vòng)
          child: Image.asset('images/avatar1.png'),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (_controller.isCompleted) {
            _controller.reverse();
          } else {
            _controller.forward();
          }
        },
        child: const Icon(Icons.flip),
      ),
    );
  }
}

// ScaleTransition: Widget này tạo hiệu ứng phóng to hoặc thu nhỏ cho widget con.
/* 
 */

class FlipImageWithScale extends StatefulWidget {
  const FlipImageWithScale({super.key});

  @override
  _FlipImageWithScaleState createState() => _FlipImageWithScaleState();
}

class _FlipImageWithScaleState extends State<FlipImageWithScale> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );
    _animation = Tween<double>(begin: 1.0, end: -1.0).animate(_controller);
    // giá trị của Tween: 1.0 - scale 100%, dấu (-) - đảo ngược ảnh
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ScaleTransition(
          scale: _animation,
          child: Image.asset('images/avatar2.png'),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (_controller.isCompleted) {
            _controller.reverse();
          } else {
            _controller.forward();
          }
        },
        child: const Icon(Icons.flip),
      ),
    );
  }
}

// ScaleTransition: Widget này tạo hiệu ứng phóng to hoặc thu nhỏ cho widget con.

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  bool _isScaled = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ScaleTransition Demo'),
      ),
      body: Center(
        child: GestureDetector(
          onTap: () {
            setState(() {
              _isScaled = !_isScaled;
              // print(_isScaled);
            });
          },
          child: ScaleTransition(
            scale: AnimationController(
              vsync: this,
              duration: const Duration(milliseconds: 500),
              value: _isScaled ? 0.5 : 1.0, // 1.0 - 100%
            ),
            child: Image.asset('images/day-night.png'),
          ),
        ),
      ),
    );
  }
}
// Transform - lật ảnh với  transform: Matrix4.identity()..scale

class MyTransform extends StatefulWidget {
  const MyTransform({super.key});

  @override
  _MyTransformState createState() => _MyTransformState();
}

class _MyTransformState extends State<MyTransform> with TickerProviderStateMixin {
  bool isFlipped = false;
  bool isFlippedB = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Transform Demo'),
      ),
      body: Center(
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                setState(() {
                  isFlipped = !isFlipped;
                  // print(_isScaled);
                });
              },
              child: Transform(
                transform: Matrix4.identity()..scale(isFlipped ? -1.0 : 1.0, 1.0), // Lật theo trục X
                alignment: Alignment.center, // Lật từ trung tâm
                child: Image.asset(
                  'images/day-night.png',
                  width: 200,
                ),

                // child: Image.asset('images/day-night.png'),
              ),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  isFlippedB = !isFlippedB;
                  // print(_isScaled);
                });
              },
              child: Transform(
                transform: Matrix4.identity()..scale(1.0, isFlippedB ? -1.0 : 1.0), // Lật theo trục Y
                alignment: Alignment.center, // Lật từ trung tâm
                child: Image.asset(
                  'images/day-night.png',
                  width: 200,
                ),

                // child: Image.asset('images/day-night.png'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
