import 'package:flutter/material.dart';

class AnimatedBuilder01 extends StatefulWidget {
  const AnimatedBuilder01({super.key});

  @override
  _AnimatedBuilder01State createState() => _AnimatedBuilder01State();
}

class _AnimatedBuilder01State extends State<AnimatedBuilder01>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0, end: 200).animate(_controller);
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
      appBar: AppBar(title: const Text('Size Animation Example')),
      body: Center(
        child: AnimatedBuilder(
          animation: _animation,
          builder: (context, child) {
            return Container(
              width: _animation.value,
              height: _animation.value,
              color: Colors.blue,
            );
          },
        ),
      ),
    );
  }
}

// Example 2
class AnimatedBuilder02 extends StatefulWidget {
  const AnimatedBuilder02({super.key});

  @override
  _AnimatedBuilder02State createState() => _AnimatedBuilder02State();
}

class _AnimatedBuilder02State extends State<AnimatedBuilder02>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0, end: 2 * 3.14159).animate(_controller);
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
      appBar: AppBar(title: const Text('Rotation Animation Example')),
      body: Center(
        child: AnimatedBuilder(
          animation: _animation,
          builder: (context, child) {
            return Transform.rotate(
              angle: _animation.value,
              child: Container(
                width: 100,
                height: 100,
                color: Colors.red,
              ),
            );
          },
        ),
      ),
    );
  }
}

// Example 3

class AnimatedBuilder03 extends StatefulWidget {
  const AnimatedBuilder03({super.key});

  @override
  _AnimatedBuilder03State createState() => _AnimatedBuilder03State();
}

class _AnimatedBuilder03State extends State<AnimatedBuilder03>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0, end: 200).animate(_controller);
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
      appBar: AppBar(title: const Text('Translation Animation Example')),
      body: Center(
        child: AnimatedBuilder(
          animation: _animation,
          builder: (context, child) {
            return Transform.translate(
              offset: Offset(_animation.value, 0),
              child: Container(
                width: 100,
                height: 100,
                color: Colors.green,
              ),
            );
          },
        ),
      ),
    );
  }
}

// Example 4
// LogoApp2 -> GrowTransition -> LogoWidget
// #docregion LogoWidget
class LogoWidget extends StatelessWidget {
  const LogoWidget({Key? key}) : super(key: key);

// Leave out the height and width so it fills the animating parent
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: const FlutterLogo(),
    );
  }
}
// #enddocregion LogoWidget

// #docregion GrowTransition
class GrowTransition extends StatelessWidget {
  const GrowTransition({required this.child, required this.animation, Key? key})
      : super(key: key);

  final Widget child;
  final Animation<double> animation;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedBuilder(
        animation: animation,
        builder: (context, child) {
          return SizedBox(
            height: animation.value,
            width: animation.value,
            child: child,
          );
        },
        child: child,
      ),
    );
  }
}
// #enddocregion GrowTransition

class LogoApp2 extends StatefulWidget {
  const LogoApp2({Key? key}) : super(key: key);

  @override
  _LogoApp2State createState() => _LogoApp2State();
}

// #docregion print-state
class _LogoApp2State extends State<LogoApp2>
    with SingleTickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(duration: const Duration(seconds: 2), vsync: this);
    animation = Tween<double>(begin: 0, end: 300).animate(controller);
    controller.forward();
  }
// #enddocregion print-state

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('GrowTransition Example')),
      body: GrowTransition(
        animation: animation,
        child: const LogoWidget(),
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
// #docregion print-state
}
