import 'dart:math';

import 'package:flutter/material.dart';

class MyAppInheritedModel extends StatelessWidget {
  const MyAppInheritedModel({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MyAppInheritedModel Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const MyHomePage(),
    );
  }
}

// Example 1
// Bao bọc phần widget tree cần sử dụng dữ liệu bằng MyInheritedModel
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  String _message = 'Hello, Flutter!';
  final List<String> _randomMessages = [
    'Hello, World!',
    'Flutter is awesome!',
    'You clicked the button!',
    'New random message!',
    'Keep learning Flutter!',
    'Have a great day!',
    'Random message incoming!',
  ];

  // Hàm random chuỗi ngẫu nhiên
  String _getRandomMessage() {
    final random = Random();
    return _randomMessages[random.nextInt(_randomMessages.length)];
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _updateMessage(String newMessage) {
    setState(() {
      _message = _getRandomMessage();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MyInheritedModel(
      counter: _counter,
      message: _message,
      child: Scaffold(
        appBar: AppBar(title: const Text('InheritedModel Demo')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CounterDisplay(),
              const MessageDisplay(),
              ElevatedButton(
                onPressed: _incrementCounter,
                child: const Text('Increment Counter'),
              ),
              ElevatedButton(
                onPressed: () => _updateMessage('New Message!'),
                child: const Text('Update Message'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Tạo một lớp kế thừa từ InheritedModel và định nghĩa các loại dữ liệu bạn muốn chia sẻ
// Khi dữ liệu trong InheritedModel thay đổi, nếu phương thức updateShouldNotifyDependent xác định rằng phần dữ liệu mà widget con quan tâm đã thay đổi, chỉ những widget đó sẽ được rebuild. Điều này giúp tránh việc toàn bộ widget tree bị rebuild không cần thiết.
class MyInheritedModel extends InheritedModel<String> {
  final int counter;
  final String message;

  const MyInheritedModel({
    super.key,
    required this.counter,
    required this.message,
    required super.child,
  });

  @override
  bool updateShouldNotify(MyInheritedModel oldWidget) {
    // Xác định liệu có cần rebuild toàn bộ widget hay không
    return counter != oldWidget.counter || message != oldWidget.message;
  }

  @override
  bool updateShouldNotifyDependent(MyInheritedModel oldWidget, Set<String> dependencies) {
    // Xác định liệu widget con có quan tâm đến dữ liệu nào thay đổi hay không
    if (dependencies.contains('counter') && counter != oldWidget.counter) {
      return true;
    }
    if (dependencies.contains('message') && message != oldWidget.message) {
      return true;
    }
    return false;
  }

  // Hàm tiện ích để các widget con lấy dữ liệu
  static MyInheritedModel? of(BuildContext context, {required String aspect}) {
    return InheritedModel.inheritFrom<MyInheritedModel>(context, aspect: aspect);
  }
}

// Các widget con sẽ sử dụng phương thức of(context, aspect: ...) để lấy dữ liệu từ MyInheritedModel. Tùy thuộc vào tham số aspect được truyền vào, Flutter sẽ chỉ rebuild những widget con phụ thuộc vào dữ liệu tương ứng.
//Widget quan tâm đến counter:
class CounterDisplay extends StatelessWidget {
  const CounterDisplay({super.key});

  @override
  Widget build(BuildContext context) {
    final model = MyInheritedModel.of(context, aspect: 'counter');
    return Text(
      'Counter: ${model?.counter}',
      style: const TextStyle(fontSize: 24),
    );
  }
}

//Widget quan tâm đến message:
class MessageDisplay extends StatelessWidget {
  const MessageDisplay({super.key});

  @override
  Widget build(BuildContext context) {
    final model = MyInheritedModel.of(context, aspect: 'message');
    return Text(
      'Message: ${model?.message}',
      style: const TextStyle(fontSize: 24),
    );
  }
}
