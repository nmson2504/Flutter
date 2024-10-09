import 'package:flutter/material.dart';
import 'package:device_preview/device_preview.dart';

class MyDemoTranslate extends StatelessWidget {
  const MyDemoTranslate({super.key});

  @override
  Widget build(BuildContext context) {
    var mapC = {
      1: () => const AnimatedImagePosition(),
      2: () => const AnimatedAlignImage(),
      3: () => const AnimatedContainerImage(),
      4: () => const TransformImageAnimation(),
      5: () => const AnimatedCrossFade01(),
      // 6: () => const BasicHeroAnimation5(),
      // 7: () => const BasicHeroAnimation6(),
      // 8: () => const MyHomePage(title: 'Hero with placeholderBuilder'),
      // 9: () => const HeroPlaceholderDemoApp(),
      // 10: () => const BasicHeroAnimation3(),
    };
    int n = 5; // Giá trị n có thể thay đổi
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
AnimatedPositioned:
AnimatedPositioned giúp bạn di chuyển một widget (ví dụ như Image) trong một Stack với hiệu ứng mượt mà.
 */

class AnimatedImagePosition extends StatefulWidget {
  const AnimatedImagePosition({super.key});

  @override
  _AnimatedImagePositionState createState() => _AnimatedImagePositionState();
}

class _AnimatedImagePositionState extends State<AnimatedImagePosition> {
  bool _isMoved = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          AnimatedPositioned(
              top: _isMoved ? 300 : 100,
              left: _isMoved ? 200 : 50,
              duration: const Duration(seconds: 1),
              child: Image.asset(
                'images/avatar1.png',
                height: 100,
              )),
          AnimatedPositioned(
            top: _isMoved ? 400 : 600,
            left: _isMoved ? 50 : 200,
            duration: const Duration(seconds: 1),
            child: Image.network(
              'https://w7.pngwing.com/pngs/740/46/png-transparent-digital-library-community-glass-rectangle-bookcase-thumbnail.png',
              width: 50.0,
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _isMoved = !_isMoved;
          });
        },
        child: const Icon(Icons.play_arrow),
      ),
    );
  }
}

//
/* 
AnimatedAlign giúp di chuyển một widget trong một container theo vị trí căn chỉnh (alignment).
 */

class AnimatedAlignImage extends StatefulWidget {
  const AnimatedAlignImage({super.key});

  @override
  _AnimatedAlignImageState createState() => _AnimatedAlignImageState();
}

class _AnimatedAlignImageState extends State<AnimatedAlignImage> {
  bool _isAligned = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AnimatedAlign(
          alignment: _isAligned ? Alignment.topRight : Alignment.bottomLeft,
          duration: const Duration(seconds: 2),
          child: Image.network(
            'https://w7.pngwing.com/pngs/740/46/png-transparent-digital-library-community-glass-rectangle-bookcase-thumbnail.png',
            width: 100,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _isAligned = !_isAligned;
          });
        },
        child: const Icon(Icons.play_arrow),
      ),
    );
  }
}

// AnimatedContainer có thể thay đổi nhiều thuộc tính của container bao gồm cả vị trí (kết hợp với Alignment hoặc Padding).

class AnimatedContainerImage extends StatefulWidget {
  const AnimatedContainerImage({super.key});

  @override
  _AnimatedContainerImageState createState() => _AnimatedContainerImageState();
}

class _AnimatedContainerImageState extends State<AnimatedContainerImage> {
  bool _isMoved = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AnimatedContainer(
          duration: const Duration(seconds: 1),
          padding: EdgeInsets.only(
            top: _isMoved ? 0 : 400,
            left: _isMoved ? 100 : 100,
          ),
          child: Image.network(
            'https://w7.pngwing.com/pngs/740/46/png-transparent-digital-library-community-glass-rectangle-bookcase-thumbnail.png',
            width: 100,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _isMoved = !_isMoved;
          });
        },
        child: const Icon(Icons.play_arrow),
      ),
    );
  }
}

// sử dụng SlideTransition để thay đổi vị trí của image.

class TransformImageAnimation extends StatefulWidget {
  const TransformImageAnimation({super.key});

  @override
  _TransformImageAnimationState createState() => _TransformImageAnimationState();
}

class _TransformImageAnimationState extends State<TransformImageAnimation> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    _animation = Tween<Offset>(begin: const Offset(0, 0), end: const Offset(1, 0)).animate(_controller);
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
        child: SlideTransition(
          position: _animation,
          child: Image.network(
            'https://w7.pngwing.com/pngs/740/46/png-transparent-digital-library-community-glass-rectangle-bookcase-thumbnail.png',
            width: 100,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _controller.forward();
        },
        child: const Icon(Icons.play_arrow),
      ),
    );
  }
}

// AnimatedCrossFade - A widget that cross-fades between two given children and animates itself between their sizes.

class AnimatedCrossFade01 extends StatefulWidget {
  const AnimatedCrossFade01({super.key});

  @override
  _AnimatedCrossFade01State createState() => _AnimatedCrossFade01State();
}

class _AnimatedCrossFade01State extends State<AnimatedCrossFade01> {
  bool _isFirst = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AnimatedCrossFade Example'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedCrossFade(
              duration: const Duration(seconds: 1),
              firstChild: Container(
                width: 100,
                height: 100,
                color: Colors.blue,
              ),
              secondChild: Container(
                width: 200,
                height: 200,
                color: Colors.red,
              ),
              crossFadeState: _isFirst ? CrossFadeState.showFirst : CrossFadeState.showSecond,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _isFirst = !_isFirst;
                });
              },
              child: const Text('Toggle'),
            ),
          ],
        ),
      ),
    );
  }
}
