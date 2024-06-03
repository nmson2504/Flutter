import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TweenSequenceBox extends StatefulWidget {
  const TweenSequenceBox({
    required super.key,
  });

  @override
  _TweenSequenceBoxState createState() => _TweenSequenceBoxState();
}

class _TweenSequenceBoxState extends State<TweenSequenceBox>
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

  Animatable<Color> bgColor = TweenSequence<Color>([
    TweenSequenceItem(
      weight: 1.0,
      tween: Tween<Color>(
        begin: Colors.red,
        end: Colors.blue,
      ),
    ),
    TweenSequenceItem(
      weight: 1.0,
      tween: Tween<Color>(
        begin: Colors.blue,
        end: Colors.green,
      ),
    ),
    TweenSequenceItem(
      weight: 1.0,
      tween: Tween<Color>(
        begin: Colors.green,
        end: Colors.yellow,
      ),
    ),
    TweenSequenceItem(
      weight: 1.0,
      tween: Tween<Color>(
        begin: Colors.yellow,
        end: Colors.red,
      ),
    ),
  ]);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Container(
            padding: const EdgeInsets.all(24.0),
            decoration: BoxDecoration(color: _colorAnim.value),
            child: const Text('Tween Sequence'),
          );
        });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
