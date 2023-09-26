import 'package:flutter/material.dart';

class MyAlign extends StatelessWidget {
  const MyAlign({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Flutter Align')),
        body: const MyAlign1(),
        // backgroundColor: Color.fromARGB(255, 235, 217, 163),
      ),
    );
  }
}

class MyAlign0 extends StatelessWidget {
  const MyAlign0({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 180.0,
        width: 180.0,
        color: const Color.fromARGB(255, 233, 244, 199),
        child: const Align(
          alignment: Alignment.topCenter,
          child: FlutterLogo(
            size: 60,
          ),
        ),
      ),
    );
  }
}

/* 
//  // Set toạ độ theo Alignment(x, y)
/// The top left corner.
  static const Alignment topLeft = Alignment(-1.0, -1.0);

  /// The center point along the top edge.
  static const Alignment topCenter = Alignment(0.0, -1.0);

  /// The top right corner.
  static const Alignment topRight = Alignment(1.0, -1.0);

  /// The center point along the left edge.
  static const Alignment centerLeft = Alignment(-1.0, 0.0);

  /// The center point, both horizontally and vertically.
  static const Alignment center = Alignment(0.0, 0.0);

  /// The center point along the right edge.
  static const Alignment centerRight = Alignment(1.0, 0.0);

  /// The bottom left corner.
  static const Alignment bottomLeft = Alignment(-1.0, 1.0);

  /// The center point along the bottom edge.
  static const Alignment bottomCenter = Alignment(0.0, 1.0);

  /// The bottom right corner.
  static const Alignment bottomRight = Alignment(1.0, 1.0);

  Trong Flutter, Alignment là một lớp được sử dụng để xác định vị trí tương đối của một điểm trong một hộp chứa. Các giá trị mà bạn cung cấp cho Alignment xác định vị trí theo một hệ tọa độ 2D với tâm là (0, 0) ở giữa và phạm vi từ -1 đến 1 trong mỗi chiều.

Trong trường hợp của bạn, alignment: Alignment(0.2, 0.6) có nghĩa là bạn đang xác định một điểm nằm ở 20% khoảng cách từ trái đến phải của hộp chứa và 60% khoảng cách từ trên xuống đáy của hộp chứa.

Để biểu diễn trực quan hơn, hãy tưởng tượng hộp chứa có kích thước width: 100 và height: 100. Khi bạn đặt alignment: Alignment(0.2, 0.6), điểm được đặt ở vị trí x = 20 (20% của 100) và y = 60 (60% của 100) trên hộp chứa này.

Tóm lại, Alignment(0.2, 0.6) định nghĩa vị trí tương đối của một điểm bên trong một hộp chứa và dựa trên hệ tọa độ có phạm vi từ -1 đến 1.
 
 // Set toạ độ theo FractionalOffset(x, y)
  /// The top left corner.
  static const FractionalOffset topLeft = FractionalOffset(0.0, 0.0);

  /// The center point along the top edge.
  static const FractionalOffset topCenter = FractionalOffset(0.5, 0.0);

  /// The top right corner.
  static const FractionalOffset topRight = FractionalOffset(1.0, 0.0);

  /// The center point along the left edge.
  static const FractionalOffset centerLeft = FractionalOffset(0.0, 0.5);

  /// The center point, both horizontally and vertically.
  static const FractionalOffset center = FractionalOffset(0.5, 0.5);

  /// The center point along the right edge.
  static const FractionalOffset centerRight = FractionalOffset(1.0, 0.5);

  /// The bottom left corner.
  static const FractionalOffset bottomLeft = FractionalOffset(0.0, 1.0);

  /// The center point along the bottom edge.
  static const FractionalOffset bottomCenter = FractionalOffset(0.5, 1.0);

  /// The bottom right corner.
  static const FractionalOffset bottomRight = FractionalOffset(1.0, 1.0);
 */
class MyAlign1 extends StatelessWidget {
  const MyAlign1({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
                color: const Color.fromARGB(255, 233, 244, 199),
                border: Border.all(color: Colors.black, width: 2)),
            // height: 200.0,
            // width: 200.0,
            // color: const Color.fromARGB(255, 233, 244, 199),
            child: const Align(
              alignment: Alignment.bottomLeft,
              // widthFactor: 3 - width container = 3 * width FlutterLogo
              // 2 thuộc tính height/width phải not set
              widthFactor: 2,
              heightFactor: 2,
              child: FlutterLogo(
                size: 100,
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
                color: const Color.fromARGB(255, 233, 244, 199),
                border: Border.all(color: Colors.black, width: 2)),
            height: 200.0,
            width: 200.0,
            child: const Align(
              alignment:
                  Alignment(0.2, 0.6), // truyền value double Alignment(x, y)
              child: FlutterLogo(
                size: 50,
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
                color: const Color.fromARGB(255, 233, 244, 199),
                border: Border.all(color: Colors.black, width: 2)),
            // height: 200.0,
            // width: 200.0,
            child: const Align(
              alignment: FractionalOffset(
                  0.5, 0.6), // truyền value double Alignment(x, y)
              child: FlutterLogo(
                size: 50,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
