import 'dart:math';

import 'package:flutter/material.dart';

// Khai báo các loại button
class MyCustomPaint2 extends StatelessWidget {
  const MyCustomPaint2({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyBox5(),
    );
  }
}

//  CustomPainter cho phép bạn vẽ bất kỳ hình dạng nào bạn muốn bằng canvas.
// Diễn giải
/* 
+ Canvas Area
Khái niệm Canvas như một tấm vải trắng(nền) hình chữ nhật/vuông mà bạn có thể vẽ bất kỳ hình dạng, đường nét, màu sắc nào bạn muốn.
Canvas có hệ thống tọa độ được mô tả: điểm gốc - origin (0, 0) nằm ở góc trên bên trái của canvas, with tăng dần sang phải - height tăng dần xuống dưới
Mọi nét vẽ đều sẽ liên qua đến điểm gốc - origin, nơi mà painter bắt đầu.
+ CustomPaint:
Một widget cung cấp khung vẽ để truyền widget CustomPainter thực hiện hành động vẽ.
.painter : 1 painter được vẽ trước khi child được vẽ.(nằm dưới child)
.foregroundPainter: 1 painter được vẽ sau khi child được vẽ (đè lên trên child).
.child: Theo mặc định, canvas sẽ lấy kích thước của child, nếu nó được xác định(có child thì canvas sẽ có cùng size với child.).
.size: Nếu child không được khai báo, thì kích thước của canvas phải được chỉ định.

+ CustomPainter
CustomPainter là một lớp trừu tượng trong Flutter, thực hiện hành động vẽ.
Bạn sẽ tạo một lớp mới kế thừa từ CustomPainter và override hai phương thức:
paint(Canvas canvas, Size size): Phương thức này được gọi để vẽ lên canvas. Bạn sẽ sử dụng các hàm của canvas như drawLine, drawCircle, drawRect,... để tạo ra các hình dạng.
shouldRepaint(CustomPainter oldDelegate): Phương thức này quyết định khi nào canvas cần được vẽ lại(khi cần cập nhật đối tượng). Thông thường, bạn sẽ trả về true nếu các thuộc tính của lớp CustomPainter thay đổi, và false nếu không. 
+ Một số method vẽ cơ bản của Canvas
.drawRect - vẽ hình tứ giác
.drawLine - vẽ đường thẳng
.drawRRect - vẽ rectangle bo tròn góc
.drawCircle - vẽ hình tròn
.drawPath - vẽ các đường dẫn (paths) lên canvas. Đường dẫn (path) là một chuỗi các điểm và đường được kết nối với nhau để tạo thành các hình dạng phức tạp. Bạn có thể sử dụng drawPath để tạo ra các hình dạng tùy chỉnh mà không bị giới hạn bởi các hình dạng cơ bản như hình chữ nhật, hình tròn, v.v.
Phải khai báo 
  Path path = Path();
và vẽ với các method của path
    path.moveTo(50, 50); // Điểm bắt đầu
    path.lineTo(100, 50); // Vẽ một đường thẳng, x:y là toạ độ điểm vẽ đến 
    path.lineTo(100, 100); // Vẽ một đường thẳng khác
    path.close(); // Đóng đường dẫn để tạo thành một hình tam giác
cuối cùng đưa path vào .drawPath
    canvas.drawPath(path, paint); // Vẽ đường dẫn lên canvas
moveTo: được sử dụng để thay đổi vị trí hiện tại của điểm thành tọa độ được chỉ định.
lineTo: được sử dụng để vẽ một đường thẳng từ điểm hiện tại đến điểm được chỉ định trên canvas.

+ Một số method của path
-addOval - sử dụng để thêm một hình bầu dục (oval) hoặc hình tròn vào đối tượng Path
.addArc(Rect oval,double startAngle,double sweepAngle,) - startAngle: góc bắt đầu vẽ; sweepAngle - góc kết thúc cung
cho phép bạn thêm một cung tròn vào Path, được xác định bởi một hình chữ nhật bao quanh và góc bắt đầu, độ dài cung.

+ Một số thược tính của Paint
color - màu nền
strokeWidth - độ dày viền, chỉ tác dụng khi style = PaintingStyle.stroke

+ Quan trọng
 - Nên lấy toạ độ theo kích thước của canvas - size.width & size.height để hình vẽ luôn tỉ lệ theo canvas, ko bể layout 


+ So sánh với cách dùng Path & drawLine:
- Ưu điểm của drawLine:
    Đơn giản hơn cho các hình đơn giản như tam giác.
    Có thể dễ dàng điều chỉnh từng đoạn thẳng.
- Ưu điểm của Path:
    Linh hoạt hơn cho các hình phức tạp.
    Có thể tạo ra các đường cong, hình dạng tùy ý.
    Tối ưu hơn khi vẽ nhiều hình liên tiếp.
Lựa chọn phương pháp:
Sử dụng drawLine: Khi bạn muốn vẽ các hình đơn giản, không cần các hiệu ứng phức tạp.
Sử dụng Path: Khi bạn muốn vẽ các hình phức tạp, cần tạo các hiệu ứng như đổ bóng, gradient, hoặc kết hợp nhiều hình.
 */
/* 
Các bước triển khai vẽ canvas:
- Tạo lớp class XXXPainter extends CustomPainter, trong đó thực hiện
  Định nghĩa các thuộc tính cần thiết như color, style,...
  Override hai phương thức paint(vẽ tại đây) & shouldRepaint
- Khai báo CustomPaint, set các thuộc tính size, painter, foregroundPainter
  Gọi class XXXPainter tại bước 1 vào painter or foregroundPainter

 */
// đường tròn - vuông - thoi
class MyBox1 extends StatelessWidget {
  const MyBox1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Canvas Drawing Demo')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black, // Màu viền
                  width: 1.0, // Độ dày của viền
                ),
              ),
              child: CustomPaint(
                size: const Size(200, 200),
                painter: CirclePainter(),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black, // Màu viền
                  width: 1.0, // Độ dày của viền
                ),
              ),
              child: CustomPaint(
                size: const Size(200, 200),
                painter: SquarePainter(),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black, // Màu viền
                  width: 1.0, // Độ dày của viền
                ),
              ),
              child: CustomPaint(
                size: const Size(200, 200),
                painter: RhombusPainter(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// tam giác - Rect.fromCenter - Rect.fromLTWH
class MyBox2 extends StatelessWidget {
  const MyBox2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Canvas Drawing Demo 2')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black, // Màu viền
                  width: 1.0, // Độ dày của viền
                ),
              ),
              child: CustomPaint(
                size: const Size(200, 200),
                painter: TrianglePainter(),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black, // Màu viền
                  width: 1.0, // Độ dày của viền
                ),
              ),
              child: CustomPaint(
                size: const Size(200, 200),
                painter: SquarePainter(),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black, // Màu viền
                  width: 1.0, // Độ dày của viền
                ),
              ),
              child: CustomPaint(
                size: const Size(200, 200),
                painter: SquarePainterfromLTWH(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Các method của Rect.
class MyBox3 extends StatelessWidget {
  const MyBox3({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Canvas Drawing Demo 3')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black, // Màu viền
                  width: 1.0, // Độ dày của viền
                ),
              ),
              child: CustomPaint(
                size: const Size(200, 200),
                painter: SquarePainter(),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black, // Màu viền
                  width: 1.0, // Độ dày của viền
                ),
              ),
              child: CustomPaint(
                size: const Size(200, 200),
                painter: SquarePainterfromLTWH(),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black, // Màu viền
                  width: 1.0, // Độ dày của viền
                ),
              ),
              child: CustomPaint(
                size: const Size(200, 200),
                painter: SquarePainterfromCircle(),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black, // Màu viền
                  width: 1.0, // Độ dày của viền
                ),
              ),
              child: CustomPaint(
                size: const Size(200, 200),
                painter: SquarePainterfromLTRB(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MyBox4 extends StatelessWidget {
  const MyBox4({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Canvas Drawing Demo 4')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black, // Màu viền
                  width: 1.0, // Độ dày của viền
                ),
              ),
              child: CustomPaint(
                size: const Size(200, 200),
                painter: DrawLine0(),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black, // Màu viền
                  width: 1.0, // Độ dày của viền
                ),
              ),
              child: CustomPaint(
                size: const Size(200, 200),
                painter: DrawLine1(),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black, // Màu viền
                  width: 1.0, // Độ dày của viền
                ),
              ),
              child: CustomPaint(
                size: const Size(200, 200),
                painter: DrawLineTriangle(),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black, // Màu viền
                  width: 1.0, // Độ dày của viền
                ),
              ),
              child: CustomPaint(
                size: const Size(200, 200),
                painter: DrawLineStar(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MyBox5 extends StatelessWidget {
  const MyBox5({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Canvas Drawing Demo 5')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black, // Màu viền
                  width: 1.0, // Độ dày của viền
                ),
              ),
              child: CustomPaint(
                size: const Size(200, 200),
                painter: AddOval(),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black, // Màu viền
                  width: 1.0, // Độ dày của viền
                ),
              ),
              child: CustomPaint(
                size: const Size(200, 200),
                painter: AddOval1(),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black, // Màu viền
                  width: 1.0, // Độ dày của viền
                ),
              ),
              child: CustomPaint(
                size: const Size(200, 200),
                painter: AddOvalX(),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black, // Màu viền
                  width: 1.0, // Độ dày của viền
                ),
              ),
              child: CustomPaint(
                size: const Size(200, 200),
                painter: AddOval2(),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black, // Màu viền
                  width: 1.0, // Độ dày của viền
                ),
              ),
              child: CustomPaint(
                size: const Size(200, 200),
                painter: AddOval3(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MyBox6 extends StatelessWidget {
  const MyBox6({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Canvas Drawing Demo 6')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black, // Màu viền
                  width: 1.0, // Độ dày của viền
                ),
              ),
              child: CustomPaint(
                size: const Size(200, 200),
                painter: AddOvaladdArc(),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black, // Màu viền
                  width: 1.0, // Độ dày của viền
                ),
              ),
              child: CustomPaint(
                size: const Size(200, 200),
                painter: AddArcDuongTronLuongGiac(),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black, // Màu viền
                  width: 1.0, // Độ dày của viền
                ),
              ),
              child: CustomPaint(
                size: const Size(200, 200),
                painter: AddArcDuongTronLuongGiac1(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//
//  path.addOval(Rect.fromCircle( - vẽ cung tròn
class AddOval extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = Colors.teal
      ..strokeWidth = 5
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    var path = Path();
    path.addOval(Rect.fromCircle(
      center: Offset(size.width / 2, size.height / 2),
      radius: 80,
    ));
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

// Vẽ một hình kết hợp hai hình tròn
class AddOval1 extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = Colors.teal
      ..strokeWidth = 5
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    var path = Path();
    // Vẽ một hình kết hợp hai hình tròn
    path.addOval(Rect.fromCircle(
        center: Offset(size.width / 2 - 25, size.height / 2), radius: 50));
    path.addOval(Rect.fromCircle(
        center: Offset(size.width / 2 + 25, size.height / 2), radius: 50));

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

// Vẽ hình oval với rect = Rect.fromLTWH(
class AddOval2 extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Tạo Paint object để cấu hình cho nét vẽ
    final paint = Paint()
      ..color = Colors.red
      ..strokeWidth = 4
      ..style = PaintingStyle.stroke;

    // Tạo một Path
    final path = Path();

    // Tạo một khung chữ nhật bao quanh (bounding box)
    const rect = Rect.fromLTWH(20, 20, 150, 100);

    // Thêm một hình bầu dục vào Path
    path.addOval(rect);

    // Vẽ Path lên canvas
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

// addOval & addArc - addArc
// addArc(Rect oval,double startAngle,double sweepAngle,) - startAngle: góc bắt đầu vẽ; sweepAngle - góc kết thúc cung
class AddOvalX extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.yellow
      ..style = PaintingStyle.fill;

    final outlinePaint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4;

    // Vẽ khuôn mặt
    final facePath = Path()
      ..addOval(Rect.fromCircle(
        center: Offset(size.width / 2, size.height / 2),
        radius: size.width / 2 - 10,
      ));
    canvas.drawPath(facePath, paint); // vẽ nền
    canvas.drawPath(facePath, outlinePaint); // vẽ viền

    // Vẽ mắt trái
    final leftEyePath = Path()
      ..addOval(Rect.fromCircle(
        center: Offset(size.width / 3, size.height / 3),
        radius: 20,
      ));
    canvas.drawPath(leftEyePath, outlinePaint);

    // Vẽ mắt phải
    final rightEyePath = Path()
      ..addOval(Rect.fromCircle(
        center: Offset(size.width * 2 / 3, size.height / 3),
        radius: 20,
      ));
    canvas.drawPath(rightEyePath, outlinePaint);

    // Vẽ miệng cười
    // addArc(Rect oval,double startAngle,double sweepAngle,)
    final smilePath = Path()
      ..addArc(
        Rect.fromCircle(
          center: Offset(size.width / 2, size.height * 3 / 5),
          radius: size.width / 4,
        ),
        0.2, //  Cung tròn sẽ bắt đầu từ một điểm khoảng 11.5 độ (0.2 radian) tính từ trục x dương, và kéo dài thêm khoảng 154.7 độ (2.7 radian) theo chiều kim đồng hồ.
        2.7, //  2.7 radian tương ứng với khoảng 154.7 độ (2.7 * 180 / π ≈ 154.7).
      );
    canvas.drawPath(smilePath, outlinePaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

class AddOvaladdArc extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.yellow
      ..style = PaintingStyle.fill;

    final outlinePaint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4;

    // Vẽ đường tròn
    final facePath = Path()
      ..addOval(Rect.fromCircle(
        center: Offset(size.width / 2, size.height / 2),
        radius: size.width / 2 - 10,
      ));
    canvas.drawPath(facePath, paint); // vẽ nền
    canvas.drawPath(facePath, outlinePaint); // vẽ viền

    // Vẽ miệng cười
    // addArc(Rect oval,double startAngle,double sweepAngle,)
    final smilePath = Path()
      ..addArc(
        Rect.fromCircle(
          center: Offset(size.width / 2, size.height * 3 / 5),
          radius: size.width / 4,
        ),
        pi / 12,
        5 * pi / 6,
      );
    canvas.drawPath(smilePath, outlinePaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

//
class AddOval3 extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.stroke;
    final paint2 = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.stroke;

    final path = Path();
    final path2 = Path();

    // Tạo một hình oval nằm ngang
    path.addOval(const Rect.fromLTWH(50, 50, 200, 100));

    // Tạo một hình oval dọc
    path2.addOval(Rect.fromCircle(
      center: Offset(size.width / 2, size.height / 2),
      radius: 50,
    ));

    canvas.drawPath(path, paint);
    canvas.drawPath(path2, paint2);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

//  vẽ đường tròn lượng giác
/* 
// addArc(Rect oval,double startAngle,double sweepAngle,) - startAngle: góc bắt đầu vẽ; sweepAngle - góc kết thúc cung
startAngle = 0 là điểm 0 độ trên đương tròn lựogn giác
Độ lớn của cung (sweepAngle) được vẽ theo chiều kim đồng hồ nếu giá trị của sweepAngle là dương. Ngược lại, nếu giá trị sweepAngle là âm, cung sẽ được vẽ theo chiều ngược kim đồng hồ. Cung vẽ sẽ bằng startAngle + sweepAngle
Tham chiếu đườn tròn lượng giác https://upload.wikimedia.org/wikipedia/commons/c/c9/Unit_circle_angles.svg để vẽ cung như ý
 */
class AddArcDuongTronLuongGiac extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius =
        size.width < size.height ? size.width / 2 - 20 : size.height / 2 - 20;

    final paint = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    // Vẽ đường tròn chính
    canvas.drawCircle(center, radius, paint);

    // Vẽ trục x và y
    canvas.drawLine(
        Offset(0, size.height / 2), Offset(size.width, size.height / 2), paint);
    canvas.drawLine(
        Offset(size.width / 2, 0), Offset(size.width / 2, size.height), paint);

    // Vẽ các đánh dấu cho các góc chính
    final paintGoc = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    final angles = [
      0,
      pi / 6,
      pi / 4,
      pi / 3,
      pi / 2,
      2 * pi / 3,
      3 * pi / 4,
      5 * pi / 6,
      pi,
      7 * pi / 6,
      5 * pi / 4,
      4 * pi / 3,
      3 * pi / 2,
      5 * pi / 3,
      7 * pi / 4,
      11 * pi / 6
    ];
    for (var angle in angles) {
      final startPoint = Offset(center.dx + (radius - 10) * cos(angle),
          center.dy - (radius - 10) * sin(angle));
      final endPoint = Offset(center.dx + (radius + 10) * cos(angle),
          center.dy - (radius + 10) * sin(angle));
      canvas.drawLine(startPoint, endPoint, paintGoc);
    }

    // Vẽ cung sử dụng path.addArc
    final arcPaint = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.square
      ..strokeWidth = 3;
    double startAngle = -pi / 2;
    double sweepAngle = pi;
    final rect = Rect.fromCircle(center: center, radius: radius);
    final path = Path()..addArc(rect, startAngle, sweepAngle); //

    canvas.drawPath(path, arcPaint);

    // Vẽ mũi tên chỉ hướng tại điểm kết thúc của cung
    final arrowPaint = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.fill;

    // Tính toán vị trí của điểm kết thúc cung
    double endAngle = startAngle + sweepAngle;
    final arrowEnd = Offset(
      center.dx + radius * cos(endAngle),
      center.dy + radius * sin(endAngle),
    );

    // Vẽ mũi tên
    final arrowPath = Path()
      ..moveTo(arrowEnd.dx, arrowEnd.dy)
      ..lineTo(
        arrowEnd.dx - 10 * cos(endAngle - pi / 6),
        arrowEnd.dy - 10 * sin(endAngle - pi / 6),
      )
      ..lineTo(
        arrowEnd.dx - 10 * cos(endAngle + pi / 6),
        arrowEnd.dy - 10 * sin(endAngle + pi / 6),
      )
      ..close();

    canvas.drawPath(arrowPath, arrowPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

class AddArcDuongTronLuongGiac1 extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = min(size.width / 2, size.height / 2) - 20;

    // Draw the main circle
    final circlePaint = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    canvas.drawCircle(center, radius, circlePaint);

    // Define the rect for the arc
    final rect = Rect.fromCircle(center: center, radius: radius);

    // Define the path for the arc
    final path = Path()
      ..addArc(rect, -pi / 4, pi / 2); // Sweep from -45 degrees to 45 degrees

    // Draw the arc
    final arcPaint = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4;

    canvas.drawPath(path, arcPaint);

    // Draw arrow indicating direction of arc
    final arrowPaint = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.fill;

    // Calculate the end point of the arc
    const endAngle = -pi / 4 + pi / 2;
    final arrowEnd = Offset(
      center.dx + radius * cos(endAngle),
      center.dy + radius * sin(endAngle),
    );

    final arrowPath = Path()
      ..moveTo(arrowEnd.dx, arrowEnd.dy)
      ..lineTo(
        arrowEnd.dx - 10 * cos(endAngle - pi / 6),
        arrowEnd.dy - 10 * sin(endAngle - pi / 6),
      )
      ..lineTo(
        arrowEnd.dx - 10 * cos(endAngle + pi / 6),
        arrowEnd.dy - 10 * sin(endAngle + pi / 6),
      )
      ..close();

    canvas.drawPath(arrowPath, arrowPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

// drawLine(Offset p1,Offset p2,Paint paint)
class DrawLine0 extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.red
      ..strokeWidth = 5.0;
    canvas.drawLine(
        const Offset(10, 10), Offset(size.width - 10, size.height - 10), paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

class DrawLine1 extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = Colors.teal
      ..strokeWidth = 5
      ..strokeCap = StrokeCap.round; // hình dạng của đầu nét vẽ

    Offset startingPoint = Offset(0, size.height / 2);
    Offset endingPoint = Offset(size.width, size.height / 2);

    canvas.drawLine(startingPoint, endingPoint, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

class DrawLineTriangle extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Tạo Paint object để cấu hình cho đường vẽ
    final paint = Paint()
      ..color = Colors.blue
      ..strokeWidth = 4
      ..style = PaintingStyle.stroke;

    // Tạo ba điểm của tam giác
    final point1 = Offset(size.width / 2, size.height * 0.2);
    final point2 = Offset(size.width * 0.2, size.height * 0.8);
    final point3 = Offset(size.width * 0.8, size.height * 0.8);

    // Vẽ ba đường thẳng nối ba điểm lại với nhau
    canvas.drawLine(point1, point2, paint);
    canvas.drawLine(point2, point3, paint);
    canvas.drawLine(point3, point1, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class DrawLineStar extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.blue
      ..strokeWidth = 4
      ..style = PaintingStyle.stroke;

    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width < size.height ? size.width / 2 : size.height / 2;

    for (int i = 0; i < 5; i++) {
      final startAngle = i * 4 * pi / 5;
      final endAngle = startAngle + 2 * 4 * pi / 5;

      final startPoint = Offset(
        center.dx + radius * cos(startAngle),
        center.dy + radius * sin(startAngle),
      );
      final endPoint = Offset(
        center.dx + radius * cos(endAngle),
        center.dy + radius * sin(endAngle),
      );

      canvas.drawLine(startPoint, endPoint, paint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

class TrianglePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4;

    final path = Path();

    // Bắt đầu từ đỉnh trên cùng của tam giác
    path.moveTo(size.width / 2, 0);

    // Vẽ cạnh xuống bên phải
    path.lineTo(size.width, size.height);

    // Vẽ cạnh ngang dưới cùng
    path.lineTo(0, size.height);

    // Đóng đường dẫn để tạo tam giác
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

class CirclePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4;

    canvas.drawCircle(
      Offset(size.width / 2, size.height / 2), // tâm 0
      size.width / 4, // radius
      paint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

//  Rect.fromCenter
class SquarePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4;

    canvas.drawRect(
      Rect.fromCenter(
        center: Offset(size.width / 2, size.height / 2), // toạ đọ tâm hình
        width: size.width / 2,
        height: size.width / 2,
      ),
      paint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

//  Rect.fromLTWH
class SquarePainterfromLTWH extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4;

    // Vẽ hình vuông
    canvas.drawRect(const Rect.fromLTWH(10, 10, 100, 100),
        paint); // left - top: toạ độ đỉnh trên trái; width - height
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

// Rect.fromCircle
class SquarePainterfromCircle extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4;

    // Vẽ hình vuông
    canvas.drawRect(
        Rect.fromCircle(
            center: Offset(
                size.width / 2, size.height / 2), // center - toạ độ tâm hình
            radius: size.height / 3), // radius
        paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

//  Rect.fromLTRB
class SquarePainterfromLTRB extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    // Vẽ hình vuông
    canvas.drawRect(
        const Rect.fromLTRB(20, 50, 180,
            100), // left - right: cùng là padding trái; top - bottom: cùng là padding trên

        paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

class RhombusPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.green
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4;

    final path = Path();
    path.moveTo(size.width / 2, size.height / 4);
    path.lineTo(size.width * 3 / 4, size.height / 2);
    path.lineTo(size.width / 2, size.height * 3 / 4);
    path.lineTo(size.width / 4, size.height / 2);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
