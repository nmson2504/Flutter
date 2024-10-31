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
      home: MyHomePage2(
        isLoading: false,
        counter: 0,
        child: MyCenterWidget(),
      ),
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
    super.key,
    required super.child,
    required this.counter,
    required this.increment,
  });
// Phương thức of dùng để truy cập MyInheritedWidget từ context.
  static MyInheritedWidget? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<MyInheritedWidget>();
  }

// updateShouldNotify return false - ko update các widget con, return true - update các widget con khi có thay đổi
// Ơ đây Nó trả về true nếu giá trị counter thay đổi.
/* oldWidget: Đây là một phiên bản của MyInheritedWidget mà widget hiện tại đã thay thế. Nó chứa trạng thái và dữ liệu cũ trước khi widget được cập nhật. */
  @override
  bool updateShouldNotify(MyInheritedWidget oldWidget) {
    return counter !=
        oldWidget
            .counter; // return true khi oldWidget.counter thay đổi -> thông báo cho các widget thừa kế có liên quan build lại
  }
}

// Demo giải thích chi tiết cơ chế hoạt động của InheritedWidget
// https://viblo.asia/p/hoc-flutter-tu-co-ban-den-nang-cao-phan-4-lot-tran-inheritedwidget-3P0lPDbmlox
// call MyHomePage(isLoading: false, counter: 0),
class MyHomePage extends StatefulWidget {
  final bool isLoading;
  final int counter;

  const MyHomePage({
    super.key,
    required this.isLoading,
    required this.counter,
  });

  @override
  State<MyHomePage> createState() {
    return MyHomePageState();
  }
}

class MyHomePageState extends State<MyHomePage> {
  late bool _isLoading;
  late int _counter;

  @override
  void initState() {
    super.initState();
    _isLoading = widget.isLoading;
    _counter = widget.counter;
  }

  @override
  Widget build(BuildContext context) {
    print('rebuild MyHomePage');
    return Scaffold(
      appBar: AppBar(
        title: const Text('MyInheritedWidgetDM Demo'),
      ),
      body: MyInheritedWidgetDM(
        isLoading: _isLoading,
        counter: _counter,
        child: const MyCenterWidget(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: onFloatingButtonClicked,
      ),
    );
  }

  void onFloatingButtonClicked() {
    // print('Button clicked!. Call setState method');
    setState(() {
      _counter++;
      if (_counter % 2 == 0) {
        _isLoading = false;
      } else {
        _isLoading = true;
      }
    });
  }
}

class CounterWidget extends StatelessWidget {
  const CounterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    print('rebuild CounterWidget');
    final myInheritedWidget = MyInheritedWidgetDM.of(context);

    if (myInheritedWidget == null) {
      return const Text('MyInheritedWidget was not found');
    }

    return myInheritedWidget.isLoading ? const CircularProgressIndicator() : Text('${myInheritedWidget.counter}');
  }
}

class MyCenterWidget extends StatelessWidget {
  const MyCenterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    /* 
    MyCenterWidget ko gọi MyInheritedWidgetDM.of(context); - ko lệ thuộc MyInheritedWidgetDM nên sẽ ko rebuild khi MyInheritedWidgetDM thay đổi(giải thích tại https://viblo.asia/p/hoc-flutter-tu-co-ban-den-nang-cao-phan-4-lot-tran-inheritedwidget-3P0lPDbmlox nhầm chỗ này)
     */
    print('rebuild MyCenterWidget');
    return const Center(
      child: CounterWidget(),
    );
  }
}

class MyInheritedWidgetDM extends InheritedWidget {
  final int counter;
  final bool isLoading;
  final Widget child;

  const MyInheritedWidgetDM({
    super.key,
    required this.isLoading,
    required this.counter,
    required this.child,
  }) : super(child: child);

  @override
  bool updateShouldNotify(MyInheritedWidgetDM oldWidget) {
    return isLoading != oldWidget.isLoading || counter != oldWidget.counter;
  }

  static MyInheritedWidgetDM? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<MyInheritedWidgetDM>();
  }
}

//
// call  MyHomePage(isLoading: false,counter: 0, child: MyCenterWidget(),),
class MyHomePage2 extends StatefulWidget {
  final bool isLoading;
  final int counter;
  final Widget child;

  const MyHomePage2({
    super.key,
    required this.isLoading,
    required this.counter,
    required this.child,
  });

  @override
  State<MyHomePage2> createState() {
    return MyHomePage2State();
  }
}

class MyHomePage2State extends State<MyHomePage2> {
  late bool _isLoading;
  late int _counter;

  @override
  void initState() {
    super.initState();
    _isLoading = widget.isLoading; //  Truy cập thuộc tính isLoading của widget cha (MyHomePage2).
    _counter = widget.counter;
  }

  @override
  Widget build(BuildContext context) {
    print('rebuild MyHomePage');
    return Scaffold(
      body: MyInheritedWidgetDM(
        isLoading: _isLoading,
        counter: _counter,
        child: widget
            .child, //  Truy cập thuộc tính child của widget cha (MyHomePage2) - là tham số MyCenterWidget khi call MyHomePage2
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: onFloatingButtonClicked,
      ),
    );
  }

  void onFloatingButtonClicked() {
    // print('Button clicked!. Call setState method');
    setState(() {
      _counter++;
      if (_counter % 2 == 0) {
        _isLoading = false;
      } else {
        _isLoading = true;
      }
    });
  }
}
