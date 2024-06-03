import 'package:flutter/material.dart';

// Bổ sung thêm cách gán animation & Định nghĩa controller

// gán animation
// Tạo animation AlwaysStoppedAnimation - chưa hiểu mục đích
class ExplicitOA extends StatefulWidget {
  const ExplicitOA({super.key});

  @override
  State<ExplicitOA> createState() => _ExplicitOAState();
}

// SingleTickerProviderStateMixin cung cấp TickerProvider - Ticker cho AnimationController để điều khiển thời gian của animation.
class _ExplicitOAState extends State<ExplicitOA> with TickerProviderStateMixin {
  late Animation<double> _animation;
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    // Tạo animation với giá trị cố định
    _animation = const AlwaysStoppedAnimation<double>(0.5);

    // Bắt đầu animation
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Transform.scale(
          scale: _animation.value,
          child: Container(
            width: 100,
            height: 100,
            color: Colors.blue,
            child: const Center(
              child: Text(
                'Hello',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        );
      },
    );
  }
}

// Tạo animation dùng chu controller
class ExplicitOB extends StatefulWidget {
  const ExplicitOB({super.key});

  @override
  State<ExplicitOB> createState() => _ExplicitOBState();
}

// SingleTickerProviderStateMixin cung cấp TickerProvider - Ticker cho AnimationController để điều khiển thời gian của animation.
class _ExplicitOBState extends State<ExplicitOB> with TickerProviderStateMixin {
  late AnimationController _controller1;
  late AnimationController _controller2;
  late Animation<double> _animation1;
  late Animation<double> _animation2;
  late Animation<double> _animation3;

  @override
  void initState() {
    super.initState();

    _controller1 = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    _controller2 = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    );
    // Dùng chung coltroller nhưng gán Tween khác
    _animation1 = Tween<double>(begin: 0, end: 100).animate(_controller1);
    _animation2 = Tween<double>(begin: 0, end: 100).animate(_controller2);
    _animation3 = Tween<double>(begin: 100, end: 200).animate(_controller1);
    // Bắt đầu animation1
    // _controller1.forward();

    // _animation1 = Tween<double>(begin: 0, end: 100)
    //     .animate(_controller2 = AnimationController(
    //   vsync: this,
    //   duration: const Duration(seconds: 1),
    // ));

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
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AnimatedBuilder(
          animation: _animation1,
          builder: (context, child) {
            return Container(
              width: _animation1.value,
              height: 50,
              color: Colors.blue,
              margin: const EdgeInsets.symmetric(vertical: 10),
            );
          },
        ),
        AnimatedBuilder(
          animation: _animation2,
          builder: (context, child) {
            return Container(
              width: _animation2.value,
              height: 50,
              color: Colors.red,
              margin: const EdgeInsets.symmetric(vertical: 10),
            );
          },
        ),
        AnimatedBuilder(
          animation: _animation3,
          builder: (context, child) {
            return Container(
              width: _animation3.value,
              height: 50,
              color: Colors.black,
              margin: const EdgeInsets.symmetric(vertical: 10),
            );
          },
        ),
      ],
    );
  }
}

// Định nghĩa controller với lowerBound, upperBound
class ExplicitOC extends StatefulWidget {
  const ExplicitOC({super.key});

  @override
  State<ExplicitOC> createState() => _ExplicitOCState();
}

// SingleTickerProviderStateMixin cung cấp TickerProvider - Ticker cho AnimationController để điều khiển thời gian của animation.
class _ExplicitOCState extends State<ExplicitOC>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
      lowerBound: 0.0, // % value end của Tween<double>
      upperBound: 2.0, // % value end của Tween<double>
    );

    _animation = Tween<double>(
      begin: 0,
      end: 200,
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
        title: const Text('Bound Animation Controller Demo'),
      ),
      body: Center(
        child: AnimatedBuilder(
          animation: _animation,
          builder: (context, child) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: _animation.value,
                  height: 50,
                  color: Colors.black,
                  margin: const EdgeInsets.symmetric(vertical: 10),
                ),
                Container(
                  width: 200,
                  height: 50,
                  color: Colors.red,
                  margin: const EdgeInsets.symmetric(vertical: 10),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

// Định nghĩa controller với value - giá trị khởi đầu của animation, override Tween<double>(begin:
class ExplicitOD extends StatefulWidget {
  const ExplicitOD({super.key});

  @override
  State<ExplicitOD> createState() => _ExplicitODState();
}

// SingleTickerProviderStateMixin cung cấp TickerProvider - Ticker cho AnimationController để điều khiển thời gian của animation.
class _ExplicitODState extends State<ExplicitOD>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
      value:
          0.2, // giá trị khởi đầu của animation, override Tween<double>(begin:
    );

    _animation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(_controller);

    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Initial Value Animation Controller Demo'),
      ),
      body: Center(
        child: AnimatedBuilder(
          animation: _animation,
          builder: (context, child) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Opacity(
                  opacity: 1.0,
                  child: Container(
                    margin: const EdgeInsetsDirectional.all(10),
                    width: 200,
                    height: 200,
                    color: Colors.blue,
                  ),
                ),
                Opacity(
                  opacity: _animation.value,
                  child: Container(
                    width: 200,
                    height: 200,
                    color: Colors.blue,
                  ),
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
    _controller.dispose();
    super.dispose();
  }
}

// Một số cách gán controller cho animation khác
class ExplicitOE extends StatefulWidget {
  const ExplicitOE({super.key});

  @override
  State<ExplicitOE> createState() => _ExplicitOEState();
}

// SingleTickerProviderStateMixin cung cấp TickerProvider - Ticker cho AnimationController để điều khiển thời gian của animation.
class _ExplicitOEState extends State<ExplicitOE> with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  late AnimationController _controller1;
  late Animation<double> _animation1;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
      lowerBound: 0.0, // % value end của Tween<double>
      upperBound: 2.0, // % value end của Tween<double>
    );
    _controller1 = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
      lowerBound: 0.0, // % value end của Tween<double>
      upperBound: 3.0, // % value end của Tween<double>
    );
// animation - gán qua hàm tự định nghĩa, rườm rà ko cần thiết
    Animation<double> createAnimation(AnimationController controller) {
      return Tween<double>(
        begin: 0,
        end: 100,
      ).animate(controller);
    }

    _animation = createAnimation(_controller);
    _controller.forward();

    // _animation1
    // Gán controller cho animation sau khi tạo animation qua .addStatusListener
    _animation1 = Tween<double>(
      begin: 0,
      end: 100,
    ).animate(_controller1);
    _animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _controller1.reverse();
      } else if (status == AnimationStatus.dismissed) {
        _controller1.forward();
      }
    });

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
        title: const Text('Gán Controller cho Animation Demo'),
      ),
      body: Center(
        child: AnimatedBuilder(
          animation: _animation,
          builder: (context, child) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: _animation.value,
                  height: 50,
                  color: Colors.black,
                  margin: const EdgeInsets.symmetric(vertical: 10),
                ),
                Container(
                  width: _animation1.value,
                  height: 50,
                  color: Colors.red,
                  margin: const EdgeInsets.symmetric(vertical: 10),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
