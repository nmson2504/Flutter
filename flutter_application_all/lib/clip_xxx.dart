import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class MyClipXXX extends StatelessWidget {
  const MyClipXXX({super.key});

  @override
  Widget build(BuildContext context) {
    // timeDilation = 10.0;
    var mapC = {
      1: () => const ClipXXX(),
      // 2: () => const RadialExpansionDemo1(),
      // 6: () => const BasicHeroAnimation5(),
    };
    int n = 1; // Giá trị n có thể thay đổi
    // Kiểm tra nếu map chứa key n
    Widget bodyWidget;
    if (mapC.containsKey(n)) {
      bodyWidget = mapC[n]!(); // Gọi hàm trả về Widget
    } else {
      bodyWidget = const Center(child: Text('Không tìm thấy widget'));
    }

    return MaterialApp(
      useInheritedMediaQuery: true,
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
      home: bodyWidget, // Truyền Widget vào body
    );
  }
}

//
int _currentClip = 0;
// List of clips options
final List<String> _clipOptions = ['ClipRect', 'ClipRRect', 'ClipOval', 'ClipPath'];

class ClipXXX extends StatefulWidget {
  const ClipXXX({super.key});

  @override
  State<ClipXXX> createState() => _ClipXXXState();
}

class _ClipXXXState extends State<ClipXXX> {
  Widget _getClipWidget() {
    switch (_clipOptions[_currentClip]) {
      case 'ClipRect':
        return const MyClipRect();
      case 'ClipRRect':
        return const MyClipRRect();
      case 'ClipOval':
        return const MyClipOval();
      case 'ClipPath':
        return const MyClipPath();
      default:
        return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ClipXXX Demo'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              alignment: Alignment.topCenter,
              child: Image.asset(
                'assets/lion.jpg',
                key: ValueKey(_currentClip),
                height: 200,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Center(
              // Widget sẽ thay đổi dựa trên giá trị _currentClip
              child: _getClipWidget(), // Khi _currentClip thay đổi thì _getClipWidget() được gọi lại
            ),
            const SizedBox(height: 20),
            Text('Current Clip: ${_clipOptions[_currentClip]}'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  // Chuyển đổi giữa các hiệu ứng clip
                  _currentClip = (_currentClip + 1) % _clipOptions.length; // giới hạn giá trị từ 0 đến length - 1
                });
              },
              child: const Text('Change Clip Effect'),
            ),
          ],
        ),
      ),
    );
  }
}

// Các widget ClipXXX
// ClipRect: Cắt layout của widget thành hình chữ nhật
class MyClipRect extends StatelessWidget {
  const MyClipRect({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: Align(
        alignment: Alignment.center,
        widthFactor: 0.5,
        heightFactor: 0.5,
        child: Image.asset(
          'assets/lion.jpg',
          // width: 300,
          height: 300,
        ),
      ),
    );
  }
}

// ClipRRect: Cắt chữ nhật với các góc bo tròn.
class MyClipRRect extends StatelessWidget {
  const MyClipRRect({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20.0),
      child: Align(
        alignment: Alignment.center,
        widthFactor: 0.5,
        heightFactor: 0.5,
        child: Image.asset(
          'assets/lion.jpg',
          width: 300,
          height: 300,
        ),
      ),
    );
  }
}

// ClipOval: Cắt thành hình tròn hoặc elip.
class MyClipOval extends StatelessWidget {
  const MyClipOval({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: Align(
        alignment: Alignment.center,
        widthFactor: 0.5,
        heightFactor: 0.5,
        child: Image.asset(
          'assets/lion.jpg',
          width: 300,
          height: 300,
        ),
      ),
    );
  }
}

// ClipPath: Cắt theo một hình dạng tùy chỉnh bằng cách sử dụng CustomClipper.
class MyClipPath extends StatelessWidget {
  const MyClipPath({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: CustomRectangle(),
      child: Align(
        alignment: Alignment.center,
        widthFactor: 0.5,
        heightFactor: 0.5,
        child: Image.asset(
          'assets/lion.jpg',
          width: 300,
          height: 300,
        ),
      ),
    );
  }
}

/* 
CustomClipper là một lớp cơ sở trừu tượng (abstract class) cho phép bạn cắt một vùng nhất định của widget bằng cách tạo hình dạng tùy chỉnh. Lớp con MyCustomClipper mở rộng từ CustomClipper<Path> có nghĩa là bạn sẽ tạo ra một Path để xác định khu vực cắt.
- Path getClip(Size size): Đây là nơi bạn xác định đường viền của vùng cần cắt.
- bool shouldReclip(CustomClipper<Path> oldClipper): Quyết định có cần phải cắt lại vùng đó hay không khi các thuộc tính thay đổi.

- Tham số Size size:
size là kích thước của vùng mà bạn đang cắt. Nó cung cấp chiều rộng (size.width) và chiều cao (size.height) của widget mà bạn muốn áp dụng ClipPath.
Tạo một đối tượng Path:

- var path = Path();: Khởi tạo một đối tượng Path. Đối tượng này chứa các điểm và đoạn thẳng sẽ định nghĩa hình dạng cắt.

- path.lineTo(0, size.height);:
Vẽ một đoạn thẳng từ điểm hiện tại (mặc định là (0,0) - góc trên bên trái) đến điểm (0, size.height), tức là di chuyển xuống dưới tới góc dưới bên trái của vùng cắt.

- path.lineTo(size.width, size.height);:
Vẽ một đoạn thẳng từ điểm (0, size.height) đến điểm (size.width, size.height), tức là di chuyển sang phải đến góc dưới bên phải.

- path.close()
Tự động vẽ một đường từ điểm hiện tại (ở cạnh phải của hình) về điểm bắt đầu (0, 0) để hoàn tất hình dạng. 
 */
class CustomRectangle extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}

// Vẽ ngôi sao
class StarClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    double width = size.width;
    double height = size.height;

    double xCenter = width / 2;
    double yCenter = height / 2;
    double radius = width / 2;

    // Thay đổi góc của các điểm để đỉnh của ngôi sao hướng lên trên
    for (int i = 0; i < 5; i++) {
      double angleOuter = (i * 72 - 90) * pi / 180; // Xoay ngôi sao 90 độ để đỉnh hướng lên trên
      double angleInner = ((i * 72 - 90) + 36) * pi / 180;

      double xOuter = xCenter + radius * cos(angleOuter);
      double yOuter = yCenter + radius * sin(angleOuter);
      double xInner = xCenter + (radius / 2.5) * cos(angleInner);
      double yInner = yCenter + (radius / 2.5) * sin(angleInner);

      if (i == 0) {
        path.moveTo(xOuter, yOuter);
      } else {
        path.lineTo(xOuter, yOuter);
      }
      path.lineTo(xInner, yInner);
    }

    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
