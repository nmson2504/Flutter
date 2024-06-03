import 'dart:async';

import 'package:flutter/material.dart';

class MyLinearProgress extends StatelessWidget {
  const MyLinearProgress({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: LinearProgress03(),
      // backgroundColor: Color.fromARGB(255, 235, 217, 163),
    );
  }
}

// Example 1 - LinearProgressIndicator not status %
class LinearProgress01 extends StatefulWidget {
  const LinearProgress01({super.key});

  @override
  State<StatefulWidget> createState() {
    return LinearProgressIndicatorAppState();
  }
}

class LinearProgressIndicatorAppState extends State<LinearProgress01> {
  bool _loading = false; // flag to switch to loading state

  @override
  void initState() {
    super.initState();
    _loading = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Flutter Linear Progress Bar"),
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(12.0),
          child: _loading
              ? const LinearProgressIndicator()
              : const Text("Press button for downloading",
                  style: TextStyle(fontSize: 25)),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _loading = !_loading;
          });
        },
        tooltip: 'Download',
        child: const Icon(Icons.cloud_download),
      ),
    );
  }
}

// Example 2 -  LinearProgressIndicator with status %

class LinearProgress02 extends StatefulWidget {
  const LinearProgress02({super.key});

  @override
  State<StatefulWidget> createState() {
    return LinearProgressIndicatorAppState2();
  }
}

class LinearProgressIndicatorAppState2 extends State<LinearProgress02> {
  bool _loading = false;
  double _progressValue = 0;

  @override
  void initState() {
    super.initState();
    _loading = false;
    _progressValue = 0.0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Flutter Linear Progress Bar With Progress Value"),
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(12.0),
          child: _loading
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    LinearProgressIndicator(
                      backgroundColor: Colors.cyanAccent,
                      valueColor:
                          const AlwaysStoppedAnimation<Color>(Colors.red),
                      value: _progressValue,
                    ),
                    Text('${(_progressValue * 100).round()}%'),
                  ],
                )
              : const Text("Press button for downloading",
                  style: TextStyle(fontSize: 25)),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _loading = !_loading;
            _updateProgress();
          });
        },
        tooltip: 'Download',
        child: const Icon(Icons.cloud_download),
      ),
    );
  }

  // this function updates the progress value
  void _updateProgress() {
    const oneSec = Duration(milliseconds: 300);
    Timer.periodic(oneSec, (Timer t) {
      // import 'dart:async'
      setState(() {
        _progressValue += 0.1;
        // we "finish" downloading here
        if (_progressValue.toStringAsFixed(1) == '1.0') {
          _loading = false;
          _progressValue = 0;
          t.cancel();
          return;
        }
      });
    });
  }
}

// Example 3 -  click button to stop progress indicator

class LinearProgress03 extends StatefulWidget {
  const LinearProgress03({super.key});

  @override
  State<LinearProgress03> createState() => _LinearProgress03State();
}

class _LinearProgress03State extends State<LinearProgress03> {
  bool _isPaused = false;
  double _progressValue = 0.0;

  /// _updateProgress là một hàm đệ quy (gọi chính nó) để liên tục cập nhật giá trị tiến trình với khoảng thời gian nhất định, và việc này được thực hiện trong một vòng lặp không dừng nếu _isPaused không được đặt là true.

//  const duration = Duration(milliseconds: 500);:
// Đây là một hằng số duration được sử dụng để xác định khoảng thời gian giữa các bước tiến trình.
// Trong ví dụ này, khoảng thời gian là 500 milliseconds (0.5 giây).
// Future.delayed(duration, _updateProgress);:

// Future.delayed được sử dụng để tạo một Future sẽ hoàn thành sau một khoảng thời gian nhất định (duration).
// Sau khi thời gian đó kết thúc, _updateProgress sẽ được gọi lại để cập nhật tiến trình.
// Điều này tạo ra một loạt các bước cập nhật tiến trình với khoảng thời gian nhất định giữa chúng.
  void _updateProgress() {
    const duration = Duration(milliseconds: 500);
    Future.delayed(duration, _updateProgress);
    setState(() {
      if (!_isPaused) {
        _progressValue += 0.2;
        if (_progressValue > 1.0) {
          _progressValue = 0.0;
        }
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _updateProgress();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Progress Indicator Demo'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            LinearProgressIndicator(
              value: _progressValue,
              backgroundColor: const Color.fromARGB(255, 231, 251, 185),
              valueColor: const AlwaysStoppedAnimation<Color>(
                  Color.fromARGB(255, 15, 5, 206)),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _isPaused = !_isPaused;
                });
              },
              child: Text(_isPaused ? 'Resume' : 'Pause'),
            ),
          ],
        ),
      ),
    );
  }
}

// Example 4 -   The progress indicator is animated using an AnimationController, click Switch to stop controller

class LinearProgress04 extends StatefulWidget {
  const LinearProgress04({super.key});

  @override
  State<LinearProgress04> createState() => _ProgressIndicatorExampleState();
}

/// TickerProviderStateMixin is a mixin class in Flutter that provides a vsync (Vertical Synchronization) property to a class. This mixin is commonly used with animation-related classes that require a vsync parameter, such as AnimationController.
///In Flutter, animations are typically synchronized with the device's vertical refresh rate to ensure smooth and visually pleasing animations. The vsync parameter, which stands for vertical synchronization, is used to achieve this synchronization.
class _ProgressIndicatorExampleState extends State<LinearProgress04>
    with TickerProviderStateMixin {
  late AnimationController controller;
  bool determinate = false;

  @override
  void initState() {
    controller = AnimationController(
      /// [AnimationController]s can be created with `vsync: this` because of
      /// [TickerProviderStateMixin].
      vsync: this,
      duration: const Duration(seconds: 2),
    )..addListener(() {
        setState(() {});
      });
    controller.repeat();
    super.initState();
  }

  @override
  //  disposes of the AnimationController.
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Linear progress indicator',
              style: TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 30),
            LinearProgressIndicator(
              value: controller.value,
              semanticsLabel: 'Linear progress indicator',
            ),
            const SizedBox(height: 10),
            Row(
              children: <Widget>[
                Expanded(
                  child: Text(
                    'determinate Mode',
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                ),
                Switch(
                  value: determinate,
                  onChanged: (bool value) {
                    setState(() {
                      determinate = value;
                      if (determinate) {
                        controller.stop();
                      } else {
                        controller
                          ..forward(from: controller.value)
                          ..repeat();
                      }
                    });
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
