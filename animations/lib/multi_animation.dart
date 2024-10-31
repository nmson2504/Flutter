import 'package:flutter/material.dart';

// Các phương án triển khai nhiều animation cùng lúc

// Sử dụng từng AnimatedBuilder cho mỗi animation
// Đây là cách phổ biến nhất để chạy hai Animation đồng thời
class AnimatedWidget001 extends StatefulWidget {
  const AnimatedWidget001({super.key});

  @override
  _AnimatedWidget001State createState() => _AnimatedWidget001State();
}

class _AnimatedWidget001State extends State<AnimatedWidget001> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation1;
  late Animation<double> _animation2;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    // Animation for first container
    _animation1 = Tween<double>(begin: 0, end: 200).animate(_controller);

    // Animation for second container
    _animation2 = Tween<double>(begin: 0, end: 150).animate(_controller);

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
      appBar: AppBar(title: const Text('Multi AnimatedBuilder')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedBuilder(
              animation: _animation1,
              builder: (context, child) {
                return Container(
                  width: _animation1.value,
                  height: _animation1.value,
                  color: Colors.blue,
                );
              },
            ),
            const SizedBox(height: 20), // Space between two animations
            AnimatedBuilder(
              animation: _animation2,
              builder: (context, child) {
                return Container(
                  width: _animation2.value,
                  height: _animation2.value,
                  color: Colors.red,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

// Truyền nhiều animation vào một AnimatedBuilder
class AnimatedWidget002 extends StatefulWidget {
  const AnimatedWidget002({super.key});

  @override
  State<AnimatedWidget002> createState() => _AnimatedWidget002State();
}

class _AnimatedWidget002State extends State<AnimatedWidget002> with TickerProviderStateMixin {
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
      duration: const Duration(seconds: 3),
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

// Tạo widget quản lý nhiều Animation
class AnimatedWidget003 extends StatefulWidget {
  const AnimatedWidget003({super.key});

  @override
  _AnimatedWidget003State createState() => _AnimatedWidget003State();
}

class _AnimatedWidget003State extends State<AnimatedWidget003> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation1;
  late Animation<double> _animation2;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    // First animation
    _animation1 = Tween<double>(begin: 150, end: 0).animate(_controller);

    // Second animation
    _animation2 = Tween<double>(begin: 0, end: 150).animate(_controller);

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
      appBar: AppBar(title: const Text('Dual Animation Example')),
      body: Center(
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return MyDualAnimatedWidget(
              animation1: _animation1,
              animation2: _animation2,
            );
          },
        ),
      ),
    );
  }
}

class MyDualAnimatedWidget extends StatelessWidget {
  final Animation<double> animation1;
  final Animation<double> animation2;

  const MyDualAnimatedWidget({
    Key? key,
    required this.animation1,
    required this.animation2,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: animation1.value,
          height: animation1.value,
          color: Colors.blue,
        ),
        const SizedBox(height: 20),
        Container(
          width: animation2.value,
          height: animation2.value,
          color: Colors.red,
        ),
      ],
    );
  }
}

//Listenable.merge() có thể kết hợp nhiều Animation lại thành một Listenable duy nhất, giúp quản lý và lắng nghe thay đổi từ nhiều animation.
class AnimatedWidget004 extends StatefulWidget {
  const AnimatedWidget004({super.key});

  @override
  _AnimatedWidget004State createState() => _AnimatedWidget004State();
}

class _AnimatedWidget004State extends State<AnimatedWidget004> with TickerProviderStateMixin {
  late AnimationController _controller;
  late AnimationController _controller2;
  late Animation<double> _animation;
  late Animation<double> _animation2;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0, end: 100).animate(_controller);
    _controller.repeat(reverse: true);

    _controller2 = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    _animation2 = Tween<double>(begin: 0, end: 200).animate(_controller2);
    _controller2.repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    _controller2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Listenable.merge with Two Animations')),
      body: Center(
        // Using Listenable.merge to listen to both animations
        child: AnimatedBuilder(
          animation: Listenable.merge([_animation, _animation2]), // Combine both animations
          builder: (context, child) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: _animation.value, // Using the first animation
                  height: _animation.value,
                  color: Colors.blue,
                ),
                const SizedBox(height: 20),
                Container(
                  width: _animation2.value, // Using the second animation
                  height: 50,
                  color: Colors.red,
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

// Kết hợp các AnimatedWidget
