import 'dart:math';

import 'package:flutter/material.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    var mapC = {
      1: () => const MyWidget1(),
      2: () => const MyWidget2(),
    };

    int n = 2; // Giá trị n có thể thay đổi

    // Kiểm tra nếu map chứa key n
    Widget bodyWidget;
    if (mapC.containsKey(n)) {
      bodyWidget = mapC[n]!(); // Gọi hàm trả về Widget
    } else {
      bodyWidget = const Center(child: Text('Không tìm thấy widget'));
    }

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('FutureBuilder Sample')),
        body: bodyWidget, // Truyền Widget vào body
      ),
    );
  }
}

/* 
Nếu chỉ cần nhận dữ liệu một lần, bạn có thể sử dụng Future thay vì Stream. Future là một lựa chọn tốt khi bạn không cần lắng nghe các sự kiện liên tục.
FutureBuilder là một widget trong Flutter cho phép bạn xây dựng giao diện dựa trên trạng thái của một Future.
 */
// Example 1
class MyWidget1 extends StatelessWidget {
  const MyWidget1({super.key});

  @override
  Widget build(BuildContext context) {
    return // Sử dụng FutureBuilder
        FutureBuilder<int>(
      future: fetchData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          return Text('Data: ${snapshot.data}');
        }
      },
    );
  }

  Future<int> fetchData() async {
    // Giả lập việc gọi API
    return Future.delayed(const Duration(seconds: 2), () => 42);
  }
}

// Example 2
class MyWidget2 extends StatelessWidget {
  const MyWidget2({super.key});

  // Hàm trả về Future danh sách số ngẫu nhiên
  Future<List<int>> fetchRandomNumbers() async {
    // Giả lập độ trễ để tải dữ liệu
    await Future.delayed(const Duration(seconds: 2));
    // Tạo danh sách số ngẫu nhiên
    return List.generate(5, (_) => Random().nextInt(100));
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<int>>(
      future: fetchRandomNumbers(), // gọi hàm fetch
      builder: (BuildContext context, AsyncSnapshot<List<int>> snapshot) {
        // Kiểm tra trạng thái của snapshot
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator(); // Hiển thị loading
        } else if (snapshot.hasError) {
          return Text('Đã xảy ra lỗi: ${snapshot.error}'); // Hiển thị lỗi
        } else if (snapshot.hasData) {
          // Hiển thị danh sách số ngẫu nhiên
          final numbers = snapshot.data!;
          return ListView.builder(
            itemCount: numbers.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text('Số ngẫu nhiên: ${numbers[index]}'),
              );
            },
          );
        } else {
          return const Text('Không có dữ liệu'); // Trường hợp không có dữ liệu
        }
      },
    );
  }
}
