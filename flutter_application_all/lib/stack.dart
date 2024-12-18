import 'package:flutter/material.dart';

class MyStack extends StatelessWidget {
  const MyStack({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Flutter Stack')),
        body: const AnimatedPositionedDirectionalDemo4(),
        // backgroundColor: Color.fromARGB(255, 235, 217, 163),
      ),
    );
  }
}

class MyStack0 extends StatelessWidget {
  const MyStack0({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.centerLeft, // align các object trên so container cha
      // alignment: AlignmentDirectional.bottomCenter, // or AlignmentDirectional.bottomEnd
      // textDirection: TextDirection.rtl, // chiều đổ stack
      children: <Widget>[
        Container(
          width: 290,
          height: 190,
          color: Colors.green,
        ),
        Container(
          width: 300,
          height: 170,
          color: Colors.red,
        ),
        Container(
          width: 220,
          height: 400,
          color: Colors.yellow,
        ),
      ],
    );
  }
}

class MyStack1 extends StatelessWidget {
  const MyStack1({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.grey,
        // height: 400,
        width: 500,
        child: Stack(
          // alignment:Alignment.center, // align all object so container cha
          alignment: AlignmentDirectional.bottomEnd, // or AlignmentDirectional.bottomEnd
          // textDirection: TextDirection.rtl, // chiều đổ stack
          // fit: StackFit.passthrough,
          // Default is StackFit.loose - ko thay đổi kích thước;
          //StackFit.expand - bung full 2 chiều container cha;
          // StackFit.passthrough - nếu container cha có set height thì bung full width của container cha, nếu container cha có set width thì bung full height của container cha, nếu set cả height & width thì như expand;
          // clipBehavior: Clip.none,
          children: <Widget>[
            Container(
              width: 300,
              height: 190,
              color: Colors.green,
            ),
            Container(
              width: 280,
              height: 170,
              color: Colors.red,
            ),
            Container(
              width: 220,
              height: 520,
              color: Colors.yellow,
            ),
          ],
        ));
  }
}

class MyStack2 extends StatelessWidget {
  const MyStack2({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.grey,
        height: 400,
        width: 500,
        child: Stack(
          // alignment:Alignment.center, // align các object trên so với object dưới cùng
          alignment: AlignmentDirectional.bottomEnd, // or AlignmentDirectional.bottomEnd
          clipBehavior: Clip
              .none, // xử lý khi object tràn khỏi container (set Positioned(top, left...)). Clip.none - show full object, các value khác - cắt phần tràn ngoài container
          children: <Widget>[
            Container(
              width: 300,
              height: 190,
              color: Colors.green,
            ),
            Container(
              width: 280,
              height: 170,
              color: Colors.red,
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Container(
                width: 200,
                height: 550,
                color: Colors.yellow,
              ),
            ),
            Positioned(
              bottom: 0,
              left: 300,
              child: Container(
                width: 220,
                height: 520,
                color: const Color.fromARGB(255, 255, 59, 232),
              ),
            ),
          ],
        ));
  }
}

class MyStack3 extends StatelessWidget {
  const MyStack3({super.key});
// canh object A theo object B
  @override
  Widget build(BuildContext context) {
    double parentWidth = 400;
    double parentHeight = 380;
    double childWidth = 200;
    double childHeight = 120;

    double topCenter = (parentHeight - childHeight) / 2;
    double rightCenter = (parentWidth - childWidth) / 2;

    double heightOffset = parentHeight - childHeight;
    double widthOffset = parentWidth - childWidth;

    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.center,
      children: <Widget>[
        Container(
          width: parentWidth,
          height: parentHeight,
          color: Colors.green,
        ),
        // align center
        Positioned(
          top: topCenter,
          right: rightCenter,
          child: Container(
            width: childWidth,
            height: childHeight,
            color: Colors.red,
          ),
        ),
        // align bottom - left
        Positioned(
          top: heightOffset,
          right: widthOffset,
          child: Container(
            width: childWidth,
            height: childHeight,
            color: const Color.fromARGB(255, 124, 54, 244),
          ),
        ),
        // align bottom - right
        Positioned(
          top: heightOffset,
          left: widthOffset,
          child: Container(
            width: childWidth,
            height: childHeight,
            color: const Color.fromARGB(255, 244, 238, 54),
          ),
        ),
        // align top - right
        Positioned(
          bottom: heightOffset,
          left: widthOffset,
          child: Container(
            width: childWidth,
            height: childHeight,
            color: const Color.fromARGB(255, 244, 54, 228),
          ),
        ),
        // align top - left
        Positioned(
          bottom: heightOffset,
          right: widthOffset,
          child: Container(
            width: childWidth,
            height: childHeight,
            color: const Color.fromARGB(255, 101, 219, 240),
          ),
        ),
        // align center - left
        Positioned(
          bottom: topCenter,
          right: widthOffset,
          child: Container(
            width: childWidth,
            height: childHeight,
            color: const Color.fromARGB(255, 101, 240, 191),
          ),
        ),
        // align center - right
        Positioned(
          bottom: topCenter,
          left: widthOffset,
          child: Container(
            width: childWidth,
            height: childHeight,
            color: const Color.fromARGB(255, 240, 177, 101),
          ),
        ),
        // align center - bottom
        Positioned(
          top: heightOffset,
          left: rightCenter,
          child: Container(
            width: childWidth,
            height: childHeight,
            color: const Color.fromARGB(255, 121, 174, 168),
          ),
        ),
        // align center - top
        Positioned(
          bottom: heightOffset,
          left: rightCenter,
          child: Container(
            width: childWidth,
            height: childHeight,
            color: const Color.fromARGB(255, 230, 175, 199),
          ),
        ),
      ],
    );
  }
}

// Positioned.directional({Key? key,required TextDirection textDirection,double? start,double? top,double? end,double? bottom,double? width,double? height,required Widget child})
/* Chỉ có thể thiết lập hai trong ba giá trị ngang (start, end, width) và chỉ có thể thiết lập hai trong ba giá trị dọc (top, bottom, height). Trong mỗi trường hợp, ít nhất một trong ba giá trị phải là null. */

class PositionedDirectionalDemo extends StatelessWidget {
  const PositionedDirectionalDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: 300,
          height: 300,
          color: Colors.yellow,
        ),
        // Positioned.directional widget
        Positioned.directional(
          textDirection: TextDirection.ltr,
          start: 50,
          top: 50,
          width: 100,
          height: 100,
          child: Container(
            color: Colors.blue,
            child: const Center(
              child: Text(
                'LTR',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ),
        Positioned.directional(
          textDirection: TextDirection.rtl,
          start: 50,
          top: 150,
          width: 100,
          height: 100,
          child: Container(
            color: Colors.red,
            child: const Center(
              child: Text(
                'RTL',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// Positioned.fromRect({Key? key, required Rect rect, required Widget child})
/* 
Sử dụng Positioned.fromRect để định vị một Container màu xanh lam tại vị trí được xác định bởi Rect.fromLTWH(50, 50, 100, 100), với kích thước 100x100 bắt đầu từ tọa độ (50, 50). */
class PositionedFromRectDemo extends StatelessWidget {
  const PositionedFromRectDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: 300,
          height: 300,
          color: Colors.yellow,
        ),
        Positioned.fromRect(
          rect: const Rect.fromLTWH(50, 50, 100, 100),
          child: Container(
            color: Colors.blue,
            child: const Center(
              child: Text(
                'Rect.fromLTWH',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// Positioned.fromRelativeRect({Key? key, required RelativeRect rect, required Widget child})
/* Sử dụng Positioned.fromRelativeRect để định vị một Container màu xanh lam dựa trên RelativeRect.fromLTRB(50, 50, 150, 150). Điều này có nghĩa là widget con sẽ được đặt cách 50 đơn vị từ cạnh trái, 50 đơn vị từ cạnh trên, 150 đơn vị từ cạnh phải và 150 đơn vị từ cạnh dưới của Stack. */
class PositionedFromRelativeRectDemo extends StatelessWidget {
  const PositionedFromRelativeRectDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: 300,
          height: 300,
          color: Colors.yellow,
        ),
        Positioned.fromRelativeRect(
          rect: const RelativeRect.fromLTRB(50, 50, 150, 150),
          child: Container(
            color: Colors.blue,
            child: const Center(
              child: Text(
                'RelativeRect.fromLTRB',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ),
      ],
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
