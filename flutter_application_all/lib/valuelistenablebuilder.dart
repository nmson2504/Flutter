import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';

class MyValueListenableBuilder extends StatelessWidget {
  const MyValueListenableBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Flutter ValueListenableBuilder')),
        body: const ValueListenableBuilder05(),
        // backgroundColor: Color.fromARGB(255, 235, 217, 163),
      ),
    );
  }
}

// const constructor với StatelessWidget
/* 
Để sử dụng hàm tạo const cho ValueListenableBuilder01, lớp cần phải hoàn toàn bất biến, nghĩa là tất cả các thuộc tính và hành động của nó (bao gồm cả bộ đếm thời gian) phải được xử lý bên ngoài hàm tạo(fully immutable, meaning all its properties and actions (including the timer) must be handled outside of the constructor.). Vì Bộ hẹn giờ giới thiệu khả năng thay đổi, nên bạn sẽ cần di chuyển logic đếm ngược ra bên ngoài hàm tạo và khởi tạo nó theo cách không ảnh hưởng đến tính bất biến của lớp(not affect the immutability of the class.).
Và nếu tạo const constructor với StatelessWidget thì phải gọi: ValueListenableBuilder01.startCountdown(); tại hàm main()
 */
/* 
 ValueListenableBuilder theo dõi ValueNotifier và cập nhật giao diện khi ValueNotifier.value thay đổi.
Khởi Tạo: ValueNotifier là một lớp trong Flutter giúp bạn quản lý và theo dõi sự thay đổi của một giá trị. Khi giá trị của ValueNotifier thay đổi, tất cả các widget hoặc listener đăng ký sẽ được thông báo và cập nhật giao diện.
Cập Nhật Giá Trị: Bạn có thể cập nhật giá trị của ValueNotifier thông qua thuộc tính value. Mọi thay đổi giá trị sẽ kích hoạt các listener đã đăng ký với ValueNotifier.
Khi ValueListenableBuilder nhận được giá trị mới từ remainingSeconds, nó sẽ builder lại với value mới.
 */
class ValueListenableBuilder01 extends StatelessWidget {
  static final ValueNotifier<int> remainingSeconds = ValueNotifier(60);

  const ValueListenableBuilder01({super.key});

  static void startCountdown() {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (remainingSeconds.value > 0) {
        remainingSeconds.value--;
      } else {
        timer.cancel();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: remainingSeconds,
      builder: (context, value, child) {
        return Text('Còn lại: $value giây');
      },
    );
  }
}

class ValueListenableBuilder011 extends StatelessWidget {
  static ValueNotifier<int> remainingSeconds = ValueNotifier(60);

  const ValueListenableBuilder011({super.key});

  static void startCountdown() {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (remainingSeconds.value > 0) {
        remainingSeconds.value--;
      } else {
        timer.cancel();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: remainingSeconds,
      builder: (context, value, child) {
        return Text('Còn lại: $value giây');
      },
    );
  }
}

///////////////////////
// with StatelessWidget constructor non const
class ValueListenableBuilder01a extends StatelessWidget {
  static ValueNotifier<int> remainingSeconds = ValueNotifier(60);

  ValueListenableBuilder01a({super.key}) {
    // Start the countdown timer
    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (remainingSeconds.value > 0) {
        remainingSeconds.value--;
      } else {
        timer.cancel();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: remainingSeconds,
      builder: (context, value, child) {
        return Text('ValueListenableBuilder01a - Còn lại: $value giây');
      },
    );
  }
}

// with StatefulWidget
class ValueListenableBuilder02 extends StatefulWidget {
  const ValueListenableBuilder02({super.key});

  @override
  State<ValueListenableBuilder02> createState() =>
      _ValueListenableBuilder02State();
}

class _ValueListenableBuilder02State extends State<ValueListenableBuilder02> {
  final ValueNotifier<int> remainingSeconds = ValueNotifier(60);

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
    Future.delayed(const Duration(seconds: 1), () {
      if (remainingSeconds.value > 0) {
        remainingSeconds.value--;
        startTimer();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Countdown Timer'),
      ),
      body: Center(
        child: ValueListenableBuilder<int>(
          valueListenable: remainingSeconds,
          builder: (context, value, child) {
            return Text(
              'Còn lại: $value giây',
              style: const TextStyle(fontSize: 24),
            );
          },
        ),
      ),
    );
  }
}

// quản lý trạng thái của form
class ValueListenableBuilder03 extends StatefulWidget {
  const ValueListenableBuilder03({super.key});

  @override
  State<ValueListenableBuilder03> createState() =>
      _ValueListenableBuilder03State();
}

class _ValueListenableBuilder03State extends State<ValueListenableBuilder03> {
  final ValueNotifier<bool> isSubmitted = ValueNotifier(false);

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  void _submitForm() {
    // Validate form data here
    if (_nameController.text.isNotEmpty && _emailController.text.isNotEmpty) {
      // Submit form data
      isSubmitted.value = true;
    } else {
      // Show error messages
      // ...
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Form'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Name',
              ),
            ),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
              ),
            ),
            ElevatedButton(
              onPressed: _submitForm,
              child: const Text('Submit'),
            ),
            ValueListenableBuilder<bool>(
              valueListenable: isSubmitted,
              builder: (context, value, child) {
                return Text(
                  value
                      ? 'Form has been submitted'
                      : 'Form has not been submitted',
                  style: const TextStyle(fontSize: 18),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

// with StatelessWidget constructor non const
class ValueListenableBuilder04 extends StatelessWidget {
  final ValueNotifier<Color> _colorNotifier = ValueNotifier(Colors.blue);

  ValueListenableBuilder04({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ValueListenableBuilder Change Color'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Sử dụng ValueListenableBuilder để lắng nghe sự thay đổi giá trị của _colorNotifier
            ValueListenableBuilder<Color>(
              valueListenable: _colorNotifier,
              builder: (context, color, child) {
                return Container(
                  width: 100,
                  height: 100,
                  color: color, // Màu sắc thay đổi khi _colorNotifier thay đổi
                );
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Thay đổi giá trị của _colorNotifier khi nhấn nút
                _colorNotifier.value =
                    Color((Random().nextDouble() * 0xFFFFFF).toInt())
                        .withOpacity(1.0);
              },
              child: const Text('Change Color'),
            ),
          ],
        ),
      ),
    );
  }
}

// with StatefulWidget
class ValueListenableBuilder04b extends StatefulWidget {
  const ValueListenableBuilder04b({super.key});

  @override
  _ValueListenableBuilder04bState createState() =>
      _ValueListenableBuilder04bState();
}

class _ValueListenableBuilder04bState extends State<ValueListenableBuilder04b> {
  // Khởi tạo ValueNotifier với màu sắc ban đầu là màu xanh dương
  final ValueNotifier<Color> _colorNotifier = ValueNotifier(Colors.blue);

  @override
  void dispose() {
    // Giải phóng _colorNotifier khi không còn sử dụng
    _colorNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('StatefulWidget with ValueListenableBuilder'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Sử dụng ValueListenableBuilder để lắng nghe sự thay đổi giá trị của _colorNotifier
            ValueListenableBuilder<Color>(
              valueListenable: _colorNotifier,
              builder: (context, color, child) {
                return Container(
                  width: 100,
                  height: 100,
                  color: color, // Màu sắc thay đổi khi _colorNotifier thay đổi
                );
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Thay đổi giá trị của _colorNotifier khi nhấn nút
                _colorNotifier.value =
                    Color((Random().nextDouble() * 0xFFFFFF).toInt())
                        .withOpacity(1.0);
              },
              child: const Text('Change Color'),
            ),
          ],
        ),
      ),
    );
  }
}

//

class ValueListenableBuilder05 extends StatefulWidget {
  const ValueListenableBuilder05({super.key});

  @override
  State<ValueListenableBuilder05> createState() =>
      _ValueListenableBuilder05State();
}

class _ValueListenableBuilder05State extends State<ValueListenableBuilder05> {
  final ValueNotifier<int> _counter = ValueNotifier<int>(0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ValueListenableBuilder Sample'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('You have pushed the button this many times:'),
            ValueListenableBuilder<int>(
              builder: (BuildContext context, int value, Widget? child) {
                // This builder will only get called when the _counter
                // is updated.
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    CountDisplay(count: value),
                    child!,
                  ],
                );
              },
              valueListenable: _counter,
              // The child parameter is most helpful if the child is
              // expensive to build and does not depend on the value from
              // the notifier.
              child: const Padding(
                padding: EdgeInsets.all(10.0),
                child: SizedBox(
                  width: 40,
                  height: 40,
                  child: FlutterLogo(size: 40),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.plus_one),
        onPressed: () => _counter.value += 1,
      ),
    );
  }
}

class CountDisplay extends StatelessWidget {
  const CountDisplay({super.key, required this.count});

  final int count;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      padding: const EdgeInsetsDirectional.all(10),
      child: Text('$count', style: Theme.of(context).textTheme.headlineMedium),
    );
  }
}
