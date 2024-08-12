import 'package:flutter/material.dart';

class MyPadding extends StatelessWidget {
  const MyPadding({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Flutter Padding')),
        body: const Padding1(),
        // backgroundColor: Color.fromARGB(255, 235, 217, 163),
      ),
    );
  }
}

/* 
Padding là một widget chuyên dụng chỉ để thêm khoảng trống xung quanh một widget con của nó. Padding không có thêm bất kỳ thuộc tính nào khác ngoài padding. Nó chỉ đơn giản là thêm không gian xung quanh widget con, không thay đổi hoặc thêm các thuộc tính khác.
Padding cũng hữu ích khi bạn muốn thêm padding vào một widget mà không cần sử dụng Container, giúp mã nguồn của bạn ngắn gọn và tập trung hơn.

Sử dụng Container với padding:

- Khi bạn cần nhiều tính năng khác của Container (như màu nền, biên, bo góc, v.v.) ngoài padding. Điều này giúp bạn tổ chức mã nguồn tốt hơn bằng cách gộp tất cả các thuộc tính liên quan vào một widget.
Sử dụng Padding:

- Khi bạn chỉ cần thêm khoảng trống (padding) mà không cần các thuộc tính khác của Container.
Khi bạn muốn giữ mã nguồn đơn giản và dễ đọc hơn, chỉ tập trung vào việc thêm khoảng trống xung quanh một widget cụ thể.
Có thể wrap Padding nằm bên ngoài Container, điều này có thể cần thiết khi bạn muốn giữ khoảng trống bên ngoài Container mà không muốn ảnh hưởng đến nội dung bên trong nó.
 
Khi set height cố định cho Container trong Flutter, padding của container mặc định ở trên (top) sẽ là 0, và padding dưới (bottom) sẽ không có tác dụng. Điều này là do cách Flutter xử lý layout.

Dưới đây là 1 số cách xử lý để set được padding bottom
 */
// Container set width - height
class Padding1 extends StatelessWidget {
  const Padding1({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Container with Padding Demo'),
        ),
        body: Column(
          children: [
            // Container 1: Text aligned to the start (left)
            Container(
              color: Colors.blue,
              child: const Text(
                'Container not setup  - default paddong all = 0',
                style: TextStyle(color: Colors.white, fontSize: 18.0),
                textAlign: TextAlign.start,
              ),
            ),
            Container(
              color: Colors.blue,
              // width: double.infinity,
              height: 50,
              // padding: const EdgeInsets.only(top: 30.0),
              child: const Text(
                'Container set height - default paddong top = 0 và set bottom ko tác dụng',
                style: TextStyle(color: Colors.white, fontSize: 18.0),
                textAlign: TextAlign.start,
              ),
            ),
            // Container 2: Text aligned to the center
            Container(
              color: Colors.green,
              width: double.infinity,
              padding: const EdgeInsets.all(16.0),
              child: const Text(
                ' width: double.infinity - Center aligned text',
                style: TextStyle(color: Colors.white, fontSize: 18.0),
                textAlign: TextAlign.center,
              ),
            ),
            // Container 3: Text aligned to the end (right)
            Container(
              color: Colors.red,
              width: 500,
              height: 100,
              padding: const EdgeInsets.all(16.0),
              child: const Text(
                'Right aligned text - textAlign: TextAlign.end',
                style: TextStyle(color: Colors.white, fontSize: 18.0),
                textAlign: TextAlign.end,
              ),
            ),
            Container(
              height: 100,
              width: 400,
              color: Colors.purple,
              child: const Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: EdgeInsets.only(bottom: 20, left: 10),
                  child: Text(
                    'Container lồng Align để set được padding bottom',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
            Container(
              height: 100,
              width: 400,
              color: const Color.fromARGB(255, 119, 112, 46),
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.end,
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(bottom: 20, left: 10),
                    child: Text(
                      'Container lồng Column để set được padding bottom',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 100,
              width: 400,
              color: Colors.purple,
              child: const Stack(
                children: [
                  Positioned(
                    left: 10,
                    bottom: 10,
                    child: Text(
                      'Container lồng Stack để set được Positioned bottom',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
