import 'package:flutter/material.dart';

// Demo Tween

// Hai cách định nghĩa Tween
class DemoTween1 extends StatefulWidget {
  const DemoTween1({super.key});

  @override
  State<DemoTween1> createState() => _DemoTween1State();
}

// TickerProviderStateMixin cung cấp TickerProvider - Ticker cho AnimationController để điều khiển thời gian của animation.
class _DemoTween1State extends State<DemoTween1> with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _animation1;
  late Animation<Offset> _animation2;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
// C1 - _animation1 = _controller.drive(Tween<Offset>(
    _animation1 = _controller.drive(
      Tween<Offset>(
        begin: const Offset(0.0, 0.0),
        end: const Offset(300.0, 200.0),
      ),
    );
//  C2 - _animation2 = Tween<Offset>(
    _animation2 = Tween<Offset>(
      begin: const Offset(0.0, 0.0),
      end: const Offset(100.0, 200.0),
    ).animate(_controller);

    _controller.forward();
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
        title: const Text('Tween with AnimatedWidget Example'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            PositionTransitionWidget(animation: _animation1),
            PositionTransitionWidget(animation: _animation2),
          ],
        ),
      ),
    );
  }
}

class PositionTransitionWidget extends AnimatedWidget {
  const PositionTransitionWidget(
      {Key? key, required Animation<Offset> animation})
      : super(key: key, listenable: animation);

  @override
  Widget build(BuildContext context) {
    final Animation<Offset> animation = listenable as Animation<Offset>;
    return Transform.translate(
      offset: animation.value,
      child: Container(
        width: 50,
        height: 50,
        color: Colors.blue,
      ),
    );
  }
}

// Định nghĩa _animation = ColorTween(
// chuyển đổi qua lại giữa 2 màu
class DemoTween2 extends StatefulWidget {
  const DemoTween2({super.key});

  @override
  State<DemoTween2> createState() => _DemoTween2State();
}

// TickerProviderStateMixin cung cấp TickerProvider - Ticker cho AnimationController để điều khiển thời gian của animation.
class _DemoTween2State extends State<DemoTween2>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Color?> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    _animation =
        ColorTween(begin: Colors.black, end: Colors.red).animate(_controller)
          ..addListener(() {
            setState(() {});
          });
    _controller.repeat(reverse: true);
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
        title: const Text('ColorTween Demo'),
      ),
      body: Center(
        child: Container(
          width: 200,
          height: 200,
          color: _animation.value,
          child: const Center(
            child: Text(
              'ColorTween',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// Một Tween dùnG cho 2 Animation
class DemoTween3 extends StatefulWidget {
  const DemoTween3({super.key});

  @override
  State<DemoTween3> createState() => _DemoTween3State();
}

class _DemoTween3State extends State<DemoTween3> with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _animation1;
  late Animation<Offset> _animation2;
  late Tween<Offset> _tween;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    _tween = Tween<Offset>(
      begin: const Offset(0.0, 0.0),
      end: const Offset(300.0, 200.0),
    );
// C1 - _animation1 = _controller.drive(Tween<Offset>(
    _animation1 = _controller.drive(_tween);
//  C2 - _animation2 = Tween<Offset>(
    _animation2 = _tween.animate(_controller);

    _controller.forward();
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
        title: const Text('Một Tween dùng cho 2 Animation'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            PositionTransitionWidget3(animation: _animation1),
            PositionTransitionWidget3(animation: _animation2),
          ],
        ),
      ),
    );
  }
}

class PositionTransitionWidget3 extends AnimatedWidget {
  const PositionTransitionWidget3(
      {Key? key, required Animation<Offset> animation})
      : super(key: key, listenable: animation);

  @override
  Widget build(BuildContext context) {
    final Animation<Offset> animation = listenable as Animation<Offset>;
    return Transform.translate(
      offset: animation.value,
      child: Container(
        width: 50,
        height: 50,
        color: Colors.blue,
      ),
    );
  }
}

// Truyền hai animation vào một AnimatedBuilder
class DemoTween3A extends StatefulWidget {
  const DemoTween3A({super.key});

  @override
  State<DemoTween3A> createState() => _DemoTween3AState();
}

class _DemoTween3AState extends State<DemoTween3A>
    with TickerProviderStateMixin {
  late AnimationController _controller1;
  late AnimationController _controller2;
  late Animation<double> _animation1;
  late Animation<double> _animation2;

  @override
  void initState() {
    super.initState();

    _controller1 = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );
    _controller2 = AnimationController(
      duration: const Duration(seconds: 4),
      vsync: this,
    );

    _animation1 = Tween<double>(
      begin: 0,
      end: 200,
    ).animate(_controller1);

    _animation2 = Tween<double>(
      begin: 0,
      end: 100,
    ).animate(_controller2);

    _controller1.forward();
    _controller2.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Truyền hai animation vào một AnimatedBuilder'),
      ),
      body: Center(
        child: AnimatedBuilder(
          // truyền controller nào thì animation sẽ run theo duration của controller đó
          animation: _controller2,
          builder: (context, child) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  height: _animation1.value,
                  width: _animation1.value,
                  color: Colors.blue,
                ),
                const SizedBox(height: 20),
                Container(
                  height: _animation2.value,
                  width: _animation2.value,
                  color: Colors.red,
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller1.dispose();
    _controller2.dispose();
    super.dispose();
  }
}

// Liên kết các Tween lại với nhau bằng phương thức chain để một Animation run nhiều Tween.
// 2 animation run đồng thời - chưa xly cho 1 run tuần tự 1 run đồng thời được???
// TweenSequence hai Tween run 2 Animation đồng thời
class DemoTween4 extends StatefulWidget {
  const DemoTween4({super.key});

  @override
  State<DemoTween4> createState() => _DemoTween4State();
}

class _DemoTween4State extends State<DemoTween4> with TickerProviderStateMixin {
  late AnimationController _controller;
  late AnimationController _controller1;
  late Animation<double> _sizeAnimation;
  late Animation<Color?> _colorAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 4),
      vsync: this,
    );
    _controller1 = AnimationController(
      duration: const Duration(seconds: 4),
      vsync: this,
    );

    // Tạo các Tween và liên kết chúng với nhau
    _sizeAnimation = TweenSequence([
      TweenSequenceItem(
          tween: Tween(begin: 50.0, end: 200.0),
          weight: 0.2), // Tăng kích thước
      TweenSequenceItem(
          tween: Tween(begin: 200.0, end: 50.0),
          weight: 0.2), // Giảm kích thước
    ]).animate(_controller);

    _colorAnimation = TweenSequence([
      TweenSequenceItem(
          tween: ColorTween(begin: Colors.red, end: Colors.blue),
          weight: 50), // Đổi màu từ đỏ sang xanh
      TweenSequenceItem(
          tween: ColorTween(begin: Colors.blue, end: Colors.green),
          weight: 50), // Đổi màu từ xanh sang xanh lá
    ]).animate(_controller);

    _controller.forward();
    _controller1.forward();
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
        title: const Text('TweenSequence hai Tween run 2 Animation đồng thời'),
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return Transform.scale(
                scale: _sizeAnimation.value / 200.0,
                child: Container(
                  width: 200.0,
                  height: 200.0,
                  color: _colorAnimation.value,
                ),
              );
            },
          ),
          AnimatedBuilder(
            animation: _controller1,
            builder: (context, child) {
              return Transform.scale(
                scale: _sizeAnimation.value / 200.0,
                child: Container(
                  width: 200.0,
                  height: 200.0,
                  color: _colorAnimation.value,
                ),
              );
            },
          ),
        ],
      )),
    );
  }
}

// Liên kết các Tween lại với nhau bằng phương thức chain để một Animation run nhiều Tween.
// 2 animation run tuần tự bằng cách truyền animation sau
// animation: Listenable.merge([_sizeAnimation, _colorAnimation]),
// TweenSequence hai Tween run 2 Animation tuần tự
class DemoTween5 extends StatefulWidget {
  const DemoTween5({super.key});

  @override
  State<DemoTween5> createState() => _DemoTween5State();
}

class _DemoTween5State extends State<DemoTween5> with TickerProviderStateMixin {
  late AnimationController _sizeController;
  late AnimationController _colorController;
  late Animation<double> _sizeAnimation;
  late Animation<Color?> _colorAnimation;

  @override
  void initState() {
    super.initState();

    _sizeController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );
    _colorController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );

    _sizeAnimation = TweenSequence(
      [
        TweenSequenceItem(tween: Tween(begin: 50.0, end: 200.0), weight: 50),
        TweenSequenceItem(tween: Tween(begin: 200.0, end: 50.0), weight: 50),
      ],
    ).animate(_sizeController);

    _colorAnimation = TweenSequence(
      [
        TweenSequenceItem(
            tween: ColorTween(begin: Colors.red, end: Colors.blue), weight: 50),
        TweenSequenceItem(
            tween: ColorTween(begin: Colors.blue, end: Colors.green),
            weight: 50),
      ],
    ).animate(_colorController);

    _colorController.forward();
    _colorController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _sizeController.forward();
      }
    });
  }

  @override
  void dispose() {
    _sizeController.dispose();
    _colorController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('TweenSequence hai Tween run 2 Animation tuần tự'),
        ),
        body: Center(
          child: AnimatedBuilder(
            animation: Listenable.merge([_sizeAnimation, _colorAnimation]),
            builder: (context, child) {
              return Transform.scale(
                scale: _sizeAnimation.value / 200.0,
                child: Container(
                  width: 200.0,
                  height: 200.0,
                  color: _colorAnimation.value,
                ),
              );
            },
          ),
        ));
  }
}

// Liên kết các Tween ko dùng chain và TweenSequence.
class DemoTween6 extends StatefulWidget {
  const DemoTween6({super.key});

  @override
  State<DemoTween6> createState() => _DemoTween6State();
}

class _DemoTween6State extends State<DemoTween6> with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Color?> _colorAnimation1;
  late Animation<Color?> _colorAnimation2;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 6),
      vsync: this,
    );

    // Define the first part of the animation
    _colorAnimation1 = ColorTween(begin: Colors.red, end: Colors.blue).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.5, curve: Curves.linear),
      ),
    );

    // Define the second part of the animation
    _colorAnimation2 =
        ColorTween(begin: Colors.blue, end: Colors.yellow).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.5, 1.0, curve: Curves.linear),
      ),
    );

    _controller.repeat();
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
          title: const Text(
              'Hai Tween run 2 Animation tuần tự(ko dùng TweenSequence)'),
        ),
        body: Center(
          child: AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              Color? color;
              if (_controller.value <= 0.5) {
                color = _colorAnimation1.value;
              } else {
                color = _colorAnimation2.value;
              }
              return Container(
                width: 200,
                height: 200,
                color: color,
              );
            },
          ),
        ));
  }
}

// Liên kết các Tween lại với nhau bằng phương thức chain để một Animation run nhiều Tween.
/* 
 Lưu ý rằng chain chỉ hoạt động với các Tween có cùng kiểu dữ liệu là double. ColorTween và CurveTween không thể kết hợp trực tiếp với nhau vì ColorTween trả về giá trị Color trong khi CurveTween hoạt động trên giá trị double.
 */
// chua hieu quy luat chain
class DemoTween7 extends StatefulWidget {
  const DemoTween7({super.key});

  @override
  State<DemoTween7> createState() => _DemoTween7State();
}

class _DemoTween7State extends State<DemoTween7> with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 8),
      vsync: this,
    );

    final tween1 = Tween<double>(begin: 0.0, end: 1.0);
    final tween2 = Tween<double>(begin: 2.0, end: 0.0);
   

    _animation = _controller.drive(
      tween1.chain(tween2));
  // final tween1 = Tween<double>(begin: 0.0, end: 1.0);
    // final tween2 = Tween<double>(begin: 1.0, end: 2.0);
      // tween2.chain(tween1)); - 100 to 200
      // tween1.chain(tween2)); - 100 to 200

    

    _controller.forward();
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
          title: const Text(
              'Hai Tween run 2 Animation tuần tự dùng chain method(ko dùng TweenSequence)'),
        ),
        body: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedBuilder(
                animation: _animation,
                builder: (context, child) {
                  return Container(
                    width: 10 ,
                    height: 100 * _animation.value,
                    color: Colors.blue,
                  );
                },
              ),
              AnimatedBuilder(
                animation: _animation,
                builder: (context, child) {
                  return Container(
                    width: 10,
                    height: 100,
                    color: Colors.blue,
                  );
                },
              ),
              AnimatedBuilder(
                animation: _animation,
                builder: (context, child) {
                  return Container(
                   width: 10,
                    height: 200,
                    color: Colors.blue,
                  );
                },
              ),
              AnimatedBuilder(
                animation: _animation,
                builder: (context, child) {
                  return Container(
                   width: 10,
                    height: 400,
                    color: Colors.blue,
                  );
                },
              ),
              AnimatedBuilder(
                animation: _animation,
                builder: (context, child) {
                  return Container(
                   width: 10,
                    height: 600,
                    color: Colors.blue,
                  );
                },
              ),
            ],
          ),
        ));
  }
}
