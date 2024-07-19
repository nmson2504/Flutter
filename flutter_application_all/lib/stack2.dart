import 'package:flutter/material.dart';

class MyStackB extends StatelessWidget {
  const MyStackB({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Flutter Stack Animation')),
        body: const PositionedTransitionExample(),
        // backgroundColor: Color.fromARGB(255, 235, 217, 163),
      ),
    );
  }
}

// AnimatedPositionedDirectional example 1 - move ver 1
class AnimatedPositionedDirectionalDemo extends StatefulWidget {
  const AnimatedPositionedDirectionalDemo({super.key});

  @override
  _AnimatedPositionedDirectionalDemoState createState() => _AnimatedPositionedDirectionalDemoState();
}

class _AnimatedPositionedDirectionalDemoState extends State<AnimatedPositionedDirectionalDemo> {
  bool _isMoved = false;

  void _togglePosition() {
    setState(() {
      _isMoved = !_isMoved;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: 300,
          height: 300,
          color: Colors.yellow,
        ),
        AnimatedPositionedDirectional(
          start: _isMoved ? 150 : 50,
          top: 50,
          width: 100,
          height: 100,
          curve: Curves.easeInOut,
          duration: const Duration(seconds: 1),
          child: Container(
            color: Colors.blue,
            child: const Center(
              child: Text(
                'Move me',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          onEnd: () {
            print('Animation ended');
          },
        ),
        Positioned(
          bottom: 20,
          left: 20,
          child: ElevatedButton(
            onPressed: _togglePosition,
            child: const Text('Toggle Position'),
          ),
        ),
      ],
    );
  }
}

// AnimatedPositionedDirectional example 2 - move ver 2
class AnimatedPositionedDirectionalDemo2 extends StatefulWidget {
  const AnimatedPositionedDirectionalDemo2({super.key});

  @override
  _AnimatedPositionedDirectionalDemo2State createState() => _AnimatedPositionedDirectionalDemo2State();
}

class _AnimatedPositionedDirectionalDemo2State extends State<AnimatedPositionedDirectionalDemo2>
    with TickerProviderStateMixin {
  bool _isAnimated = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: Container(color: Colors.grey[300]), // Background
        ),
        AnimatedPositionedDirectional(
          start: _isAnimated ? 200.0 : 50.0,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
          onEnd: () => setState(() => _isAnimated = !_isAnimated),
          child: Container(
            color: Colors.blue,
            width: 100.0,
            height: 100.0,
          ),
        ),
        Positioned(
          bottom: 20.0,
          right: 20.0,
          child: FloatingActionButton(
            onPressed: () => setState(() => _isAnimated = !_isAnimated),
            child: const Icon(Icons.play_arrow),
          ),
        ),
      ],
    );
  }
}

// AnimatedPositionedDirectional example 3 - resize
class AnimatedPositionedDirectionalDemo3 extends StatefulWidget {
  const AnimatedPositionedDirectionalDemo3({super.key});

  // @override
  _AnimatedPositionedDirectionalDemo3State createState() => _AnimatedPositionedDirectionalDemo3State();
}

class _AnimatedPositionedDirectionalDemo3State extends State<AnimatedPositionedDirectionalDemo3>
    with TickerProviderStateMixin {
  bool _isAnimated = false;
  double _width = 100.0; // Initial width
  double _height = 100.0; // Initial height
  late AnimationController _controller; // Animation controller
  late Animation<double> _widthAnimation; // Animation for width
  late Animation<double> _heightAnimation; // Animation for height

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _widthAnimation = Tween<double>(begin: 100.0, end: 200.0).animate(_controller);
    _heightAnimation = Tween<double>(begin: 100.0, end: 200.0).animate(_controller);

    _controller.addListener(() {
      setState(() {
        _width = _widthAnimation.value;
        _height = _heightAnimation.value;
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: Container(color: Colors.grey[300]), // Background
        ),
        AnimatedPositionedDirectional(
          start: _isAnimated ? 200.0 : 50.0,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
          onEnd: () => setState(() => _isAnimated = !_isAnimated),
          child: Container(
            color: Colors.blue,
            width: _width,
            height: _height,
          ),
        ),
        Positioned(
          bottom: 20.0,
          right: 20.0,
          child: FloatingActionButton(
            onPressed: () {
              if (_controller.isAnimating) {
                _controller.reverse();
              } else {
                _controller.forward();
              }
            },
            child: Icon(
              _controller.isAnimating ? Icons.pause : Icons.play_arrow,
            ),
          ),
        ),
      ],
    );
  }
}

// AnimatedPositionedDirectional example 3b - resize ver 2

class AnimatedPositionedDirectionalExample extends StatefulWidget {
  const AnimatedPositionedDirectionalExample({super.key});

  @override
  State<AnimatedPositionedDirectionalExample> createState() => _AnimatedPositionedDirectionalExampleState();
}

class _AnimatedPositionedDirectionalExampleState extends State<AnimatedPositionedDirectionalExample> {
  bool selected = false;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr, // You can change this to TextDirection.rtl if needed
      child: SizedBox(
        width: 200,
        height: 350,
        child: Stack(
          children: <Widget>[
            AnimatedPositionedDirectional(
              start: selected ? 0.0 : 150.0, // Horizontal position
              top: selected ? 50.0 : 150.0, // Vertical position
              width: selected ? 200.0 : 50.0,
              height: selected ? 50.0 : 200.0,
              duration: const Duration(seconds: 2),
              curve: Curves.fastOutSlowIn,
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
      ),
    );
  }
}

// AnimatedPositionedDirectional example 4 - resize rồi move
class AnimatedPositionedDirectionalDemo4 extends StatefulWidget {
  const AnimatedPositionedDirectionalDemo4({super.key});

  @override
  _AnimatedPositionedDirectionalDemo4State createState() => _AnimatedPositionedDirectionalDemo4State();
}

class _AnimatedPositionedDirectionalDemo4State extends State<AnimatedPositionedDirectionalDemo4>
    with TickerProviderStateMixin {
  bool _isAnimated = false;
  double _start = 50.0; // Initial start position
  double _width = 100.0; // Initial width
  double _height = 100.0; // Initial height
  late AnimationController _controller; // Animation controller
  late Animation<double> _startAnimation; // Animation for start position
  late Animation<double> _widthAnimation; // Animation for width
  late Animation<double> _heightAnimation; // Animation for height

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _startAnimation = Tween<double>(begin: 50.0, end: 200.0).animate(_controller);
    _widthAnimation = Tween<double>(begin: 100.0, end: 200.0).animate(_controller);
    _heightAnimation = Tween<double>(begin: 100.0, end: 200.0).animate(_controller);

    _controller.addListener(() {
      setState(() {
        _start = _startAnimation.value;
        _width = _widthAnimation.value;
        _height = _heightAnimation.value;
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: Container(color: Colors.grey[300]), // Background
        ),
        AnimatedPositionedDirectional(
          top: 0,
          start: _start,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
          onEnd: () => setState(() => _isAnimated = !_isAnimated),
          child: Container(
            color: Colors.blue,
            width: _width,
            height: _height,
          ),
        ),
        Positioned(
          bottom: 20.0,
          right: 20.0,
          child: FloatingActionButton(
            onPressed: () {
              if (_controller.isAnimating) {
                _controller.reverse();
              } else {
                _controller.forward();
              }
            },
            child: Icon(
              _controller.isAnimating ? Icons.pause : Icons.play_arrow,
            ),
          ),
        ),
      ],
    );
  }
}

// AnimatedPositionedDirectional example 5 - move & resize đòng thời
class AnimatedPositionedDirectionalDemo5 extends StatefulWidget {
  const AnimatedPositionedDirectionalDemo5({super.key});

  @override
  _AnimatedPositionedDirectionalDemo5State createState() => _AnimatedPositionedDirectionalDemo5State();
}

class _AnimatedPositionedDirectionalDemo5State extends State<AnimatedPositionedDirectionalDemo5> {
  bool _isMoved = false;

  void _togglePosition() {
    setState(() {
      _isMoved = !_isMoved;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: 300,
          height: 300,
          color: Colors.yellow,
        ),
        AnimatedPositionedDirectional(
          start: _isMoved ? 150 : 50,
          top: _isMoved ? 150 : 50,
          duration: const Duration(seconds: 1),
          curve: Curves.easeInOut,
          child: AnimatedContainer(
            width: _isMoved ? 150 : 60,
            height: _isMoved ? 150 : 60,
            duration: const Duration(seconds: 1),
            curve: Curves.easeInOut,
            color: Colors.blue,
            child: const Center(
              child: Text(
                'Move and Resize',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          left: 20,
          child: ElevatedButton(
            onPressed: _togglePosition,
            child: const Text('Toggle Position and Size'),
          ),
        ),
      ],
    );
  }
}

// AnimatedPositionedDirectionalDemo 6 - move & resize đòng thời ver 2

class AnimatedPositionedDirectionalDemo6 extends StatefulWidget {
  const AnimatedPositionedDirectionalDemo6({super.key});

  @override
  _AnimatedPositionedDirectionalDemo6State createState() => _AnimatedPositionedDirectionalDemo6State();
}

class _AnimatedPositionedDirectionalDemo6State extends State<AnimatedPositionedDirectionalDemo6>
    with TickerProviderStateMixin {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: Container(color: Colors.grey[300]), // Background
        ),
        AnimatedPositionedDirectional(
          start: _isExpanded ? 150 : 50,
          top: _isExpanded ? 150 : 50,
          width: _isExpanded ? 200 : 100,
          height: _isExpanded ? 200 : 100,
          duration: const Duration(milliseconds: 1000),
          curve: Curves.easeInOut,
          child: Container(
            color: Colors.blue,
            child: const Center(
              child: Text(
                'Move and Resize',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 20.0,
          right: 20.0,
          child: FloatingActionButton(
            onPressed: () {
              setState(() {
                _isExpanded = !_isExpanded;
              });
            },
            child: Icon(
              _isExpanded ? Icons.expand_less : Icons.expand_more,
            ),
          ),
        ),
      ],
    );
  }
}

// AnimatedPositioned Example - click is change size & move

class AnimatedPositionedExample extends StatefulWidget {
  const AnimatedPositionedExample({super.key});

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
            duration: const Duration(seconds: 2),
            curve: Curves.fastOutSlowIn,
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

// PositionedTransition Example - transition object
class PositionedTransitionExample extends StatefulWidget {
  const PositionedTransitionExample({super.key});

  @override
  State<PositionedTransitionExample> createState() => _PositionedTransitionExampleState();
}

/// [AnimationController]s can be created with `vsync: this` because of
/// [TickerProviderStateMixin].
class _PositionedTransitionExampleState extends State<PositionedTransitionExample> with TickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 2),
    vsync: this,
  )..repeat(reverse: true);

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const double smallLogo = 100;
    const double bigLogo = 200;

    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final Size biggest = constraints.biggest;
        return Stack(
          children: <Widget>[
            PositionedTransition(
              rect: RelativeRectTween(
                begin: RelativeRect.fromSize(
                  const Rect.fromLTWH(0, 0, smallLogo, smallLogo),
                  biggest,
                ),
                end: RelativeRect.fromSize(
                  Rect.fromLTWH(biggest.width - bigLogo, biggest.height - bigLogo, bigLogo, bigLogo),
                  biggest,
                ),
              ).animate(CurvedAnimation(
                parent: _controller,
                curve: Curves.elasticInOut,
              )),
              child: const Padding(
                padding: EdgeInsets.all(8),
                child: FlutterLogo(),
              ),
            ),
          ],
        );
      },
    );
  }
}
