import 'package:flutter/material.dart';

class MyNavigation extends StatelessWidget {
  const MyNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    return const Navigator1();
  }
}

// Example 1 - Tổ chức routes tập trung trong một class
// Navigator4 - Định nghĩa các route name trong một class riêng
/// Khai báo các route name trong một class riêng là cách tốt để quản lý và bảo trì mã nguồn. Điều này đặc biệt hữu ích khi ứng dụng của bạn có nhiều route và bạn muốn tránh việc phải nhập tên route trực tiếp trong code, từ đó giúp tránh sai sót và dễ dàng thay đổi route name một cách liền mạch.
class Routes {
  static const String screen1 = "/screen1";
  static const String screen2 = "/screen2";
}

class Navigator4 extends StatelessWidget {
  const Navigator4({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(routes: {
      '/': (context) => const NewWidget(), // route default khi start app
      Routes.screen1: (context) => const Screen1(),
      Routes.screen2: (context) => const Screen2(),
    });
  }
}

class NewWidget extends StatelessWidget {
  const NewWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(' Home Screen '),
        ),
        body: Center(
          child: Column(
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(foregroundColor: Colors.amber),
                onPressed: () {
                  Navigator.pushNamed(context, Routes.screen1);
                },
                child: const Text('Goto Screen1'),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                style: ElevatedButton.styleFrom(foregroundColor: Colors.amber),
                onPressed: () {
                  Navigator.pushNamed(context, Routes.screen2);
                },
                child: const Text('Goto Screen2'),
              ),
            ],
          ),
        ));
  }
}

class Screen1 extends StatelessWidget {
  const Screen1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(' Screen1 '),
      ),
      body: Center(
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(foregroundColor: Colors.amber),
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Return to Home Screen'),
        ),
      ),
    );
  }
}

class Screen2 extends StatelessWidget {
  const Screen2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(' Screen2 '),
      ),
      body: Center(
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(foregroundColor: Colors.amber),
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Return to Home Screen'),
        ),
      ),
    );
  }
}

// Example 2 - Tổ chức routes tập trung trong một class
class Routes2 {
  static const String home = "/home";
  static const String screen1 = "/screen1";
  static const String screen2 = "/screen2";
  static const String screen3 = "/screen3";
}

class Navigator1 extends StatelessWidget {
  const Navigator1({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: Routes2.home,
      home: const Scaffold(
          // body: Home(),
          ),
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case Routes2.screen1:
            return MaterialPageRoute(
                // làm sao truyền route tại đây? (hiện tại truyền tại đay ko get được ở UI)
                builder: (_) => const Screen1());
          case Routes2.screen2:
            return MaterialPageRoute(
                // làm sao truyền route tại đây? (hiện tại truyền tại đay ko get được ở UI)
                builder: (_) => const Screen22(items: []));

          case Routes2.screen3:
            return MaterialPageRoute(
                builder: (_) => Screen3(data: settings.arguments.toString()));

          default:
            return MaterialPageRoute(builder: (context) => const Screen1());
        }
      },
    );
  }
}

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> itemList = ['Mục 1', 'Mục 2', 'Mục 3', 'Mục 4'];
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        automaticallyImplyLeading: false, // ẩn back icon ở góc trái title
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const Screen11(),
                        settings: const RouteSettings(name: Routes2.screen1)),
                  );
                },
                child: const Text('Screen1')),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Screen22(items: itemList),
                      settings: const RouteSettings(name: Routes2.screen2)),
                );
              },
              child: const Text('Screen2'),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const Screen3(
                            data: '123',
                          ),
                      settings: const RouteSettings(name: Routes2.screen3)),
                );
              },
              child: const Text('Screen3'),
            ),
          ],
        ),
      ),
    );
  }
}

class Screen11 extends StatelessWidget {
  const Screen11({super.key});

  @override
  Widget build(BuildContext context) {
    final routeName = ModalRoute.of(context)?.settings.name;
    return Scaffold(
      appBar: AppBar(title: Text('$routeName')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Back'),
            ),
          ],
        ),
      ),
    );
  }
}

class Screen22 extends StatelessWidget {
  const Screen22({super.key, required this.items});
  //
  final List<String> items; // Khai báo danh sách items

  @override
  Widget build(BuildContext context) {
    final routeName = ModalRoute.of(context)?.settings.name;
    return Scaffold(
      appBar: AppBar(title: Text('$routeName')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Danh sách các mục:'),
            // Sử dụng ListView.builder để hiển thị danh sách
            Expanded(
              child: ListView.builder(
                //  shrinkWrap: true, // xử lý Lỗi "Vertical viewport was given unbounded height" hoặc bao ngoài LitstView bằng Expanded
                itemCount: items.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(items[index]),
                  );
                },
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Back'),
            ),
          ],
        ),
      ),
    );
  }
}

class Screen3 extends StatelessWidget {
  const Screen3({super.key, required this.data});
  final String data;
  @override
  Widget build(BuildContext context) {
    final routeName = ModalRoute.of(context)?.settings.name;
    return Scaffold(
      appBar: AppBar(title: Text('$routeName')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Back'),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(data)
          ],
        ),
      ),
    );
  }
}
