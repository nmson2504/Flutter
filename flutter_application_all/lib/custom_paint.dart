import 'package:flutter/material.dart';

// Khai báo các loại button
class MyCustomPaint extends StatelessWidget {
  const MyCustomPaint({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyBox2c(),
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
.drawPath - vẽ các đường dẫn (paths) lên canvas. Đường dẫn (path) là một chuỗi các điểm và đường được kết nối với nhau để tạo thành các hình dạng phức tạp. Bạn có thể sử dụng drawPath để tạo ra các hình dạng tùy chỉnh mà không bị giới hạn bởi các hình dạng cơ bản như hình chữ nhật, hình tròn, v.v.
Phải khai báo 
  Path path = Path();
và vẽ với các method của path
    path.moveTo(50, 50); // Điểm bắt đầu
    path.lineTo(100, 50); // Vẽ một đường thẳng
    path.lineTo(100, 100); // Vẽ một đường thẳng khác
    path.close(); // Đóng đường dẫn để tạo thành một hình tam giác
cuối cùng đưa path vào .drawPath
    canvas.drawPath(path, paint); // Vẽ đường dẫn lên canvas
.lineTo

+ Một số thược tính của Paint
color - màu nền
strokeWidth - độ dày viền, chỉ tác dụng khi style = PaintingStyle.stroke

+ Quan trọng
 - Nên lấy toạ độ theo kích thước của canvas - size.width & size.height để hình vẽ luôn tỉ lệ theo canvas, ko bể layout 
 */

// vẽ với drawRect
class MyBox1 extends StatelessWidget {
  const MyBox1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black, // Màu viền
                  width: 1.0, // Độ dày của viền
                ),
              ),
              child: CustomPaint(
                size: const Size(300, 200), // kích thước hình vẽ
                painter: MyRect01(),
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
                size: const Size(300, 200), // kích thước hình vẽ
                painter: MyRect02(),
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
                size: const Size(300, 300), // kích thước hình vẽ
                painter: MyRect03(),
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
                size: const Size(200, 100), // kích thước hình vẽ
                painter: MyRect03(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MyRect01 extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Vẽ viền và các hình dạng khác tùy ý
    Paint paint = Paint()
      ..color = Colors.blue
      ..strokeWidth = 2.0;
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height),
        paint); // with - height bằng size của CustomPaint
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

class MyRect02 extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Vẽ viền và các hình dạng khác tùy ý
    Paint paint = Paint()
      ..color = Colors.blue
      ..strokeWidth = 3.0 // chỉ tác dụng khi style = PaintingStyle.stroke
      ..style =
          PaintingStyle.stroke; // vẽ viền hoặc tô phủ kín, default is fill

    canvas.drawRect(const Rect.fromLTWH(20, 20, 100, 100), paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

// vẽ với .drawRRect - hình rectangle bo tròn góc - gọi .drawRRect 2 lần: 1 vẽ nền 1 vẽ viền
class MyRect03 extends CustomPainter {
  final Color borderColor;
  final double borderWidth;
  final Color fillColor;
  final double borderRadius;

  MyRect03({
    this.borderColor = Colors.green,
    this.borderWidth = 4.0,
    this.fillColor = const Color.fromARGB(255, 239, 188, 188),
    this.borderRadius = 10.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = fillColor
      ..style = PaintingStyle.fill;
    final rect = Rect.fromLTWH(0, 0, size.width, size.height);

    final roundedRect =
        RRect.fromRectAndRadius(rect, Radius.circular(borderRadius));
    canvas.drawRRect(roundedRect, paint); // vẽ nền

    final borderPaint = Paint()
      ..color = borderColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = borderWidth;
    canvas.drawRRect(roundedRect, borderPaint); // vẽ viền
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

// vẽ với
class MyBox2 extends StatelessWidget {
  const MyBox2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black, // Màu viền
                  width: 1.0, // Độ dày của viền
                ),
              ),
              child: CustomPaint(
                size: const Size(300, 300), // kích thước hình vẽ
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
                size: const Size(300, 300), // kích thước hình vẽ
                painter: MyRect02(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Hình vuông được căn giữa với kích thước bằng 1/2 kích thước của canvas - .drawRect(Rect.fromCenter(
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

//

// Vẽ với .drawPath
class MyBox2b extends StatelessWidget {
  const MyBox2b({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CustomPaint Demo'),
      ),
      body: Center(
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black, // Màu viền
                  width: 1.0, // Độ dày của viền
                ),
              ),
              child: CustomPaint(
                size: const Size(300, 200),
                painter: MyDrawPath1(color: Colors.red, strokeWidth: 4.0),
                // child: const Center(
                //   child: Text(
                //     'Custom Paint with Border',
                //     style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                //   ),
                // ),
              ),
            ),
            const SizedBox(
              width: 10,
              height: 10,
            ),
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black, // Màu viền
                  width: 1.0, // Độ dày của viền
                ),
              ),
              child: CustomPaint(
                size: const Size(300, 300),
                painter: MyDrawPath2(),
                // child: const Center(
                //   child: Text(
                //     'Custom Paint with Border2',
                //     style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                //   ),
                // ),
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
                size: const Size(300, 300),
                painter: MyDrawPath3(),
                // child: const Center(
                //   child: Text(
                //     'Custom Paint with Border2',
                //     style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                //   ),
                // ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MyDrawPath1 extends CustomPainter {
  final Color color;
  final double strokeWidth;

  MyDrawPath1({this.color = Colors.black, this.strokeWidth = 2.0});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    final path = Path();
    path.lineTo(size.width,
        10); // gốc toạ độ 0,0 tạo góc trên trái - x tăng từ trái sang phải, y tăng từ trên xuống dưới
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close(); // vẽ nét đóng hình

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class MyDrawPath2 extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4.0;

    Path path = Path();
    path.moveTo(0, 0); // Điểm bắt đầu
    path.lineTo(150, 0); // Vẽ một đường thẳng
    path.lineTo(150, 150); // Vẽ một đường thẳng khác
    path.close(); // Đóng đường dẫn để tạo thành một hình tam giác

    canvas.drawPath(path, paint); // Vẽ đường dẫn lên canvas
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

// Đảm bảo tất cả các phép vẽ đều nằm trong size
class MyDrawPath3 extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Đảm bảo tất cả các phép vẽ đều nằm trong size
    // Ví dụ:
    final paint = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    final path = Path();
    path.moveTo(0, 0);
    path.lineTo(size.width, size.height);
    path.moveTo(0, size.height);
    path.lineTo(size.width, 0);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// CustomPaint có child và không child
class MyBox2c extends StatelessWidget {
  const MyBox2c({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CustomPaint Demo Child vs Not Child'),
      ),
      body: Center(
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.amber,
                border: Border.all(
                  color: Colors.black, // Màu viền
                  width: 1.0, // Độ dày của viền
                ),
              ),
              // ClipRect > CustomPaint - cắt phần vưở quá không gian child of CustomPaint(Text)
              child: CustomPaint(
                // size: const Size(300, 300),
                painter: SquarePainter(),
                child: const Center(
                  child: Text(
                    'CustomPaint with child',
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            FittedBox(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.amber,
                  border: Border.all(
                    color: Colors.black, // Màu viền
                    width: 1.0, // Độ dày của viền
                  ),
                ),
                // ClipRect > CustomPaint - cắt phần vưở quá không gian child of CustomPaint(Text)
                child: CustomPaint(
                  // size: const Size(300, 300),
                  painter: SquarePainter(),
                  child: const Center(
                    child: Text(
                      'CustomPaint with child',
                      style:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.amber,
                border: Border.all(
                  color: Colors.black, // Màu viền
                  width: 1.0, // Độ dày của viền
                ),
              ),
              // ClipRect > CustomPaint - cắt phần vưở quá không gian child of CustomPaint(Text)
              child: ClipRect(
                child: CustomPaint(
                  size: const Size(300, 300),
                  painter: MyDrawPath2(),
                  child: const Center(
                    child: Text(
                      'ClipRect > CustomPaint with child',
                      style:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black,
                  width: 1.0,
                ),
              ),
              child: SizedBox(
                width: 300,
                height: 200,
                child: CustomPaint(
                  painter: MyDrawPath2(),
                  child: const Center(
                    child: Text(
                      'SizedBox > CustomPaint with child',
                      style:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black,
                  width: 1.0,
                ),
              ),
              child: SizedBox(
                width: 400,
                height: 200,
                child: CustomPaint(
                  painter: MyDrawPath2(),
                  child: const Center(
                    child: Text(
                      'CustomPaint with child',
                      style:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
