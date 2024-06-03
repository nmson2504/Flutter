import 'package:flutter/material.dart';

// Các methods của AnimationController

class ExplicitC1 extends StatefulWidget {
  const ExplicitC1({super.key});

  @override
  State<ExplicitC1> createState() => _ExplicitC1State();
}

// SingleTickerProviderStateMixin cung cấp TickerProvider - Ticker cho AnimationController để điều khiển thời gian của animation.
class _ExplicitC1State extends State<ExplicitC1> with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );

    _animation = Tween<double>(
      begin: 0,
      end: 200,
    ).animate(_controller);

    // Start animation
    // _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Animation Controller Methods Demo'),
      ),
      body: Center(
        child: AnimatedBuilder(
          animation: _animation,
          builder: (context, child) {
            return Container(
              width: 300,
              height: 50,
              margin: EdgeInsets.only(left: _animation.value),
              color: Colors.blue,
            );
          },
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          FloatingActionButton(
            onPressed: () {
              // Reverse animation
              _controller.stop();
            },
            tooltip: 'Stop',
            child: const Icon(Icons.stop),
          ),
          const SizedBox(height: 16),
          FloatingActionButton(
            onPressed: () {
              // Reverse animation
              _controller.forward();
            },
            tooltip: 'Forward',
            child: const Icon(Icons.next_plan_outlined),
          ),
          const SizedBox(height: 16),
          FloatingActionButton(
            onPressed: () {
              // Reverse animation
              _controller.reverse();
            },
            tooltip: 'Reverse',
            child: const Icon(Icons.undo),
          ),
          const SizedBox(height: 16),
          FloatingActionButton(
            onPressed: () {
              // Start animation from beginning
              _controller.reset();
              // _controller.forward();
            },
            tooltip: 'Reset',
            child: const Icon(Icons.refresh),
          ),
          const SizedBox(height: 16),
          FloatingActionButton(
            onPressed: () {
              // Repeat animation
              _controller.repeat(reverse: true);
            },
            tooltip: 'Repeat',
            child: const Icon(Icons.repeat),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
