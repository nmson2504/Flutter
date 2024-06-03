import 'package:flutter/material.dart';

// Example 1 - AnimatedContainer
class Implicit01 extends StatefulWidget {
  const Implicit01({super.key});

  @override
  State<Implicit01> createState() => _Implicit01State();
}

class _Implicit01State extends State<Implicit01> {
  double _size = 100.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Flutter Implicit 01 Animation')),
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedContainer(
                margin: const EdgeInsets.all(10),
                width: _size,
                height: _size,
                color: Colors.blue,
                duration: const Duration(seconds: 2),
                curve: Curves.easeInOut,
              ),
              AnimatedContainer(
                margin: const EdgeInsets.all(10),
                width: _size,
                height: _size,
                color: Colors.blue,
                duration: const Duration(seconds: 2),
                curve: Curves.easeIn,
              ),
              AnimatedContainer(
                margin: const EdgeInsets.all(10),
                width: _size,
                height: _size,
                color: Colors.blue,
                duration: const Duration(seconds: 2),
                curve: Curves.easeOut,
              ),
            ],
          ),
          FloatingActionButton(
            onPressed: () {
              setState(() {
                _size = _size == 100.0 ? 200.0 : 100.0;
              });
            },
            child: const Icon(Icons.play_arrow),
          ),
        ]),
      ),
    );
  }
}
/* 
Curves.easeInOut là một đối tượng trong Flutter đại diện cho một đường cong easing. Easing curves được sử dụng để điều chỉnh tốc độ của animation trong suốt quá trình chạy, tạo ra các hiệu ứng chuyển động mượt mà và tự nhiên hơn. Các đường cong easing xác định cách giá trị của animation thay đổi theo thời gian.
Ý nghĩa của Curves.easeInOut
 - Ease In: Tốc độ của animation bắt đầu chậm, sau đó tăng dần.
 - Ease Out: Tốc độ của animation bắt đầu nhanh, sau đó chậm dần.
 - Ease InOut: Kết hợp cả hai, nghĩa là animation bắt đầu chậm, tăng tốc ở giữa và sau đó chậm dần khi kết thúc. */

//
// Example 2 - AnimatedOpacity
class Implicit02 extends StatefulWidget {
  const Implicit02({super.key});

  @override
  State<Implicit02> createState() => _Implicit02State();
}

class _Implicit02State extends State<Implicit02> {
  double _opacity = 1.0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AnimatedOpacity Example'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            AnimatedOpacity(
              opacity: _opacity,
              duration: const Duration(seconds: 1),
              child: Container(
                width: 200,
                height: 200,
                color: Colors.blue,
                child: const Center(
                  child: Text(
                    'Hello',
                    style: TextStyle(color: Colors.white, fontSize: 24),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _opacity = _opacity == 1.0 ? 0.0 : 1.0;
                });
              },
              child: const Text('Toggle Opacity'),
            ),
          ],
        ),
      ),
    );
  }
}
/* 
AnimatedOpacity được sử dụng để xác định độ mờ của widget (giá trị từ 0.0 đến 1.0, trong đó 0.0 là hoàn toàn mờ và 1.0 là không mờ). Khi nút được nhấn, chúng ta thay đổi giá trị của _opacity và sử dụng setState để cập nhật giao diện người dùng và kích hoạt hiệu ứng mờ dần.

 */

// Example 3 - AnimatedAlign
class Implicit03 extends StatefulWidget {
  const Implicit03({super.key});

  @override
  State<Implicit03> createState() => _Implicit03State();
}

class _Implicit03State extends State<Implicit03> {
  bool _selected = false;

  void _toggleSelection() {
    setState(() {
      _selected = !_selected;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AnimatedAlign Demo'),
      ),
      body: Center(
        child: GestureDetector(
          onTap: _toggleSelection,
          child: AnimatedAlign(
            duration: const Duration(seconds: 1),
            alignment: _selected ? Alignment.center : Alignment.topCenter,
            child: Container(
              width: 100.0,
              height: 100.0,
              color: Colors.blue,
              child: const Center(
                child: Text(
                  'Click me!',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
