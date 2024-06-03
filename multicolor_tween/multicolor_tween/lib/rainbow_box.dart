import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rainbow_color/rainbow_color.dart';

class RainbowBox extends StatefulWidget {
  const RainbowBox({
    required super.key,
  });

  @override
  _RainbowBoxState createState() => _RainbowBoxState();
}

class _RainbowBoxState extends State<RainbowBox>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _anim;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 5),
      vsync: this,
    )
      ..forward()
      ..repeat();
    _anim = bgValue.animate(_controller);
  }

  Animatable<double> bgValue = Tween<double>(begin: 0.0, end: 10.0);
  Rainbow rb = Rainbow(rangeStart: 0.0, rangeEnd: 10.0, spectrum: [
    Colors.red,
    Colors.blue,
    Colors.green,
    Colors.yellow,
    Colors.red,
  ]);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Container(
              padding: const EdgeInsets.all(24.0),
              // lerp the spectrum for background color
              decoration: BoxDecoration(color: rb[_anim.value]),
              child: Text(
                'Rainbow',
                // shift the foreground color backward
                style: TextStyle(color: rb[(_anim.value - 2) % 10]),
              ));
        });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
