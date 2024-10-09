import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:device_preview/device_preview.dart';
/* 
Thuộc tính timeDilation trong Flutter, được khai báo trong package:flutter/scheduler.dart, là một thuộc tính cho phép bạn điều chỉnh tốc độ khung hình của ứng dụng, bằng cách làm chậm hoặc tăng tốc tất cả các hoạt ảnh trong ứng dụng. Giá trị mặc định của timeDilation là 1.0, có nghĩa là các hoạt ảnh chạy với tốc độ bình thường.
Khi bạn đặt timeDilation = 15.0, như trong đoạn mã, mọi hoạt ảnh trong ứng dụng sẽ chậm hơn 15 lần so với tốc độ bình thường. Ngược lại, nếu giá trị nhỏ hơn 1 (ví dụ timeDilation = 0.5), hoạt ảnh sẽ chạy nhanh gấp đôi.
Điều này hữu ích khi bạn muốn xem các chuyển động hoặc hiệu ứng phức tạp một cách chi tiết hơn, ví dụ như kiểm tra hiệu ứng Hero animation.
timeDilation chỉ nên được sử dụng cho mục đích kiểm tra hoặc gỡ lỗi (debug). Khi phát hành ứng dụng, giá trị này nên được để mặc định là 1.0 để hoạt ảnh chạy mượt mà và tự nhiên.

 */

class MyHero1 extends StatelessWidget {
  const MyHero1({super.key});

  @override
  Widget build(BuildContext context) {
    timeDilation = 10.0;
    var mapC = {
      1: () => const HeroExample(),
      2: () => const HeroExample1(),
      3: () => const HeroAnimation(),
      // 4: () => const BasicHeroAnimation2(),
      // 5: () => const BasicHeroAnimation4(),
      // 6: () => const BasicHeroAnimation5(),
    };
    int n = 3; // Giá trị n có thể thay đổi
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

// Basic Hero Animations
//  Hero used within a ListTile.

class HeroExample extends StatelessWidget {
  const HeroExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Hero Sample')),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const SizedBox(height: 20.0),
          ListTile(
            leading: const Hero(
              tag: 'hero-rectangle',
              child: BoxWidget(size: Size(50.0, 50.0)),
            ),
            onTap: () => _gotoDetailsPage(context),
            title: const Text(
              'Tap on the icon to view hero animation transition.',
            ),
          ),
        ],
      ),
    );
  }

  void _gotoDetailsPage(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute<void>(
      builder: (BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Second Page'),
        ),
        body: Center(
          child: Hero(
            tag: 'hero-rectangle',
            child: BoxWidget(
                size: const Size(200.0, 200.0),
                onTap: () {
                  Navigator.pop(context); // Quay lại trang đầu tiên
                }),
          ),
        ),
      ),
    ));
  }
}

class BoxWidget extends StatelessWidget {
  const BoxWidget({super.key, required this.size, this.onTap});

  final Size size;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap, // Gọi sự kiện onTap nếu có
      child: Container(
        width: size.width,
        height: size.height,
        color: Colors.blue,
      ),
    );
  }
}
// Hero flight animations using default tween and custom rect tween.

class HeroExample1 extends StatelessWidget {
  const HeroExample1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Hero Sample')),
      body: Column(
        children: <Widget>[
          ListTile(
            leading: Hero(
              tag: 'hero-default-tween',
              child: BoxWidget1(
                size: const Size(50.0, 50.0),
                color: Colors.red[700]!.withOpacity(0.5),
              ),
            ),
            title: const Text(
              'This red icon will use a default rect tween during the hero flight.',
            ),
          ),
          const SizedBox(height: 10.0),
          ListTile(
            leading: Hero(
              tag: 'hero-custom-tween',
              // createRectTween - Defines how the destination hero's bounds change as it flies from the starting route to the destination route.
              createRectTween: (Rect? begin, Rect? end) {
                return MaterialRectCenterArcTween(begin: begin, end: end);
              },
              child: BoxWidget1(
                size: const Size(50.0, 50.0),
                color: Colors.blue[700]!.withOpacity(0.5),
              ),
            ),
            title: const Text(
              'This blue icon will use a custom rect tween during the hero flight.',
            ),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () => _gotoDetailsPage(context),
            child: const Text('Tap to trigger hero flight'),
          ),
        ],
      ),
    );
  }

  void _gotoDetailsPage(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute<void>(
      builder: (BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Second Page'),
        ),
        body: Align(
          alignment: Alignment.center,
          child: Stack(
            children: <Widget>[
              Hero(
                tag: 'hero-custom-tween',
                createRectTween: (Rect? begin, Rect? end) {
                  return MaterialRectCenterArcTween(begin: begin, end: end);
                },
                child: BoxWidget1(
                  size: const Size(400.0, 400.0),
                  color: Colors.blue[700]!.withOpacity(0.5),
                ),
              ),
              Hero(
                tag: 'hero-default-tween',
                child: BoxWidget1(
                  size: const Size(400.0, 400.0),
                  color: Colors.red[700]!.withOpacity(0.5),
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}

class BoxWidget1 extends StatelessWidget {
  const BoxWidget1({
    super.key,
    required this.size,
    required this.color,
  });

  final Size size;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.width,
      height: size.height,
      color: color,
    );
  }
}

// Lồng Hero trong custom widget PhotoHero, gán child là Material - InkWell
class PhotoHero extends StatelessWidget {
  const PhotoHero({
    super.key,
    required this.photo,
    this.onTap,
    required this.width,
  });

  final String photo;
  final VoidCallback? onTap;
  final double width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: Hero(
        tag: photo,
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            child: Image.asset(
              photo,
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
    );
  }
}

class HeroAnimation extends StatelessWidget {
  const HeroAnimation({super.key});

  @override
  Widget build(BuildContext context) {
    timeDilation = 5.0; // 1.0 means normal animation speed.

    return Scaffold(
      appBar: AppBar(
        title: const Text('Basic Hero Animation'),
      ),
      body: Center(
        child: PhotoHero(
          photo: 'images/flippers-alpha.png',
          width: 300,
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute<void>(
              builder: (context) {
                return Scaffold(
                  appBar: AppBar(
                    title: const Text('Flippers Page'),
                  ),
                  body: Container(
                    // Set background to blue to emphasize that it's a new route.
                    color: Colors.lightBlueAccent,
                    padding: const EdgeInsets.all(16),
                    alignment: Alignment.topLeft,
                    child: PhotoHero(
                      photo: 'images/flippers-alpha.png',
                      width: 100,
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                );
              },
            ));
          },
        ),
      ),
    );
  }
}
