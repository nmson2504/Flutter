import 'package:flutter/material.dart';

class MyInk extends StatelessWidget {
  const MyInk({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(useMaterial3: true),
      home: Scaffold(
        appBar: AppBar(title: const Text('Ink Sample')),
        body: const DemoInk001(),
      ),
    );
  }
}

//
//
class DemoInk001 extends StatelessWidget {
  const DemoInk001({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // object 1
        Ink(
          decoration: ShapeDecoration(
            color: const Color.fromARGB(255, 72, 190, 245), // Màu nền
            shape: RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.circular(10.0), // Định dạng hình dạng bo tròn
            ),
          ),
          child: ListTile(
            title: const Text('Ink - Tên danh sách'),
            subtitle: const Text('Mô tả danh sách'),
            onTap: () {
              // Xử lý khi người dùng chọn một danh sách
            },
          ),
        ),
        // object 2
        InkWell(
            onTap: () {
              // Xử lý khi người dùng chạm vào
            },
            child: Ink(
              decoration: const BoxDecoration(
                color: Colors.blue, // Màu nước rơi
                shape: BoxShape.circle, // Hình dạng của hiệu ứng nước rơi
              ),
              // dsgdsgds
              child: Container(
                width: 100,
                height: 100,
                alignment: Alignment.center,
                child: const Text(
                  'InkWell - Ink',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            )),
        // object 3
        Center(
          child: Ink(
            color: Colors.yellow,
            width: 200.0,
            height: 100.0,
            child: InkWell(
                onTap: () {/* ... */},
                child: const Center(
                  child: Text('Ink - InkWell'),
                )),
          ),
        ),
        // object 4
        InkWell(
          onTap: () {
            // Xử lý khi người dùng chạm vào nút
            debugPrint('Nút đã được chạm vào!');
          },
          child: Ink(
            decoration: const BoxDecoration(
              color: Colors.blue, // Màu nước rơi
              shape: BoxShape.circle, // Hình dạng của hiệu ứng nước rơi
            ),
            width: 100,
            height: 100,
            child: const Center(
              child: Text(
                'InkWell - Ink',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ),
        // object 5
        InkResponse(
          onTap: () {
            // Xử lý khi người dùng chạm vào nút
            debugPrint('Nút đã được chạm vào!');
          },
          child: Ink(
            decoration: const BoxDecoration(
              color: Colors.blue, // Màu nước rơi
              shape: BoxShape.circle, // Hình dạng của hiệu ứng nước rơi
            ),
            width: 100,
            height: 100,
            child: const Center(
              child: Text(
                'InkResponse - Ink',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ),
        // object 6
        InkResponse(
          onTap: () {
            // Xử lý khi người dùng chạm vào nút
            debugPrint('Nút đã được chạm vào!');
          },
          child: Ink(
            decoration: const BoxDecoration(
              color: Colors.blue, // Màu nước rơi
              shape: BoxShape.circle, // Hình dạng của hiệu ứng nước rơi
            ),
            width: 100,
            height: 100,
            child: InkWell(
              // Hiệu ứng nổi bật khi di chuột qua
              splashColor: Colors.red,
              highlightColor: Colors.transparent,
              borderRadius:
                  BorderRadius.circular(50), // Hình dạng của hiệu ứng nổi bật
              child: const Center(
                child: Text(
                  'Chạm vào',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
        ),
        // object 7
        InkResponse(
          onTap: () {
            // Xử lý khi người dùng chạm vào nút
            debugPrint('Chạm vào nút!');
          },
          onLongPress: () {
            // Xử lý khi người dùng giữ nút trong một thời gian dài
            debugPrint('Giữ nút trong một thời gian dài!');
          },
          onDoubleTap: () {
            // Xử lý khi người dùng nhấn đôi vào nút
            debugPrint('Nhấn đôi vào nút!');
          },
          child: Ink(
            decoration: const BoxDecoration(
              color: Colors.blue, // Màu nước rơi
              shape: BoxShape.circle, // Hình dạng của hiệu ứng nước rơi
            ),
            width: 100,
            height: 100,
            child: const Center(
              child: Text(
                'Chạm vào',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        )
      ],
    );
  }
}
