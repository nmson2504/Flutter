import 'package:flutter/material.dart';

// Example 1 - AnimatedBuilder với Transform.scale
// _animation = CurvedAnimation
class Explicit01 extends StatefulWidget {
  const Explicit01({super.key});

  @override
  State<Explicit01> createState() => _Explicit01State();
}

// SingleTickerProviderStateMixin cung cấp TickerProvider - Ticker cho AnimationController để điều khiển thời gian của animation.
class _Explicit01State extends State<Explicit01>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
      // vsync là this (tức là SingleTickerProviderStateMixin được sử dụng ở trên).
    );
    // animation có thể gán voi nhiều option tuỳ biến
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Flutter Explicit 1 Animation')),
      body: Center(
        child: AnimatedBuilder(
          animation: _animation,
          builder: (context, child) {
            return Transform.scale(
              scale: _animation.value,
              child: child,
            );
          },
          child: Container(
            width: 100,
            height: 100,
            color: Colors.blue,
          ),
        ),
      ),
    );
  }
}
/* 
+ AnimationController điều khiển thời gian và trạng thái của animation.
+ Animation<double> được sử dụng để định nghĩa một animation với kiểu dữ liệu là double.
+ CurvedAnimation áp dụng một đường cong easing.
+ AnimatedBuilder xây dựng giao diện người dùng dựa trên giá trị của animation.

Transform.scale:
Transform.scale là một widget trong Flutter dùng để thay đổi kích thước (scale) của một widget con(so với size gốc của nó).
Nó nhận một scale và một child. scale xác định tỷ lệ phóng to hoặc thu nhỏ của widget con, và child là widget sẽ bị thay đổi kích thước.
scale: _animation.value:
_animation.value là giá trị hiện tại của animation. Giá trị này thay đổi từ 0.0 đến 1.0 (hoặc bất kỳ phạm vi nào bạn định nghĩa) dựa trên quá trình chạy của AnimationController.
Khi animation tiến triển, _animation.value thay đổi liên tục, dẫn đến việc kích thước của widget con cũng thay đổi liên tục.
child: child:
child là widget con mà bạn muốn thay đổi kích thước.
Trong đoạn mã trên, child là một container với kích thước 100x100 và màu sắc xanh (Container(width: 100, height: 100, color: Colors.blue)).

 */

// Example 2 - Kết hợp AnimationController, Tween, và listener
//   animation = Tween<double>(begin: 0, end: 500).animate(controller)
class Explicit02 extends StatefulWidget {
  const Explicit02({super.key});

  @override
  State<Explicit02> createState() => _Explicit02State();
}

// SingleTickerProviderStateMixin cung cấp TickerProvider - Ticker cho AnimationController để điều khiển thời gian của animation.
class _Explicit02State extends State<Explicit02>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> animation;
  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(duration: const Duration(seconds: 2), vsync: this);
    // vsync là this (tức là SingleTickerProviderStateMixin được sử dụng ở trên).
    // #docregion addListener
    animation = Tween<double>(begin: 0, end: 500).animate(controller)
      ..addListener(() {
        // #enddocregion addListener
        setState(() {
          // The state that has changed here is the animation object's value.
        });
        // #docregion addListener
      });
    // #enddocregion addListener
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        height: animation.value,
        width: animation.value,
        child: const FlutterLogo(),
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
/* 
- Tween<double>(begin: 0, end: 500) tạo ra một tween để định nghĩa phạm vi giá trị của animation từ 0 đến 500 - kích thước object chạy animation
- .animate(controller) chuyển tween thành một animation được điều khiển bởi controller.
- ..addListener() thêm một listener vào animation để cập nhật UI mỗi khi giá trị của animation thay đổi. Trong trường hợp này, setState() được gọi để cập nhật giao diện người dùng dựa trên giá trị mới của animation.
 */

// Example 3 - use TickerProviderStateMixin
//   _animation = Tween<double>(begin: 0, end: 200).animate(CurvedAnimation(
class Explicit03 extends StatefulWidget {
  const Explicit03({super.key});

  @override
  State<Explicit03> createState() => _Explicit03State();
}

// TickerProviderStateMixin cung cấp TickerProvider - Ticker cho AnimationController để điều khiển thời gian của animation.
class _Explicit03State extends State<Explicit03> with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _animation = Tween<double>(begin: 0, end: 200).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));
// controller.repeat(reverse: true) làm cho animation lặp lại vô tận và đảo ngược chiều khi kết thúc.
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
      appBar: AppBar(
          title: const Text('Animation TickerProviderStateMixin Example')),
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
/* 
controller.repeat(reverse: true) làm cho animation lặp lại vô tận và đảo ngược chiều khi kết thúc.
 */

// Example 4 - use TickerProviderStateMixin quản lý nhiều AnimationController trong một State.
//   _animation = Tween<double>(begin: 0, end: 200).animate(CurvedAnimation(
class Explicit04 extends StatefulWidget {
  const Explicit04({super.key});

  @override
  State<Explicit04> createState() => _Explicit04State();
}

// TickerProviderStateMixin cung cấp TickerProvider - Ticker cho AnimationController để điều khiển thời gian của animation.
class _Explicit04State extends State<Explicit04> with TickerProviderStateMixin {
  late AnimationController _controller1;
  late AnimationController _controller2;
  late Animation<double> _animation1;
  late Animation<double> _animation2;

  @override
  void initState() {
    super.initState();

    _controller1 = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _controller2 = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );

    _animation1 = Tween<double>(begin: 0, end: 300).animate(_controller1)
      ..addListener(() {
        setState(() {});
      });

    _animation2 = Tween<double>(begin: 0, end: 300).animate(_controller2)
      ..addListener(() {
        setState(() {});
      });

    _controller1.repeat(reverse: true);
    _controller2.repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller1.dispose();
    _controller2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
            'TickerProviderStateMixin multi AnimationController Demo'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: _animation1.value,
              height: _animation1.value,
              color: Colors.blue,
            ),
            const SizedBox(height: 20),
            Container(
              width: _animation2.value,
              height: _animation2.value,
              color: Colors.red,
            ),
          ],
        ),
      ),
    );
  }
}

// Example 5 - FadeTransition - built-in explicit animations
//   _animation = Tween<double>(begin: 0, end: 200).animate(CurvedAnimation(
class Explicit05 extends StatefulWidget {
  const Explicit05({super.key});

  @override
  State<Explicit05> createState() => _Explicit05State();
}

class _Explicit05State extends State<Explicit05>
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

    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);

    // Lặp lại animation (reverse: true để mờ dần và hiện lại)
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
      appBar: AppBar(
        title: const Text('FadeTransition Demo'),
      ),
      body: Center(
        child: FadeTransition(
          opacity: _animation,
          child: Container(
            width: 200,
            height: 200,
            color: Colors.blue,
            child: const Center(
              child: Text(
                'Fade Transition',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// Example 6 - SlideTransition - built-in explicit animations
//    _animation = Tween<Offset>(...
class Explicit06 extends StatefulWidget {
  const Explicit06({super.key});

  @override
  State<Explicit06> createState() => _Explicit06State();
}

class _Explicit06State extends State<Explicit06>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _animation;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _animation = Tween<Offset>(
      begin: const Offset(-1.0, 0.0),
      end: const Offset(1.0, 0.0),
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    // Lặp lại animation (reverse: true để trượt vào và ra)
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
      appBar: AppBar(
        title: const Text('SlideTransition Demo'),
      ),
      body: Center(
        child: SlideTransition(
          position: _animation,
          child: Container(
            width: 200,
            height: 200,
            color: Colors.blue,
            child: const Center(
              child: Text(
                'Slide Transition',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

//  Example 6a

class Explicit06a extends StatelessWidget {
  const Explicit06a({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.of(context).push(_createRoute());
          },
          child: const Text('Go!'),
        ),
      ),
    );
  }
}

Route _createRoute() {
  return PageRouteBuilder(
    // thời gian transition đi
    transitionDuration: const Duration(seconds: 1), // Adjust the duration here
    // thời gian transition về
    reverseTransitionDuration: const Duration(
        seconds: 2), // Adjust the duration for reverse transition
    pageBuilder: (context, animation, secondaryAnimation) => const Page2(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(0.0, 1.0);
      const end = Offset.zero;
      const curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}

class Page2 extends StatelessWidget {
  const Page2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const Center(
        child: Text('Page 2'),
      ),
    );
  }
}
