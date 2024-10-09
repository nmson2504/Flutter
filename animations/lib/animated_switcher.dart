import 'package:flutter/material.dart';
import 'package:device_preview/device_preview.dart';
/* 
AnimatedSwitcher:
Đây là widget chính dùng để thay thế một widget với một widget khác, kèm theo hiệu ứng hoạt ảnh chuyển đổi.
Các thuộc tính:
 - Widget cần thay thế được chỉ định thông qua thuộc tính child. Có thể truyền vào child object cứng or element của list
 - duration: Độ dài của hoạt ảnh (thời gian chạy hoạt ảnh). nếu ko set key thì duration se ko tác dụng
 - transitionBuilder: Cho phép tùy chọn hiệu ứng chuyển đổi giữa các widget. Gồm các hiệu ứng sau 
   'FadeTransition'(default), 'ScaleTransition', 'SlideTransition', 'RotationTransition' - phải set key thì transitionBuilder mói có tác dụng
 - key: ValueKey được sử dụng để giúp AnimatedSwitcher nhận biết khi nào widget cần thay đổi. Nếu ko set key thì ko transitionBuilder và duration ko tác dụng(chỉ chuyển đổi mặc định)
 */

class MyDemoAnimations extends StatelessWidget {
  const MyDemoAnimations({super.key});

  @override
  Widget build(BuildContext context) {
    var mapC = {
      1: () => const AnimatedSwitcher01(),
      2: () => const AnimatedSwitcher01A(),
      3: () => const AnimatedSwitcher02(),
      4: () => const AnimatedSwitcher03(),
      5: () => const AnimatedSwitcher04(),
      // 6: () => const BasicHeroAnimation5(),
      // 7: () => const BasicHeroAnimation6(),
      // 8: () => const MyHomePage(title: 'Hero with placeholderBuilder'),
      // 9: () => const HeroPlaceholderDemoApp(),
      // 10: () => const BasicHeroAnimation3(),
    };
    int n = 5; // Giá trị n có thể thay đổi
    // Kiểm tra nếu map chứa key n
    Widget bodyWidget;
    if (mapC.containsKey(n)) {
      bodyWidget = mapC[n]!(); // Gọi hàm trả về Widget
    } else {
      bodyWidget = const Center(child: Text('Không tìm thấy widget'));
    }

    return MaterialApp(
      useInheritedMediaQuery: true,
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
      home: bodyWidget, // Truyền Widget vào body
    );
  }
}

// Demo AnimatedSwitcher
class AnimatedSwitcher01 extends StatefulWidget {
  const AnimatedSwitcher01({super.key});

  @override
  _AnimatedSwitcher01State createState() => _AnimatedSwitcher01State();
}

class _AnimatedSwitcher01State extends State<AnimatedSwitcher01> {
  bool _showImageA = true;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 2000),
            child: _showImageA
                ? Image.asset(
                    'images/avatar1.png',
                    key: const ValueKey('avatar1'),
                    height: 300,
                  )
                : Image.asset(
                    'images/avatar2.png',
                    key: const ValueKey('avatar2'),
                    height: 300,
                  ),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                _showImageA = !_showImageA;
              });
            },
            child: const Text('Toggle Image'),
          )
        ],
      ),
    );
  }
}

// Demo AnimatedSwitcher với transitionBuilder
class AnimatedSwitcher01A extends StatefulWidget {
  const AnimatedSwitcher01A({super.key});

  @override
  _AnimatedSwitcher01AState createState() => _AnimatedSwitcher01AState();
}

class _AnimatedSwitcher01AState extends State<AnimatedSwitcher01A> {
  bool _showImageA = true;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 500),
            transitionBuilder: (Widget child, Animation<double> animation) {
              return ScaleTransition(scale: animation, child: child);
            },
            child: _showImageA
                ? Image.asset(
                    'images/avatar1.png',
                    key: const ValueKey('avatar1'),
                    height: 300,
                  )
                : Image.asset(
                    'images/avatar2.png',
                    key: const ValueKey('avatar2'),
                    height: 300,
                  ),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                _showImageA = !_showImageA;
              });
            },
            child: const Text('Toggle Image'),
          )
        ],
      ),
    );
  }
}

// Thay đổi hiệu ứng chuyển tiếp counter với AnimatedSwitcher.transitionBuilder

class AnimatedSwitcher02 extends StatefulWidget {
  const AnimatedSwitcher02({super.key});

  @override
  State<AnimatedSwitcher02> createState() => _AnimatedSwitcher02State();
}

class _AnimatedSwitcher02State extends State<AnimatedSwitcher02> {
  int _counter = 0;
  int _currentTransition = 0;

  // List of transition options
  final List<String> _transitionOptions = [
    'FadeTransition',
    'ScaleTransition',
    'SlideTransition',
    'RotationTransition'
  ];

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  // Function to switch between different transition effects
  AnimatedSwitcherTransitionBuilder _getTransitionBuilder() {
    switch (_currentTransition) {
      case 0: // FadeTransition
        return (Widget child, Animation<double> animation) {
          return FadeTransition(opacity: animation, child: child);
        };
      case 1: // ScaleTransition
        return (Widget child, Animation<double> animation) {
          return ScaleTransition(scale: animation, child: child);
        };
      case 2: // SlideTransition
        return (Widget child, Animation<double> animation) {
          return SlideTransition(
            position: Tween<Offset>(begin: const Offset(1, 0), end: Offset.zero).animate(animation),
            child: child,
          );
        };
      case 3: // RotationTransition
        return (Widget child, Animation<double> animation) {
          return RotationTransition(turns: animation, child: child);
        };
      default:
        return (Widget child, Animation<double> animation) {
          return FadeTransition(opacity: animation, child: child);
        };
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AnimatedSwitcher02 Transitions Demo'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('You have pushed the button this many times:'),
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 500),
              transitionBuilder: _getTransitionBuilder(), // default is FadeTransition
              child: Text(
                '$_counter',
                // Key rất quan trọng để AnimatedSwitcher có thể xác định được rằng các widget đang thay đổi và cần thực hiện chuyển tiếp
                key: ValueKey<int>(_counter), // Unique key for each new widget
                style: const TextStyle(fontSize: 40),
              ),
            ),
            const SizedBox(height: 20),
            Text('Current Transition: ${_transitionOptions[_currentTransition]}'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  // Switch between transition effects
                  _currentTransition =
                      (_currentTransition + 1) % _transitionOptions.length; // giới hạn values from 0 to 3
                });
              },
              child: const Text('Change Transition Effect'),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}

// Thay đổi hiệu ứng chuyển tiếp 2 image với AnimatedSwitcher.transitionBuilder

class AnimatedSwitcher03 extends StatefulWidget {
  const AnimatedSwitcher03({super.key});

  @override
  State<AnimatedSwitcher03> createState() => _AnimatedSwitcher03State();
}

class _AnimatedSwitcher03State extends State<AnimatedSwitcher03> {
  int _currentTransition = 0;
  bool _showImageA = true;
  // List of transition options
  final List<String> _transitionOptions = [
    'FadeTransition',
    'ScaleTransition',
    'SlideTransition',
    'RotationTransition'
  ];

  // Function to switch between different transition effects
  AnimatedSwitcherTransitionBuilder _getTransitionBuilder() {
    switch (_currentTransition) {
      case 0: // FadeTransition
        return (Widget child, Animation<double> animation) {
          return FadeTransition(opacity: animation, child: child);
        };
      case 1: // ScaleTransition
        return (Widget child, Animation<double> animation) {
          return ScaleTransition(scale: animation, child: child);
        };
      case 2: // SlideTransition
        return (Widget child, Animation<double> animation) {
          return SlideTransition(
            position: Tween<Offset>(begin: const Offset(1, 0), end: Offset.zero).animate(animation),
            child: child,
          );
        };
      case 3: // RotationTransition
        return (Widget child, Animation<double> animation) {
          return RotationTransition(turns: animation, child: child);
        };
      default:
        return (Widget child, Animation<double> animation) {
          return FadeTransition(opacity: animation, child: child);
        };
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('AnimatedSwitcher03 Transitions Demo'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text('You have pushed the button this many times:'),
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 500),
                transitionBuilder: _getTransitionBuilder(), // default is FadeTransition
                child: _showImageA
                    ? Image.asset(
                        'images/avatar1.png',
                        // Key rất quan trọng để AnimatedSwitcher có thể xác định được rằng các widget đang thay đổi và cần thực hiện chuyển tiếp.
                        key: const ValueKey('avatar1'),
                        height: 300,
                      )
                    : Image.asset(
                        'images/avatar2.png',
                        key: const ValueKey('avatar2'),
                        height: 300,
                      ),
              ),
              const SizedBox(height: 20),
              Text('Current Transition: ${_transitionOptions[_currentTransition]}'),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    // Switch between transition effects
                    _currentTransition =
                        (_currentTransition + 1) % _transitionOptions.length; // giới hạn values from 0 to 3
                  });
                },
                child: const Text('Change Transition Effect'),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            setState(() {
              _showImageA = !_showImageA;
            });
          },
          child: const Text('Toggle Image'),
        ));
  }
}
// Thay đổi hiệu ứng chuyển tiếp nhiều images với AnimatedSwitcher.transitionBuilder

class AnimatedSwitcher04 extends StatefulWidget {
  const AnimatedSwitcher04({super.key});

  @override
  State<AnimatedSwitcher04> createState() => _AnimatedSwitcher04State();
}

class _AnimatedSwitcher04State extends State<AnimatedSwitcher04> {
  int _currentTransition = 0;
  int _currentImage = 0;
  // List of transition options
  final List<String> _transitionOptions = [
    'FadeTransition',
    'ScaleTransition',
    'SlideTransition',
    'RotationTransition'
  ];

  // List of images
  final List<String> _imageOptions = ['avatar1.png', 'avatar2.png', 'avatar3.png'];

  // Function to switch between different transition effects
  AnimatedSwitcherTransitionBuilder _getTransitionBuilder() {
    switch (_currentTransition) {
      case 0: // FadeTransition
        return (Widget child, Animation<double> animation) {
          // widget là hình ảnh (Image.asset) từ danh sách _imageOptions.
          return FadeTransition(
              opacity: animation,
              child: child); // child chính là widget(hình ảnh) mà AnimatedSwitcher đang chuyển tiếp.
        };
      case 1: // ScaleTransition
        return (Widget child, Animation<double> animation) {
          return ScaleTransition(scale: animation, child: child);
        };
      case 2: // SlideTransition
        return (Widget child, Animation<double> animation) {
          return SlideTransition(
            position: Tween<Offset>(begin: const Offset(1, 0), end: Offset.zero).animate(animation),
            child: child,
          );
        };
      case 3: // RotationTransition
        return (Widget child, Animation<double> animation) {
          return RotationTransition(turns: animation, child: child);
        };
      default:
        return (Widget child, Animation<double> animation) {
          return FadeTransition(opacity: animation, child: child);
        };
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('AnimatedSwitcher04 Transitions Demo'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text('You have pushed the button this many times:'),
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 500),
                transitionBuilder:
                    _getTransitionBuilder(), // default is FadeTransition. Khi _currentTransition thay đổi thì _getTransitionBuilder() được gọi lại
                child: Image.asset(
                  'images/${_imageOptions[_currentImage]}',
                  key: ValueKey(_currentImage),
                  height: 300,
                ),
              ),
              const SizedBox(height: 20),
              Text('Current Transition: ${_transitionOptions[_currentTransition]}'),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    // Switch between transition effects
                    _currentTransition =
                        (_currentTransition + 1) % _transitionOptions.length; // giới hạn values from 0 to 3
                  });
                },
                child: const Text('Change Transition Effect'),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            setState(() {
              _currentImage = (_currentImage + 1) % _imageOptions.length;
              ;
            });
          },
          child: const Text('Switch Image'),
        ));
  }
}
//