import 'dart:math';

import 'package:flutter/material.dart';

class AnimatedContainerExampleApp extends StatelessWidget {
  const AnimatedContainerExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    var mapC = {
      1: () => const AnimatedContainerExample(),
      2: () => const AnimatedAlignExample(),
      3: () => const AnimatedPaddingExample(),
      4: () => const AnimatedSlideExample(),
      5: () => const AnimatedPositionedExample(),
      6: () => const AnimatedSizeExample(),
      7: () => const AnimatedSwitcherExample(),
      // 3: () => controllerSink(),
    };

    int n = 7; // Giá trị n có thể thay đổi

    // Kiểm tra nếu map chứa key n
    Widget bodyWidget;
    if (mapC.containsKey(n)) {
      bodyWidget = mapC[n]!(); // Gọi hàm trả về Widget
    } else {
      bodyWidget = const Center(child: Text('Không tìm thấy widget'));
    }

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('AnimatedWidget Sample')),
        body: bodyWidget, // Truyền Widget vào body
      ),
    );
  }
}

// Demo nhóm AnimatedXXX (AnimatedContainer, AnimatedPositioned,...)

class AnimatedContainerExample extends StatefulWidget {
  const AnimatedContainerExample({super.key});

  @override
  State<AnimatedContainerExample> createState() => _AnimatedContainerExampleState();
}

class _AnimatedContainerExampleState extends State<AnimatedContainerExample> {
  bool selected = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selected = !selected;
        });
      },
      child: Center(
        child: AnimatedContainer(
          width: selected ? 200.0 : 100.0,
          height: selected ? 100.0 : 200.0,
          color: selected ? Colors.red : Colors.blue,
          alignment: selected ? Alignment.center : AlignmentDirectional.topCenter,
          duration: const Duration(seconds: 2),
          curve: Curves.fastOutSlowIn,
          child: const FlutterLogo(size: 75),
        ),
      ),
    );
  }
}

//
class AnimatedAlignExample extends StatefulWidget {
  const AnimatedAlignExample({
    super.key,
  });

  final Duration duration = const Duration(seconds: 1);
  final Curve curve = Curves.fastOutSlowIn;

  @override
  State<AnimatedAlignExample> createState() => _AnimatedAlignExampleState();
}

class _AnimatedAlignExampleState extends State<AnimatedAlignExample> {
  bool selected = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selected = !selected;
        });
      },
      child: Center(
        child: Container(
          width: 250.0,
          height: 250.0,
          color: Colors.red,
          child: AnimatedAlign(
            alignment: selected ? Alignment.topRight : Alignment.bottomLeft,
            duration: widget.duration,
            curve: widget.curve,
            child: const FlutterLogo(size: 50.0),
          ),
        ),
      ),
    );
  }
}

//
class AnimatedPaddingExample extends StatefulWidget {
  const AnimatedPaddingExample({super.key});

  @override
  State<AnimatedPaddingExample> createState() => _AnimatedPaddingExampleState();
}

class _AnimatedPaddingExampleState extends State<AnimatedPaddingExample> {
  double padValue = 0.0;
  void _updatePadding(double value) {
    setState(() {
      padValue = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        AnimatedPadding(
          padding: EdgeInsets.all(padValue),
          duration: const Duration(seconds: 2),
          curve: Curves.easeInOut,
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 5,
            color: Colors.blue,
          ),
        ),
        Text('Padding: $padValue'),
        ElevatedButton(
            child: const Text('Change padding'),
            onPressed: () {
              _updatePadding(padValue == 0.0 ? 100.0 : 0.0);
            }),
      ],
    );
  }
}

//
class AnimatedSlideExample extends StatefulWidget {
  const AnimatedSlideExample({super.key});

  @override
  State<AnimatedSlideExample> createState() => _AnimatedSlideExampleState();
}

class _AnimatedSlideExampleState extends State<AnimatedSlideExample> {
  Offset offset = Offset.zero;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(title: const Text('AnimatedSlide Sample')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Expanded(
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.all(50.0),
                      child: AnimatedSlide(
                        offset: offset,
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeInOut,
                        child: const FlutterLogo(size: 50.0),
                      ),
                    ),
                  ),
                  Column(
                    children: <Widget>[
                      Text('Y', style: textTheme.bodyMedium),
                      Expanded(
                        child: RotatedBox(
                          quarterTurns: 1,
                          child: Slider(
                            min: -5.0,
                            max: 5.0,
                            value: offset.dy,
                            onChanged: (double value) {
                              setState(() {
                                offset = Offset(offset.dx, value);
                              });
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Text('X', style: textTheme.bodyMedium),
                Expanded(
                  child: Slider(
                    min: -5.0,
                    max: 5.0,
                    value: offset.dx,
                    onChanged: (double value) {
                      setState(() {
                        offset = Offset(value, offset.dy);
                      });
                    },
                  ),
                ),
                const SizedBox(width: 48.0),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

//
class AnimatedPositionedExample extends StatefulWidget {
  static const Duration duration = Duration(seconds: 2);
  static const Curve curve = Curves.fastOutSlowIn;

  const AnimatedPositionedExample({
    super.key,
  });

  @override
  State<AnimatedPositionedExample> createState() => _AnimatedPositionedExampleState();
}

class _AnimatedPositionedExampleState extends State<AnimatedPositionedExample> {
  bool selected = false;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      height: 350,
      child: Stack(
        children: <Widget>[
          AnimatedPositioned(
            width: selected ? 200.0 : 50.0,
            height: selected ? 50.0 : 200.0,
            top: selected ? 50.0 : 150.0,
            duration: AnimatedPositionedExample.duration,
            curve: AnimatedPositionedExample.curve,
            child: GestureDetector(
              onTap: () {
                setState(() {
                  selected = !selected;
                });
              },
              child: const ColoredBox(
                color: Colors.blue,
                child: Center(child: Text('Tap me')),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

//
class AnimatedSizeExample extends StatefulWidget {
  const AnimatedSizeExample({
    super.key,
  });

  final Duration duration = const Duration(seconds: 2);
  final Curve curve = Curves.easeIn;

  @override
  State<AnimatedSizeExample> createState() => _AnimatedSizeExampleState();
}

class _AnimatedSizeExampleState extends State<AnimatedSizeExample> {
  bool _isSelected = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _isSelected = !_isSelected;
        });
      },
      child: ColoredBox(
        color: Colors.amberAccent,
        child: AnimatedSize(
          duration: widget.duration,
          curve: widget.curve,
          child: SizedBox.square(
            dimension: _isSelected ? 250.0 : 100.0,
            child: const Center(
              child: FlutterLogo(size: 75.0),
            ),
          ),
        ),
      ),
    );
  }
}

//
class AnimatedSwitcherExample extends StatefulWidget {
  const AnimatedSwitcherExample({super.key});

  @override
  State<AnimatedSwitcherExample> createState() => _AnimatedSwitcherExampleState();
}

class _AnimatedSwitcherExampleState extends State<AnimatedSwitcherExample> {
  int _count = 0;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 500),
            transitionBuilder: (Widget child, Animation<double> animation) {
              return ScaleTransition(scale: animation, child: child);
            },
            child: Text(
              '$_count',
              // This key causes the AnimatedSwitcher to interpret this as a "new"
              // child each time the count changes, so that it will begin its animation
              // when the count changes.
              key: ValueKey<int>(_count),
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ),
          ElevatedButton(
            child: const Text('Increment'),
            onPressed: () {
              setState(() {
                _count += 1;
              });
            },
          ),
        ],
      ),
    );
  }
}
