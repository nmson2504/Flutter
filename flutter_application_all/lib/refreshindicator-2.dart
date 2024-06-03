import 'dart:ui';
import 'package:flutter/material.dart';

// Cấu hình scroll bằng mouse
// bằng  MaterialApp(scrollBehavior: const MaterialScrollBehavior()

//
class MyRefreshIndicator2 extends StatelessWidget {
  const MyRefreshIndicator2({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scrollBehavior: const MaterialScrollBehavior()
          .copyWith(dragDevices: PointerDeviceKind.values.toSet()),
      home: const RefreshIndicatorExample2(),
    );
  }
}

class RefreshIndicatorExample1 extends StatefulWidget {
  const RefreshIndicatorExample1({super.key});

  @override
  State<RefreshIndicatorExample1> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<RefreshIndicatorExample1> {
  List<String> items = ['Item 1', 'Item 2', 'Item 3'];

// khai báo hàm Future để gọi tại RefreshIndicator(onRefresh:
  Future<void> _refresh() async {
    // Thực hiện các hoạt động làm mới dữ liệu ở đây
    await Future.delayed(const Duration(seconds: 1));
    setState(() {
      items = List.generate(
          15, (index) => 'Item ${index + 1}'); // Cập nhật trạng thái mới
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('RefreshIndicatorExample1 Example'),
      ),
      body: RefreshIndicator(
        onRefresh: _refresh,
        child: ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(items[index]),
            );
          },
        ),
      ),
    );
  }
}

//------------------------------------------------
class RefreshIndicatorExample2 extends StatefulWidget {
  const RefreshIndicatorExample2({super.key});

  @override
  State<RefreshIndicatorExample2> createState() => _MyHomePageState2();
}

class _MyHomePageState2 extends State<RefreshIndicatorExample2> {
  List<String> items = ['Item 1', 'Item 2', 'Item 3'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('RefreshIndicatorExample2 Example'),
      ),
      body: RefreshIndicator(
        // gọi hàm Future ngay tại tham số onRefresh:
        onRefresh: () async {
          // Thực hiện các hoạt động làm mới dữ liệu ở đây
          await Future.delayed(const Duration(
              seconds: 3)); // Đợi 3 giây để mô phỏng hoạt động làm mới
          setState(() {
            items = List.generate(
                15, (index) => 'Item ${index + 1}'); // Cập nhật trạng thái mới
          });
        },
        child: ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(items[index]),
            );
          },
        ),
      ),
    );
  }
}
//------------------------------------------------


