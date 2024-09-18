import 'package:flutter/material.dart';
/* 
Để truyền trạng thái qua các widget trung gian, bạn cần truyền dữ liệu từ widget cha đến widget con thông qua các tham số của constructor. Điều này có nghĩa là mỗi widget trong cây widget, từ nguồn đến nơi cần sử dụng trạng thái, phải nhận và chuyển tiếp dữ liệu đó, ngay cả khi chúng không sử dụng trực tiếp trạng thái đó.
 */
// Widget gốc

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: DemoInherited(),
    );
  }
}

// Demo non inherited - truyền trạng thái qua tham số các constructor
class DemoNonInherited extends StatelessWidget {
  final int counter = 120;

  const DemoNonInherited({super.key});

  @override
  Widget build(BuildContext context) {
    return ParentWidget(counter: counter);
  }
}

// Widget cha
class ParentWidget extends StatelessWidget {
  final int counter;

  const ParentWidget({super.key, required this.counter});

  @override
  Widget build(BuildContext context) {
    return MiddleWidget(counter: counter);
  }
}

// Widget trung gian
class MiddleWidget extends StatelessWidget {
  final int counter;

  const MiddleWidget({super.key, required this.counter});

  @override
  Widget build(BuildContext context) {
    return ChildWidget(counter: counter);
  }
}

// Widget con cần sử dụng trạng thái
class ChildWidget extends StatelessWidget {
  final int counter;

  const ChildWidget({super.key, required this.counter});

  @override
  Widget build(BuildContext context) {
    return Text('Counter value: $counter');
  }
}

//  sử dụng InheritedWidget để quản lý trạng thái giữa các widget
// chỉ widget nào cần sử dụng mới truy cập vào trạng thái của InheritedWidget
class DemoInherited extends StatefulWidget {
  const DemoInherited({super.key});

  @override
  _DemoInheritedState createState() => _DemoInheritedState();
}

class _DemoInheritedState extends State<DemoInherited> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // MyInheritedWidget sẽ chia sẻ trạng thái _counter và phương thức _incrementCounter với các widget con của nó.
    return MyInheritedWidget(
      counter: _counter,
      increment: _incrementCounter,
      child: MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            title: const Text('InheritedWidget Demo'),
          ),
          body: const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CounterText(),
                SizedBox(height: 20),
                IncrementButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// MyInheritedWidget.of(context) để truy cập dữ liệu từ MyInheritedWidget.
// lấy giá trị inheritedWidget?.counter
class CounterText extends StatelessWidget {
  const CounterText({super.key});

  @override
  Widget build(BuildContext context) {
    final inheritedWidget = MyInheritedWidget.of(context);
    return Text(
      'Counter: ${inheritedWidget?.counter ?? 0}',
      style: const TextStyle(fontSize: 24),
    );
  }
}

// MyInheritedWidget.of(context) để truy cập dữ liệu từ MyInheritedWidget.
// gọi method inheritedWidget?.increment
class IncrementButton extends StatelessWidget {
  const IncrementButton({super.key});

  @override
  Widget build(BuildContext context) {
    final inheritedWidget = MyInheritedWidget.of(context);
    return ElevatedButton(
      onPressed: inheritedWidget?.increment as VoidCallback?,
      child: const Text('Increment'),
    );
  }
}

// MyInheritedWidget kế thừa từ InheritedWidget và dùng để chia sẻ trạng thái giữa các widget.
class MyInheritedWidget extends InheritedWidget {
  final int counter;
  final Function increment;

  const MyInheritedWidget({
    Key? key,
    required Widget child,
    required this.counter,
    required this.increment,
  }) : super(key: key, child: child);
// Phương thức of dùng để truy cập MyInheritedWidget từ context.
  static MyInheritedWidget? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<MyInheritedWidget>();
  }

// updateShouldNotify được gọi khi widget cần cập nhật. Nó trả về true nếu giá trị counter thay đổi.
  @override
  bool updateShouldNotify(MyInheritedWidget oldWidget) {
    return counter != oldWidget.counter;
  }
}
