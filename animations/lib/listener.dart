/* 
1.	Value Change Notifications: addListener()
 */
import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';

class AddListener01 extends StatefulWidget {
  const AddListener01({super.key});

  @override
  _AddListener01State createState() => _AddListener01State();
}

class _AddListener01State extends State<AddListener01>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    _animation = Tween<double>(begin: 0.0, end: 200.0).animate(_controller);

    // Add listener to update the widget on animation changes
    // // Gọi setState để cập nhật UI mỗi khi giá trị của animation thay đổi
    _animation.addListener(() {
      setState(() {});
    });
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
        title: const Text('Animated Container Demo'),
      ),
      body: Center(
        child: AnimatedBuilder(
          animation: _animation,
          builder: (context, child) => Container(
            width: _animation.value,
            height: 100.0,
            color: Colors.blue,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (_controller.isAnimating) {
            // kiểm tra xem animation có đang chạy hay không.
            _controller.stop();
          } else {
            _controller.forward();
          }
        },
        child: Icon(_controller.isAnimating ? Icons.pause : Icons.play_arrow),
      ),
    );
  }
}

// example 2

class AddListener02 extends StatefulWidget {
  const AddListener02({super.key});

  @override
  _AddListener02State createState() => _AddListener02State();
}

class _AddListener02State extends State<AddListener02>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _sizeAnimation;
  late Animation<Color?> _colorAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

/* 
  ..addListener(() - "cascade notation" hoặc "cascade operator". Đây là một cách gọi nhiều phương thức trên cùng một đối tượng mà không cần phải lặp lại tên của đối tượng đó.
 */
    _sizeAnimation = Tween<double>(begin: 0.0, end: 200.0).animate(_controller)
      ..addListener(() {
        setState(() {});
      });

    _colorAnimation =
        ColorTween(begin: Colors.blue, end: Colors.red).animate(_controller)
          ..addListener(() {
            setState(() {});
          });

    // _controller.forward();
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
        title: const Text('AddListener with ColorTween Example'),
      ),
      body: Center(
        child: Container(
          width: _sizeAnimation.value,
          height: _sizeAnimation.value,
          color: _colorAnimation.value,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (_controller.isAnimating) {
            _controller.stop();
          } else {
            _controller.forward();
          }
        },
        child: Icon(
          _controller.isAnimating ? Icons.pause : Icons.play_arrow,
        ),
      ),
    );
  }
}

/* 
2.	Status Change Notifications: addStatusListener()
 */

class AddStatusListener01 extends StatefulWidget {
  const AddStatusListener01({super.key});

  @override
  _AddStatusListener01State createState() => _AddStatusListener01State();
}

class _AddStatusListener01State extends State<AddStatusListener01>
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

    _animation = Tween<double>(begin: 0.0, end: 200.0).animate(_controller);

    // Add status listener to handle changes in animation state
    _animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        // Animation has completed, you can restart or reverse the animation
        _controller.reverse();
      } else if (status == AnimationStatus.dismissed) {
        // Animation has been dismissed, you can restart the animation
        _controller.forward();
      }
    });

    _controller.forward(); // Start the animation
  }

  @override
  void dispose() {
    _controller.dispose(); // Dispose of the AnimationController
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AddStatusListener Animation Example'),
      ),
      body: Center(
        child: AnimatedBuilder(
          animation: _animation,
          builder: (context, child) => Container(
            width: _animation.value,
            height: _animation.value,
            color: Colors.blue,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (_controller.isAnimating) {
            _controller.stop(); // Stop the animation if it is running
          } else {
            _controller
                .forward(); // Start or continue the animation if it is not running
          }
        },
        child: Icon(
          _controller.isAnimating ? Icons.pause : Icons.play_arrow,
        ),
      ),
    );
  }
}
/* 
Trong Flutter, AnimationStatus là một enum để chỉ trạng thái của animation. Nó có bốn giá trị chính mà bạn có thể gán và kiểm tra:

1 - AnimationStatus.dismissed:
Trạng thái này cho biết animation đang ở vị trí bắt đầu (giá trị ban đầu).
2 - AnimationStatus.forward:
Trạng thái này cho biết animation đang chạy về phía trước, từ giá trị ban đầu đến giá trị kết thúc.
3 - AnimationStatus.completed:
Trạng thái này cho biết animation đã hoàn thành, tức là đã đạt đến giá trị kết thúc.
4 - AnimationStatus.reverse:
Trạng thái này cho biết animation đang chạy ngược lại, từ giá trị kết thúc về giá trị ban đầu.

Các method hành động với animation
_controller.forward - status is forward
_controller.stop - status ko thay đổi(đang là forward thì vẫn là forward)
_controller.reverse - status is reverse. Nếu reverse hoàn thành status is dismissed
_controller.reset - status is dismissed
Lưu ý: nên disable button stop khi animation status đang completed or dismissed để tránh click stop gây lỗi dispose 2 lần


Kiểm tra status animation
_controller.isAnimating || _controller.isCompleted || _controller.isDismissed 
 */
// example 2

class AddStatusListener02 extends StatefulWidget {
  const AddStatusListener02({super.key});

  @override
  _AddStatusListener02State createState() => _AddStatusListener02State();
}

class _AddStatusListener02State extends State<AddStatusListener02>
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

    _animation = Tween<double>(begin: 0.0, end: 200.0).animate(_controller);

    // Add status listener to handle changes in animation state
    _animation.addStatusListener((status) {
      setState(() {}); // Update UI on status change

      if (status == AnimationStatus.forward) {
        print("Animation is moving forward.");
      } else if (status == AnimationStatus.completed) {
        print("Animation has completed.");
        // _controller.reverse();
      } else if (status == AnimationStatus.reverse) {
        print("Animation is reversing.");
      } else if (status == AnimationStatus.dismissed) {
        print("Animation has been dismissed.");

        /*
        trạng thái completed = true khi .forward hoàn thành 
        trạng thái dismissed = true khi .reversing hoàn thành, hoặc gọi .reset 
        
         */
      }
    });
    _controller.forward(); // Start the animation
  }

  @override
  void dispose() {
    _controller.dispose(); // Dispose of the AnimationController
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AddStatusListener Animation Example 2'),
      ),
      body: Center(
        child: AnimatedBuilder(
          animation: _animation,
          builder: (context, child) => Container(
            width: _animation.value,
            height: _animation.value,
            color: Colors.blue,
          ),
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            FloatingActionButton(
              onPressed: () {
                if (_controller.isAnimating || _controller.isCompleted) {
                  _controller.forward(from: 0.0); // Bắt đầu lại animation
                } else {
                  _controller
                      .forward(); // Tiếp tục animation nếu nó đang dừng lại
                }
              },
              child: const Icon(Icons.play_arrow),
            ),
            FloatingActionButton(
              onPressed: _controller.isAnimating
                  ? () {
                      _controller.stop(); // Stop the animation
                    }
                  : null, // Disable if animation is dismissed
              backgroundColor: _controller.isAnimating
                  ? null
                  : Colors.grey, // Change color when disabled
              child: const Icon(Icons.stop),
            ),
            FloatingActionButton(
              onPressed: () {
                _controller.reverse(); // Reverse the animation
              },
              child: const Icon(Icons.replay),
            ),
            FloatingActionButton(
              onPressed: () {
                _controller.reset(); // Reset the animation
              },
              child: const Icon(Icons.refresh),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

// Kết hợp addListener & addStatusListener

class AnimationNotificationsMix extends StatefulWidget {
  const AnimationNotificationsMix({super.key});

  @override
  _AnimationNotificationsMixState createState() =>
      _AnimationNotificationsMixState();
}

class _AnimationNotificationsMixState extends State<AnimationNotificationsMix>
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

    _animation = Tween<double>(begin: 0, end: 200).animate(_controller)
      ..addListener(() {
        // Gọi setState để cập nhật UI mỗi khi giá trị của animation thay đổi
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          // Animation đã hoàn thành
          print("Animation completed");
        } else if (status == AnimationStatus.dismissed) {
          // Animation đã bị hủy
          print("Animation dismissed");
        }
      });

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
      appBar: AppBar(title: const Text('Animation Notifications Example')),
      body: Center(
        child: Container(
          width: _animation.value,
          height: _animation.value,
          color: Colors.blue,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (_controller.isAnimating) {
            _controller.dispose(); // Stop the animation if it is running
          } else {
            _controller
                .forward(); // Start or continue the animation if it is not running
          }
        },
        child: Icon(
          _controller.isAnimating ? Icons.pause : Icons.play_arrow,
        ),
      ),
    );
  }
}
