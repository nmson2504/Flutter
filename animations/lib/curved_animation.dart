import 'package:flutter/material.dart';

// Example 1 - có & ko CurvedAnimation
//
class CurvedAnimation1 extends StatefulWidget {
  const CurvedAnimation1({super.key});

  @override
  State<CurvedAnimation1> createState() => _CurvedAnimation1State();
}

// TickerProviderStateMixin cung cấp TickerProvider - Ticker cho AnimationController để điều khiển thời gian của animation.
class _CurvedAnimation1State extends State<CurvedAnimation1> with TickerProviderStateMixin {
  late AnimationController _controller1;
  late AnimationController _controller2;
  late Animation<Offset> _animation1;
  late Animation<Offset> _animation2;

  @override
  void initState() {
    super.initState();

    _controller1 = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _controller2 = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _animation1 = Tween<Offset>(begin: const Offset(-1.0, 0.0), end: const Offset(0.0, 0.0)).animate(_controller1)
      ..addListener(() {
        setState(() {});
      });

    _animation2 = Tween<Offset>(
      begin: const Offset(-1.0, 0.0),
      end: const Offset(0.0, 0.0),
    ).animate(CurvedAnimation(
      parent: _controller2,
      curve: Curves.easeIn,
    ));

    _controller1.repeat(reverse: true);
    _controller2.repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller1.dispose();
    _controller2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Có & ko CurvedAnimation multi AnimationController Demo'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SlideTransition(
              position: _animation1,
              child: Container(
                width: 200,
                height: 200,
                color: Colors.blue,
                child: const Center(
                  child: Text(
                    'Slide Transition with CurvedAnimation',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
              ),
            ),
            SlideTransition(
              position: _animation2,
              child: Container(
                width: 200,
                height: 200,
                color: Colors.blue,
                child: const Center(
                  child: Text(
                    'Slide Transition',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Example 2 - định nghĩa CurvedAnimation bên ngoài
// scale size min - max with ScaleTransition
class CurvedAnimation2 extends StatefulWidget {
  const CurvedAnimation2({super.key});

  @override
  State<CurvedAnimation2> createState() => _CurvedAnimation2State();
}

class _CurvedAnimation2State extends State<CurvedAnimation2> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late CurvedAnimation _curvedAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);

    _curvedAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.fastOutSlowIn,
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
      appBar: AppBar(
        title: const Text('Curved Animation 2 Example'),
      ),
      body: Center(
        child: ScaleTransition(
          scale: _curvedAnimation,
          child: const Padding(
            padding: EdgeInsets.all(8.0),
            child: FlutterLogo(size: 300.0),
          ),
        ),
      ),
    );
  }
}

// Example 3 - định nghĩa CurvedAnimation bên ngoài với kiểu CurvedAnimation
// scale size min - max with GestureDetector - ScaleTransition
class CurvedAnimation3 extends StatefulWidget {
  const CurvedAnimation3({Key? key}) : super(key: key); // Chú ý phần khai báo key ở đây

  @override
  State<CurvedAnimation3> createState() => _CurvedAnimation3State();
}

class _CurvedAnimation3State extends State<CurvedAnimation3> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late CurvedAnimation _curvedAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _curvedAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.fastOutSlowIn,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _startAnimation() {
    if (_controller.isAnimating) {
      _controller.stop();
    } else {
      _controller.forward(from: 0.0).then((_) {
        if (_controller.status == AnimationStatus.completed) {
          _controller.reverse();
        }
      });
    }
    debugPrint('aaaaaa');
  }

/* click on screen để kích hoạt animation */
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Curved Animation 3 Example'),
      ),
      /* 
      Mặc định, GestureDetector chỉ nắm bắt các sự kiện cử chỉ trên các phần tử con của nó mà không có nội dung hoặc màu sắc (ví dụ: phần tử con có nội dung hoặc màu sắc nền trong suốt sẽ không được nắm bắt).
      Nếu bạn không đặt behavior: HitTestBehavior.translucent, GestureDetector chỉ nhận các sự kiện cử chỉ khi chúng xảy ra trên phần không có nội dung hoặc màu sắc, điều này có thể dẫn đến không kích hoạt animation khi bạn chạm vào FlutterLogo, vì nó có màu nền trong suốt.
       */
      body: Column(
        children: [
          const Text('Click on yellow area to run animation'),
          Center(
            child: Container(
              color: Colors.amber,
              child: GestureDetector(
                behavior: HitTestBehavior.translucent, // phải có tham số này
                onTap: _startAnimation,
                child: ScaleTransition(
                  scale: _curvedAnimation,
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: FlutterLogo(size: 200.0), // Change size for better visibility
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Example 4 - định nghĩa CurvedAnimation bên ngoài với kiểu <double>
class CurvedAnimation5 extends StatefulWidget {
  const CurvedAnimation5({super.key});

  @override
  State<CurvedAnimation5> createState() => _CurvedAnimation5State();
}

class _CurvedAnimation5State extends State<CurvedAnimation5> with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> curve;
  late Animation<int> alpha;

  @override
  void initState() {
    super.initState();

    // Khởi tạo AnimationController
    controller = AnimationController(
      duration: const Duration(milliseconds: 3000),
      vsync: this,
    );

    // Khởi tạo CurvedAnimation
    curve = CurvedAnimation(parent: controller, curve: Curves.easeOut);

    // Khởi tạo Animation<int>
    alpha = IntTween(begin: 0, end: 255).animate(curve);
  }

  @override
  void dispose() {
    // Giải phóng AnimationController khi widget bị dispose
    controller.dispose();
    super.dispose();
  }

  // Phương thức để bắt đầu animation khi GestureDetector được nhấn
  void _startAnimation() {
    controller.forward(); // Bắt đầu animation
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Animation Demo'),
      ),
      body: Center(
        child: GestureDetector(
          onTap: _startAnimation,
          child: AnimatedBuilder(
            animation: alpha,
            builder: (context, child) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Click on square area to run animation'),
                  Container(
                    width: 200.0,
                    height: 200.0,
                    decoration: BoxDecoration(
                      color: Colors.blue.withAlpha(alpha.value),
                      border: Border.all(
                        // Tạo viền
                        color: Colors.black, // Màu sắc của viền
                        width: 2.0, // Độ dày của viền
                      ),
                    ),
                    child: const Center(
                      child: Text(
                        'Tap to Animate',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
