import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rainbow_color/rainbow_color.dart';

class RainbowColorTweenBox extends StatefulWidget {
  const RainbowColorTweenBox({
    required super.key,
  });

  @override
  _RainbowColorTweenBoxState createState() => _RainbowColorTweenBoxState();
}

class _RainbowColorTweenBoxState extends State<RainbowColorTweenBox>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Color> _colorAnim;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 5),
      vsync: this,
    )
      ..forward()
      ..repeat();
    _colorAnim = bgColor.animate(_controller);
  }

  Animatable<Color> bgColor = RainbowColorTween([
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
              decoration: BoxDecoration(color: _colorAnim.value),
              child: const Text('RainbowColorTween'));
        });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
