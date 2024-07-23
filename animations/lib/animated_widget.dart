import 'package:flutter/material.dart';

// AnimatedWidget01: A stateful widget that manages the animation controller and animation.
class AnimatedWidget01 extends StatefulWidget {
  const AnimatedWidget01({super.key});

  @override
  _AnimatedWidget01State createState() => _AnimatedWidget01State();
}

class _AnimatedWidget01State extends State<AnimatedWidget01>
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
    _animation = Tween<double>(begin: 0, end: 300).animate(_controller);
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
      appBar: AppBar(title: const Text('AnimatedWidget Example 01')),
      body: Center(child: MyAnimatedWidget(animation: _animation)),
    );
  }
}
// MyAnimatedWidget: An animated widget that resizes based on the animation value.
/* Lớp widget hoạt hình kế thừa từ AnimatedWidget và override phương thức build. */

class MyAnimatedWidget extends AnimatedWidget {
  const MyAnimatedWidget({Key? key, required Animation<double> animation})
      : super(key: key, listenable: animation);

  @override
  Widget build(BuildContext context) {
    final animation = listenable as Animation<double>;
    return Container(
      width: animation.value,
      height: animation.value,
      color: Colors.blue,
    );
  }
}

// Example 2

class SizeAnimatedWidget extends AnimatedWidget {
  const SizeAnimatedWidget({Key? key, required Animation<double> animation})
      : super(key: key, listenable: animation);

  @override
  Widget build(BuildContext context) {
    final animation = listenable as Animation<double>;
    return Container(
      width: animation.value,
      height: animation.value,
      color: const Color.fromARGB(255, 244, 15, 210),
    );
  }
}

class AnimatedWidget02 extends StatefulWidget {
  const AnimatedWidget02({super.key});

  @override
  _AnimatedWidget02State createState() => _AnimatedWidget02State();
}

class _AnimatedWidget02State extends State<AnimatedWidget02>
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
    _animation = Tween<double>(begin: 0, end: 150).animate(_controller);
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
      appBar: AppBar(title: const Text('Size Animation Example 02')),
      body: Center(child: SizeAnimatedWidget(animation: _animation)),
    );
  }
}

// Example 3
class RotationAnimatedWidget extends AnimatedWidget {
  const RotationAnimatedWidget({Key? key, required Animation<double> animation})
      : super(key: key, listenable: animation);

  @override
  Widget build(BuildContext context) {
    final animation = listenable as Animation<double>;
    return Transform.rotate(
      angle: animation.value,
      child: Container(
        width: 100,
        height: 100,
        color: Colors.red,
      ),
    );
  }
}

class AnimatedWidget03 extends StatefulWidget {
  const AnimatedWidget03({super.key});

  @override
  _AnimatedWidget03State createState() => _AnimatedWidget03State();
}

class _AnimatedWidget03State extends State<AnimatedWidget03>
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
      appBar: AppBar(title: const Text('Rotation Animation Example 03')),
      body: Center(child: RotationAnimatedWidget(animation: _animation)),
    );
  }
}

// Example 4

class TranslationAnimatedWidget extends AnimatedWidget {
  const TranslationAnimatedWidget(
      {Key? key, required Animation<double> animation})
      : super(key: key, listenable: animation);

  @override
  Widget build(BuildContext context) {
    final animation = listenable as Animation<double>;
    return Transform.translate(
      offset: Offset(animation.value, 0),
      child: Container(
        width: 100,
        height: 100,
        color: Colors.green,
      ),
    );
  }
}

class AnimatedWidget04 extends StatefulWidget {
  const AnimatedWidget04({super.key});

  @override
  _AnimatedWidget04State createState() => _AnimatedWidget04State();
}

class _AnimatedWidget04State extends State<AnimatedWidget04>
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
      appBar: AppBar(title: const Text('Translation Animation Example 4')),
      body: Center(child: TranslationAnimatedWidget(animation: _animation)),
    );
  }
}

// Example 5
// LogoApp -> AnimatedLogo -> FlutterLogo
class AnimatedLogo extends AnimatedWidget {
  const AnimatedLogo({Key? key, required Animation<double> animation})
      : super(key: key, listenable: animation);

// Make the Tweens static because they don't change.
  static final _opacityTween = Tween<double>(begin: 0.1, end: 1);
  static final _sizeTween = Tween<double>(begin: 0, end: 300);

  @override
  Widget build(BuildContext context) {
    final animation = listenable as Animation<double>;
    return Center(
      child: Opacity(
        opacity: _opacityTween.evaluate(animation),
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 10),
          height: _sizeTween.evaluate(animation),
          width: _sizeTween.evaluate(animation),
          child: const FlutterLogo(),
        ),
      ),
    );
  }
}

class LogoApp extends StatefulWidget {
  const LogoApp({Key? key}) : super(key: key);

  @override
  _LogoAppState createState() => _LogoAppState();
}

class _LogoAppState extends State<LogoApp> with SingleTickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(duration: const Duration(seconds: 2), vsync: this);
    animation = CurvedAnimation(parent: controller, curve: Curves.easeIn)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          controller.reverse();
        } else if (status == AnimationStatus.dismissed) {
          controller.forward();
        }
      });
    controller.forward();
  }

  @override
  Widget build(BuildContext context) => AnimatedLogo(animation: animation);

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
