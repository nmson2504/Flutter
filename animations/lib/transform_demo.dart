import 'dart:math';

import 'package:flutter/material.dart';
import 'package:device_preview/device_preview.dart';
import 'dart:math' as math;

class MyDemoTransform extends StatelessWidget {
  const MyDemoTransform({super.key});

  @override
  Widget build(BuildContext context) {
    var mapC = {
      1: () => const TransformDemo(),
      2: () => const MyFlip01(),
      3: () => const ImageFlipDemo(),
      4: () => const ImageFlipDemo01(),
      5: () => const ImageFlipDemo02(),
      6: () => const RotateAndMoveImage(),
      7: () => const RollingImageAnimation(),
      // 8: () => const MyHomePage(title: 'Hero with placeholderBuilder'),
      // 9: () => const HeroPlaceholderDemoApp(),
      // 10: () => const BasicHeroAnimation3(),
    };
    int n = 7; // Giá trị n có thể thay đổi
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
Demo các method: Transform.translate - Transform.rotate - Transform.scale - Hiệu ứng 3D (Matrix4)
 */

class TransformDemo extends StatefulWidget {
  const TransformDemo({super.key});

  @override
  _TransformDemoState createState() => _TransformDemoState();
}

class _TransformDemoState extends State<TransformDemo> {
  // Các trạng thái của phép biến đổi
  bool _isTranslated = false;
  bool _isRotated = false;
  bool _isScaled = false;
  bool _is3DTransformed = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Transform Demo')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Dịch chuyển
            Transform.translate(
              offset: _isTranslated ? const Offset(30, -50) : const Offset(0, 0),
              child: Container(
                color: Colors.blue,
                width: 100,
                height: 100,
              ),
            ),
            const SizedBox(height: 20),
            // Xoay
            Transform.rotate(
              angle: _isRotated ? 3.14 / 4 : 0, // Xoay 45 độ nếu được bật
              child: Container(
                color: Colors.green,
                width: 100,
                height: 100,
              ),
            ),
            const SizedBox(height: 20),
            // Phóng to
            Transform.scale(
              scale: _isScaled ? 1.5 : 1.0, // Phóng to 1.5 lần nếu được bật
              child: Container(
                color: Colors.red,
                width: 100,
                height: 100,
              ),
            ),
            const SizedBox(height: 20),
            // Hiệu ứng 3D
            Transform(
              transform: _is3DTransformed
                  ? (Matrix4.identity()
                    ..rotateX(0.5)
                    ..rotateY(0.5))
                  : Matrix4.identity(),
              child: Container(
                color: Colors.orange,
                width: 100,
                height: 100,
              ),
            ),
            const SizedBox(height: 40),
            // Các nút điều khiển
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _isTranslated = !_isTranslated;
                    });
                  },
                  child: const Text('Translated'),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _isRotated = !_isRotated;
                    });
                  },
                  child: const Text('Rotated'),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _isScaled = !_isScaled;
                    });
                  },
                  child: const Text('Scale'),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _is3DTransformed = !_is3DTransformed;
                    });
                  },
                  child: const Text('Matrix4'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// Transform.flip
class MyFlip01 extends StatefulWidget {
  const MyFlip01({super.key});

  @override
  State<MyFlip01> createState() => _MyFlip01State();
}

bool _flipX = false;
bool _flipY = false; // đặt ngoài method build mới lưu giá trị được với setState
bool _flipXY = false;

class _MyFlip01State extends State<MyFlip01> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flip Demo'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Transform.flip(
              flipX: _flipX,
              flipY: false,
              child: const Image(
                image: AssetImage('images/avatar3.png'),
                height: 200,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Transform.flip(
              flipX: false,
              flipY: _flipY,
              child: const Text(
                'Flipped Text',
                style: TextStyle(fontSize: 24),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Transform.flip(
              flipX: _flipXY,
              flipY: _flipXY,
              child: const Text(
                'Flipped Text',
                style: TextStyle(fontSize: 24),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _flipX = !_flipX;
                    });
                  },
                  child: const Text('Flip X'),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _flipY = !_flipY;
                    });
                  },
                  child: const Text('Flip Y'),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _flipXY = !_flipXY;
                    });
                  },
                  child: const Text('Flip X & Y'),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

// Flip bằng Matrix4 .. rotateX .. rotateY

class ImageFlipDemo extends StatefulWidget {
  const ImageFlipDemo({Key? key}) : super(key: key);

  @override
  _ImageFlipDemoState createState() => _ImageFlipDemoState();
}

class _ImageFlipDemoState extends State<ImageFlipDemo> {
  bool _isFlippedHorizontally = false;
  bool _isFlippedVertically = false;

  void _flipHorizontally() {
    setState(() {
      _isFlippedHorizontally = !_isFlippedHorizontally;
    });
  }

  void _flipVertically() {
    setState(() {
      _isFlippedVertically = !_isFlippedVertically;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Image Flip Demo')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Transform(
              alignment: Alignment.center,
              transform: Matrix4.identity()
                ..setEntry(3, 2, 0.001)
                ..rotateY(_isFlippedHorizontally ? math.pi : 0)
                ..rotateX(_isFlippedVertically ? math.pi : 0),
              child: Image.network(
                'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg',
                width: 200,
                height: 200,
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: _flipHorizontally,
                  child: const Text('Flip Horizontally'),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: _flipVertically,
                  child: const Text('Flip Vertically'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// Flip bằng Matrix4 ..scale
class ImageFlipDemo01 extends StatefulWidget {
  const ImageFlipDemo01({super.key});

  @override
  State<ImageFlipDemo01> createState() => _ImageFlipDemo01State();
}

class _ImageFlipDemo01State extends State<ImageFlipDemo01> {
  bool _isFlippedHorizontally = false;
  bool _isFlippedVertically = false;
  void _flipHorizontally() {
    setState(() {
      _isFlippedHorizontally = !_isFlippedHorizontally;
    });
  }

  void _flipVertically() {
    setState(() {
      _isFlippedVertically = !_isFlippedVertically;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flip Demo'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Lật theo trục Y (Vertical Flip)
            Transform(
              alignment: Alignment.center,
              transform: Matrix4.identity()..scale(_isFlippedHorizontally ? -1.0 : 1.0), // Lật theo trục Y
              child: const Image(
                image: AssetImage('images/avatar1.png'),
                height: 300,
              ),
            ),
            const SizedBox(height: 20),
            // Lật theo trục X (Horizontal Flip)
            Transform(
              alignment: Alignment.center,
              transform: Matrix4.identity()..scale(_isFlippedVertically ? 1.0 : -1.0, 1.0), // Lật theo trục X
              child: const Text(
                'Flipped Text',
                style: TextStyle(fontSize: 24),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: _flipHorizontally,
                  child: const Text('Flip Horizontally'),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: _flipVertically,
                  child: const Text('Flip Vertically'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// Flip bằng Transform.scale
class ImageFlipDemo02 extends StatefulWidget {
  const ImageFlipDemo02({super.key});

  @override
  State<ImageFlipDemo02> createState() => _ImageFlipDemo02State();
}

class _ImageFlipDemo02State extends State<ImageFlipDemo02> {
  bool _isFlippedHorizontally = false;
  bool _isFlippedVertically = false;
  void _flipHorizontally() {
    setState(() {
      _isFlippedHorizontally = !_isFlippedHorizontally;
    });
  }

  void _flipVertically() {
    setState(() {
      _isFlippedVertically = !_isFlippedVertically;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flip Demo'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Lật theo trục Y (Vertical Flip)
            Transform.scale(
              scaleX: _isFlippedHorizontally ? -1.0 : 1.0, // Lật theo trục X
              scaleY: 1.0, // Không thay đổi trục Y
              child: const Image(
                image: AssetImage('images/avatar2.png'),
                height: 300,
              ),
            ),
            const SizedBox(height: 20),
            // Lật theo trục X (Horizontal Flip)
            Transform.scale(
              scaleX: 1.0, // Không thay đổi trục X
              scaleY: _isFlippedVertically ? -1.0 : 1.0,

              /// Lật theo trục Y
              child: const Image(
                image: AssetImage('images/avatar1.png'),
                height: 300,
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: _flipHorizontally,
                  child: const Text('Flip Horizontally'),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: _flipVertically,
                  child: const Text('Flip Vertically'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/* 
Cách hoạt động của animation trong context của Stack widget:

Sử dụng Stack:
Stack cho phép chúng ta xếp chồng các widget lên nhau.
Trong trường hợp này, chúng ta chỉ có một child trong Stack, đó là AnimatedBuilder.

AnimatedBuilder:
AnimatedBuilder là một widget đặc biệt được rebuild mỗi khi animation thay đổi giá trị.
Nó không tạo ra nhiều instances của hình ảnh, mà chỉ cập nhật vị trí và góc xoay của một instance duy nhất.

Cập nhật liên tục:
Mỗi frame của animation, AnimatedBuilder sẽ được rebuild.
Điều này cập nhật vị trí (thông qua _animationY.value) và góc xoay (thông qua _animationRotation.value) của hình ảnh.

Hiệu suất:
Mặc dù có vẻ như chúng ta đang tạo nhiều layers trong Stack, thực tế Flutter tối ưu hóa quá trình này.
Chỉ có một hình ảnh thực sự được render, và vị trí/góc xoay của nó được cập nhật mỗi frame.

Positioned widget:
Positioned là con trực tiếp của Stack, cho phép chúng ta định vị chính xác hình ảnh trong Stack.
Nó được cập nhật mỗi frame để thay đổi vị trí theo chiều dọc của hình ảnh.

Transform widget:
Transform áp dụng phép biến đổi (trong trường hợp này là xoay) cho child của nó.
Nó cũng được cập nhật mỗi frame để thay đổi góc xoay của hình ảnh.

Tóm lại, mặc dù chúng ta đang sử dụng Stack, nhưng không phải từng frame animation được "đưa vào" Stack theo nghĩa tạo ra nhiều layers. Thay vào đó, một instance duy nhất của hình ảnh được cập nhật liên tục về vị trí và góc xoay, tạo ra hiệu ứng animation mượt mà.
Cách tiếp cận này rất hiệu quả về mặt hiệu suất vì nó không tạo ra nhiều instances của hình ảnh, mà chỉ cập nhật thuộc tính của một instance duy nhất.
 */
// Vừa xoay vừa di chuyển với Positioned - Transform

class RotateAndMoveImage extends StatefulWidget {
  const RotateAndMoveImage({super.key});

  @override
  _RotateAndMoveImageState createState() => _RotateAndMoveImageState();
}

class _RotateAndMoveImageState extends State<RotateAndMoveImage> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animationY;
  late Animation<double> _animationRotation;

  @override
  void initState() {
    super.initState();

    // Tạo AnimationController để điều khiển hiệu ứng
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2), // Thời gian hiệu ứng
    )..repeat(); // Lặp lại để nhìn giống như liên tục di chuyển

    // Animation cho vị trí Y (di chuyển từ dưới lên trên)
    _animationY = Tween<double>(begin: 500, end: 100).animate(_controller);

    // Animation cho rotation (xoay trục X)
    _animationRotation = Tween<double>(begin: 0, end: 2 * pi).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return Positioned(
                top: _animationY.value,
                left: MediaQuery.of(context).size.width / 2 - 100, // Adjusted for image width
                child: Transform(
                  transform: Matrix4.rotationX(_animationRotation.value),
                  alignment: Alignment.center,
                  child: Image.asset(
                    'images/avatar3.png',
                    width: 200,
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

// Vừa xoay vừa di chuyển với Positioned - Transform

class RollingImageAnimation extends StatefulWidget {
  const RollingImageAnimation({Key? key}) : super(key: key);

  @override
  _RollingImageAnimationState createState() => _RollingImageAnimationState();
}

class _RollingImageAnimationState extends State<RollingImageAnimation> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animationY;
  late Animation<double> _animationRotation;
  // _isAtInitialPosition để theo dõi vị trí hiện tại của hình ảnh.
  bool _isAtInitialPosition = true;

// để xác định vị trí bắt đầu và kết thúc.
  final double _initialY = 500.0;
  final double _finalY = 200.0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _setupAnimations();

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed || status == AnimationStatus.dismissed) {
        setState(() {
          _isAtInitialPosition = !_isAtInitialPosition;
        });
      }
    });
  }

  void _setupAnimations() {
    _animationY = Tween<double>(begin: _initialY, end: _finalY).animate(_controller);
    _animationRotation = Tween<double>(begin: 0, end: 2 * pi).animate(_controller);
  }
  /* 
  _controller.isAnimating là một thuộc tính boolean của AnimationController. Nó trả về true nếu animation đang chạy và false nếu animation đã dừng.
Câu lệnh if kiểm tra xem animation có đang chạy hay không.
Nếu animation đang chạy, hàm sẽ kết thúc ngay lập tức (do lệnh return).
Mục đích:
Ngăn chặn việc bắt đầu một animation mới khi animation hiện tại đang chạy.
Tránh xung đột hoặc hành vi không mong muốn khi người dùng nhấn liên tục vào hình ảnh.
   */

  void _toggleAnimation() {
    setState(() {
      if (_controller.isAnimating) return;

      if (_isAtInitialPosition) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return Positioned(
                top: _animationY.value,
                // left: MediaQuery.of(context).size.width / 2,
                left: 0, right: 0,
                child: Center(
                  child: Transform(
                    transform: Matrix4.rotationX(_animationRotation.value),
                    alignment: Alignment.center,
                    child: GestureDetector(
                      onTap: _toggleAnimation,
                      child: Image.asset(
                        'images/wheel.png',
                        // width: 100,
                        height: 200,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
