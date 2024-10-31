import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// đặt ChangeNotifierProvider trong  Widget build, lúc này ChangeNotifierProvider có child là MaterialApp
class MyAppProvider2 extends StatelessWidget {
  const MyAppProvider2({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ComplexModel(), // update model với các example khác nhau
      child: const MaterialApp(
        home: HomeScreen2(),
      ),
    );
  }
}

class CounterModel extends ChangeNotifier {
  int _counter = 0;

  int get counter => _counter;

  void incrementCounter() {
    _counter++;
    notifyListeners(); // Gọi hàm này để thông báo cho UI về sự thay đổi
  }
}

// Example 1
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final counterModel = Provider.of<CounterModel>(context);
    return Scaffold(
      appBar: AppBar(title: const Text("Provider Counter")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Counter: ${counterModel.counter}'),
            ElevatedButton(
              onPressed: counterModel.incrementCounter,
              child: const Text('Increment'),
            ),
          ],
        ),
      ),
    );
  }
}

// Example 2 -  ba cách tiếp cận khác nhau: Provider.of, Consumer, và Selector
// Model để quản lý trạng thái đếm
class CounterModel1 with ChangeNotifier {
  int _count = 0;

  int get count => _count;

  void increment() {
    _count++;
    notifyListeners(); // Thông báo cho các widget lắng nghe khi giá trị thay đổi
  }

  void decrement() {
    _count--;
    notifyListeners(); // Gọi hàm này để thông báo cho UI về sự thay đổi
  }
}

// Giao diện chính của ứng dụng
class HomeScreen1 extends StatelessWidget {
  const HomeScreen1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Provider 3 cách tiếp cận Example")),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Sử dụng Provider.of
            ProviderOfExample(),
            SizedBox(height: 20), // Khoảng cách giữa các widget
            // Sử dụng Consumer
            ConsumerExample(),
            SizedBox(height: 20),
            // Sử dụng Selector
            SelectorExample(),
          ],
        ),
      ),
    );
  }
}

// Ví dụ sử dụng Provider.of
class ProviderOfExample extends StatelessWidget {
  const ProviderOfExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('Provider.of Example: ${Provider.of<CounterModel1>(context).count}'),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Provider.of<CounterModel1>(context, listen: false).increment();
              },
              child: const Text('Increment'),
            ),
            const SizedBox(width: 10),
            ElevatedButton(
              onPressed: () {
                Provider.of<CounterModel1>(context, listen: false).decrement();
              },
              child: const Text('Decrement'),
            ),
          ],
        ),
      ],
    );
  }
}

// Ví dụ sử dụng Consumer
class ConsumerExample extends StatelessWidget {
  const ConsumerExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Consumer<CounterModel1>(
          builder: (context, counter, child) {
            return Text('Consumer Example: ${counter.count}');
          },
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Provider.of<CounterModel1>(context, listen: false).increment();
              },
              child: const Text('Increment'),
            ),
            const SizedBox(width: 10),
            ElevatedButton(
              onPressed: () {
                Provider.of<CounterModel1>(context, listen: false).decrement();
              },
              child: const Text('Decrement'),
            ),
          ],
        ),
      ],
    );
  }
}

// Ví dụ sử dụng Selector
class SelectorExample extends StatelessWidget {
  const SelectorExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Selector<CounterModel1, int>(
          selector: (context, counter) => counter.count,
          builder: (context, count, child) {
            return Text('Selector Example: $count');
          },
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Provider.of<CounterModel1>(context, listen: false).increment();
              },
              child: const Text('Increment'),
            ),
            const SizedBox(width: 10),
            ElevatedButton(
              onPressed: () {
                Provider.of<CounterModel1>(context, listen: false).decrement();
              },
              child: const Text('Decrement'),
            ),
          ],
        ),
      ],
    );
  }
}

// Example 3
// Model phức tạp hơn với nhiều thuộc tính
class ComplexModel extends ChangeNotifier {
  int _count = 0;
  String _name = "John Doe";
  final List<String> _randomMessages = [
    'HWorld!',
    'Flutter',
    'YouB',
    'NewRan',
    'KeepLean',
    'Have A',
    'Random Mes',
  ];

  // Hàm random chuỗi ngẫu nhiên
  String _getRandomMessage() {
    final random = Random();
    return _randomMessages[random.nextInt(_randomMessages.length)];
  }

  int get count => _count;
  String get name => _name;

  void incrementCount() {
    _count++;
    notifyListeners();
  }

  void changeName(String newName) {
    _name = _getRandomMessage();
    notifyListeners();
  }
}

class HomeScreen2 extends StatelessWidget {
  const HomeScreen2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Consumer vs Selector')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Consumer (rebuilds on any change):'),
          const ConsumerWidget(),
          const SizedBox(height: 20),
          const Text('Selector (rebuilds only on count change):'),
          const SelectorWidget(),
          const SizedBox(height: 20),
          ElevatedButton(
            // tương đương Provider.of<CounterModel1>(context, listen: false).incrementCount();
            onPressed: () => context.read<ComplexModel>().incrementCount(),
            child: const Text('Increment Count'),
          ),
          ElevatedButton(
            // tương đương Provider.of<CounterModel1>(context, listen: false).changeName();
            onPressed: () => context.read<ComplexModel>().changeName('Jane Doe'),
            child: const Text('Change Name'),
          ),
        ],
      ),
    );
  }
}

// Hàm để tạo màu ngẫu nhiên
Color getRandomColor() {
  Random random = Random();
  return Color.fromARGB(
    255,
    random.nextInt(256),
    random.nextInt(256),
    random.nextInt(256),
  );
}

class ConsumerWidget extends StatelessWidget {
  const ConsumerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    print('ConsumerWidget rebuilt');
    Color bgColor = getRandomColor(); // Tạo màu nền ngẫu nhiên
    return Container(
      color: bgColor,
      padding: const EdgeInsets.all(16),
      child: Consumer<ComplexModel>(
        builder: (context, model, child) {
          return Column(
            children: [
              Text('Count: ${model.count}'),
              Text('Name: ${model.name}'),
            ],
          );
        },
      ),
    );
  }
}

class SelectorWidget extends StatelessWidget {
  const SelectorWidget({super.key});

  @override
  Widget build(BuildContext context) {
    print('SelectorWidget rebuilt');
    Color bgColor = getRandomColor(); // Tạo màu nền ngẫu nhiên
    return Container(
      color: bgColor,
      padding: const EdgeInsets.all(16),
      child: Selector<ComplexModel, int>(
        selector: (_, model) => model.count,
        builder: (context, count, child) {
          return Column(
            children: [
              Text('Count: $count'),
              // Sử dụng context.select để truy cập name mà không gây rebuild
              // tương đương  Text('Provider.of Example: ${Provider.of<CounterModel1>(context).name}'),
              Text('Name: ${context.select((ComplexModel model) => model.name)}'),
            ],
          );
        },
      ),
    );
  }
}
