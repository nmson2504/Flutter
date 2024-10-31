import 'package:flutter/material.dart';
import 'dart:math';
import 'package:provider/provider.dart';

// Example 1 - Provider.of, Consumer, và Selector
// Model để quản lý trạng thái của ba đối tượng
// Provider.of mặc định listen = true -  luôn rebuild khi có thay đổi trong mode
// Consumer - chỉ những widget nằm bên trong builder của Consumer mới được tái xây dựng khi có thay đổi
// Selector - chỉ rebuild trong builder với những thay đổi trong selector
class Counter with ChangeNotifier {
  int _a = 0;
  int _b = 0;
  int _c = 0;

  int get a => _a;
  int get b => _b;
  int get c => _c;

  void incrementA() {
    _a++;
    notifyListeners(); // Thông báo cho các widget lắng nghe
  }

  void incrementB() {
    _b++;
    notifyListeners(); // Gọi hàm này để thông báo cho UI về sự thay đổi
  }

  void incrementC() {
    _c++;
    notifyListeners();
  }
}

// Widget chính của ứng dụng
/* runApp(
    ChangeNotifierProvider(
      create: (context) => Counter(),
      child: MyApp01(),
    ),
  ); */
/*  cũng có thể đặt ChangeNotifierProvider trong  Widget build, lúc này ChangeNotifierProvider có child là MaterialApp */
class MyApp01 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Provider Complex Example',
      home: HomeScreen(),
    );
  }
}

// Giao diện chính của ứng dụng
class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Provider Complex Example")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Sử dụng Provider.of
            ProviderOfExample(),
            const SizedBox(height: 20), // Khoảng cách giữa các widget
            // Sử dụng Consumer
            ConsumerExample(),
            const SizedBox(height: 20),
            // Sử dụng Selector
            SelectorExample(),
          ],
        ),
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

// Ví dụ sử dụng Provider.of
class ProviderOfExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    debugPrint('ProviderOfExample rebuilt');

    Color bgColor = getRandomColor(); // Tạo màu nền ngẫu nhiên
    return Container(
      color: bgColor,
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Text(
              'Provider.of Example: a=${Provider.of<Counter>(context).a}, b=${Provider.of<Counter>(context).b}, c=${Provider.of<Counter>(context).c}'),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  Provider.of<Counter>(context, listen: false).incrementA();
                },
                child: const Text('Increment A'),
              ),
              const SizedBox(width: 10),
              ElevatedButton(
                onPressed: () {
                  Provider.of<Counter>(context, listen: false).incrementB();
                },
                child: const Text('Increment B'),
              ),
              const SizedBox(width: 10),
              ElevatedButton(
                onPressed: () {
                  Provider.of<Counter>(context, listen: false).incrementC();
                },
                child: const Text('Increment C'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// Ví dụ sử dụng Consumer
class ConsumerExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    debugPrint('ConsumerExample rebuilt');
    Color bgColor = getRandomColor(); // Tạo màu nền ngẫu nhiên
    return Container(
      color: bgColor,
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Consumer<Counter>(
            builder: (context, counter, child) {
              return Text('Consumer Example: a=${counter.a}'); // chỉ rebuild trong này
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  Provider.of<Counter>(context, listen: false).incrementA();
                },
                child: const Text('Increment A'),
              ),
              const SizedBox(width: 10),
              ElevatedButton(
                onPressed: () {
                  Provider.of<Counter>(context, listen: false).incrementB();
                },
                child: const Text('Increment B'),
              ),
              const SizedBox(width: 10),
              ElevatedButton(
                onPressed: () {
                  Provider.of<Counter>(context, listen: false).incrementC();
                },
                child: const Text('Increment C'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// Ví dụ sử dụng Selector
class SelectorExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    debugPrint('SelectorExample rebuilt');

    return Column(
      children: [
        Container(
          color: getRandomColor(), // Tạo màu nền ngẫu nhiên
          padding: const EdgeInsets.all(16),
          child: Selector<Counter, int>(
            selector: (context, counter) => counter.a,
            // chỉ rebuild trong này theo selector ở trên
            builder: (context, a, child) {
              return Text('Selector Example: a=$a');
            },
          ),
        ),
        Container(
          color: getRandomColor(), // Tạo màu nền ngẫu nhiên
          padding: const EdgeInsets.all(16),
          child: Selector<Counter, int>(
            selector: (context, counter) => counter.b,
            // chỉ rebuild trong này theo selector ở trên
            builder: (context, b, child) {
              return Text('Selector Example: b=$b');
            },
          ),
        ),
        Container(
          color: getRandomColor(), // Tạo màu nền ngẫu nhiên
          padding: const EdgeInsets.all(16),
          child: Selector<Counter, int>(
            selector: (context, counter) => counter.c,
            // chỉ rebuild trong này theo selector ở trên
            builder: (context, c, child) {
              return Text('Selector Example: c=$c');
            },
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Provider.of<Counter>(context, listen: false).incrementA();
              },
              child: const Text('Increment A'),
            ),
            const SizedBox(width: 10),
            ElevatedButton(
              onPressed: () {
                Provider.of<Counter>(context, listen: false).incrementB();
              },
              child: const Text('Increment B'),
            ),
            const SizedBox(width: 10),
            ElevatedButton(
              onPressed: () {
                Provider.of<Counter>(context, listen: false).incrementC();
              },
              child: const Text('Increment C'),
            ),
          ],
        ),
      ],
    );
  }
}
