import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:device_preview/device_preview.dart';
import 'dart:math' as math;

/* 
Radial hero animation
 - A radial transformation animates a circular shape into a square shape.
 - A radial hero animation performs a radial transformation while flying the hero from the source route to the destination route.
 - MaterialRectCenter­Arc­Tween defines the tween animation.
 - Build the destination route using PageRouteBuilder.
 The radial hero animation involves intersecting a round shape with a square shape. This can be hard to see, even when slowing the animation with timeDilation, so you might consider enabling the debugPaintSizeEnabled flag during development.
 */

class MyHero3 extends StatelessWidget {
  const MyHero3({super.key});

  @override
  Widget build(BuildContext context) {
    // timeDilation = 10.0;
    var mapC = {
      1: () => const RadialExpansionDemo(),
      2: () => const RadialExpansionDemo1(),
      3: () => const RadialExpansionDemo3(),
      4: () => const FirstScreen(),
      5: () => const FirstScreen1(),
      6: () => const FirstScreen3(),
      // 5: () => const BasicHeroAnimation4(),
      // 6: () => const BasicHeroAnimation5(),
    };
    int n = 6; // Giá trị n có thể thay đổi
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

// Radial hero animation

// A "radial transformation" as defined here:
// https://m1.material.io/motion/transforming-material.html#transforming-material-radial-transformation

// In this example, the destination route (which completely obscures
// the source route once the page transition has finished),
// displays the Hero image in a Card containing a column of two
// widgets: the image, and some descriptive text.

class Photo extends StatelessWidget {
  const Photo({super.key, required this.photo, this.onTap});

  final String photo;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      // Slightly opaque color appears where the image has transparency.
      color: Theme.of(context).primaryColor.withOpacity(0.25),
      child: InkWell(
        onTap: onTap,
        child: LayoutBuilder(
          builder: (context, size) {
            return Image.asset(
              photo,
              fit: BoxFit.contain,
            );
          },
        ),
      ),
    );
  }
}

class RadialExpansion extends StatelessWidget {
  const RadialExpansion({
    super.key,
    required this.maxRadius,
    this.child,
  }) : clipRectSize = 2.0 * (maxRadius / math.sqrt2);

  final double maxRadius;
  final double clipRectSize;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: Center(
        child: SizedBox(
          width: clipRectSize,
          height: clipRectSize,
          child: ClipRect(
            child: child,
          ),
        ),
      ),
    );
  }
}

// A radial hero animation as described in the Material motion spec.
/* 
Sơ đồ kết nối: 
  build -> _buildHero -> _buildPage
  Trong  _buildHero, _buildPage chứa Hero
  Trong Hero có _createRectTween, RadialExpansion -> Photo
 */
class RadialExpansionDemo extends StatelessWidget {
  const RadialExpansionDemo({super.key});

  static double kMinRadius = 32.0;
  static double kMaxRadius = 128.0;
  static Interval opacityCurve = const Interval(0.0, 0.75, curve: Curves.fastOutSlowIn);

  static RectTween _createRectTween(Rect? begin, Rect? end) {
    return MaterialRectCenterArcTween(begin: begin, end: end);
  }

  static Widget _buildPage(BuildContext context, String imageName, String description) {
    return Container(
      color: Theme.of(context).canvasColor,
      child: Center(
        child: Card(
          elevation: 8,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: kMaxRadius * 2.0,
                height: kMaxRadius * 2.0,
                child: Hero(
                  createRectTween: _createRectTween,
                  tag: imageName,
                  child: RadialExpansion(
                    maxRadius: kMaxRadius,
                    child: Photo(
                      photo: imageName,
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                ),
              ),
              Text(
                description,
                style: const TextStyle(fontWeight: FontWeight.bold),
                textScaler: const TextScaler.linear(3),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHero(
    BuildContext context,
    String imageName,
    String description,
  ) {
    return SizedBox(
      width: kMinRadius * 2.0,
      height: kMinRadius * 2.0,
      child: Hero(
        createRectTween: _createRectTween,
        tag: imageName,
        child: RadialExpansion(
          maxRadius: kMaxRadius,
          child: Photo(
            photo: imageName,
            onTap: () {
              Navigator.of(context).push(
                PageRouteBuilder<void>(
                  pageBuilder: (context, animation, secondaryAnimation) {
                    return AnimatedBuilder(
                      animation: animation,
                      builder: (context, child) {
                        return Opacity(
                          opacity: opacityCurve.transform(animation.value),
                          child: _buildPage(context, imageName, description),
                        );
                      },
                    );
                  },
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    timeDilation = 5.0; // 1.0 is normal animation speed.

    return Scaffold(
      appBar: AppBar(
        title: const Text('Radial Transition Demo'),
      ),
      body: Container(
        padding: const EdgeInsets.all(32),
        alignment: FractionalOffset.bottomLeft,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildHero(context, 'images/chair-alpha.png', 'Chair'),
            _buildHero(context, 'images/binoculars-alpha.png', 'Binoculars'),
            _buildHero(context, 'images/beachball-alpha.png', 'Beach ball'),
          ],
        ),
      ),
    );
  }
}

// A simple radial transition. The destination route is basic, with no Card, Column, or Text.

class Photo1 extends StatelessWidget {
  const Photo1({super.key, required this.photo, this.color, this.onTap});

  final String photo;
  final Color? color;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      // Slightly opaque color appears where the image has transparency.
      // Makes it possible to see the radial transformation's boundary.
      color: Theme.of(context).primaryColor.withOpacity(0.25),
      child: InkWell(
        onTap: onTap,
        child: Image.asset(
          photo,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}

class RadialExpansion1 extends StatelessWidget {
  const RadialExpansion1({
    super.key,
    required this.maxRadius,
    this.child,
  }) : clipRectExtent = 2.0 * (maxRadius / math.sqrt2);

  final double maxRadius;
  final double clipRectExtent;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    // The ClipOval matches the RadialExpansion widget's bounds,
    // which change per the Hero's bounds as the Hero flies to
    // the new route, while the ClipRect's bounds are always fixed.
    return ClipOval(
      child: Center(
        child: SizedBox(
          width: clipRectExtent,
          height: clipRectExtent,
          child: ClipRect(
            child: child,
          ),
        ),
      ),
    );
  }
}

class RadialExpansionDemo1 extends StatelessWidget {
  const RadialExpansionDemo1({super.key});

  static double kMinRadius = 32;
  static double kMaxRadius = 128;
  static Interval opacityCurve = const Interval(0.0, 0.75, curve: Curves.fastOutSlowIn);

  static RectTween _createRectTween(Rect? begin, Rect? end) {
    return MaterialRectCenterArcTween(begin: begin, end: end);
  }

  static Widget _buildPage(BuildContext context, String imageName, String description) {
    return Container(
      color: Theme.of(context).canvasColor,
      alignment: FractionalOffset.center,
      child: SizedBox(
        width: kMaxRadius * 2.0,
        height: kMaxRadius * 2.0,
        child: Hero(
          createRectTween: _createRectTween,
          tag: imageName,
          child: RadialExpansion(
            maxRadius: kMaxRadius,
            child: Photo(
              photo: imageName,
              onTap: () {
                Navigator.of(context).pop();
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHero(BuildContext context, String imageName, String description) {
    return SizedBox(
      width: kMinRadius * 2,
      height: kMinRadius * 2,
      child: Hero(
        createRectTween: _createRectTween,
        tag: imageName,
        child: RadialExpansion1(
          maxRadius: kMaxRadius,
          child: Photo1(
            photo: imageName,
            onTap: () {
              Navigator.of(context).push(
                PageRouteBuilder<void>(
                  pageBuilder: (context, animation, secondaryAnimation) {
                    return AnimatedBuilder(
                      animation: animation,
                      builder: (context, child) {
                        return Opacity(
                          opacity: opacityCurve.transform(animation.value),
                          child: _buildPage(context, imageName, description),
                        );
                      },
                    );
                  },
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    timeDilation = 5.0; // 1.0 is normal animation speed.

    return Scaffold(
      appBar: AppBar(
        title: const Text('Basic Radial Hero Animation Demo2'),
      ),
      body: Container(
        padding: const EdgeInsets.all(32),
        alignment: FractionalOffset.bottomLeft,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildHero(context, 'images/chair-alpha.png', 'Chair'),
            _buildHero(context, 'images/binoculars-alpha.png', 'Binoculars'),
            _buildHero(context, 'images/beachball-alpha.png', 'Beach ball'),
          ],
        ),
      ),
    );
  }
}

// A "radial transition" that slightly differs from the Material
// motion spec:
// - The circular *and* the rectangular clips change as t goes from
//   0.0 to 1.0. (The rectangular clip doesn't change in the
//   Material motion spec.)
// - This requires adding LayoutBuilders and computing t.
// - The key is that the rectangular clip grows more slowly than the
//   circular clip.

class Photo3 extends StatelessWidget {
  const Photo3({super.key, required this.photo, this.onTap});

  final String photo;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      // Slightly opaque color appears where the image has transparency.
      color: Theme.of(context).primaryColor.withOpacity(0.25),
      child: InkWell(
        onTap: onTap,
        child: LayoutBuilder(
          builder: (context, size) {
            return Image.asset(
              photo,
              fit: BoxFit.contain,
            );
          },
        ),
      ),
    );
  }
}

class RadialExpansion3 extends StatelessWidget {
  RadialExpansion3({
    super.key,
    required this.minRadius,
    required this.maxRadius,
    this.child,
  }) : clipTween = Tween<double>(
          begin: 2.0 * minRadius,
          end: 2.0 * (maxRadius / math.sqrt2),
        );

  final double minRadius;
  final double maxRadius;
  final Tween<double> clipTween;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, size) {
        final double t = (size.biggest.width / 2.0 - minRadius) / (maxRadius - minRadius);
        final double rectClipExtent = clipTween.transform(t);
        return ClipOval(
          child: Center(
            child: SizedBox(
              width: rectClipExtent,
              height: rectClipExtent,
              child: ClipRect(
                child: child,
              ),
            ),
          ),
        );
      },
    );
  }
}

class RadialExpansionDemo3 extends StatelessWidget {
  const RadialExpansionDemo3({super.key});

  static const double kMinRadius = 32.0;
  static const double kMaxRadius = 128.0;
  static const opacityCurve = Interval(0.0, 0.75, curve: Curves.fastOutSlowIn);

  RectTween _createRectTween(Rect? begin, Rect? end) {
    return MaterialRectCenterArcTween(begin: begin, end: end);
  }

  Widget _buildPage(BuildContext context, String imageName, String description) {
    return Container(
      color: Theme.of(context).canvasColor,
      child: Center(
        child: Card(
          elevation: 8,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: kMaxRadius * 2.0,
                height: kMaxRadius * 2.0,
                child: Hero(
                  createRectTween: _createRectTween,
                  tag: imageName,
                  child: RadialExpansion3(
                    minRadius: kMinRadius,
                    maxRadius: kMaxRadius,
                    child: Photo3(
                      photo: imageName,
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                ),
              ),
              Text(
                description,
                style: const TextStyle(fontWeight: FontWeight.bold),
                textScaler: const TextScaler.linear(3),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHero(
    BuildContext context,
    String imageName,
    String description,
  ) {
    return SizedBox(
      width: kMinRadius * 2.0,
      height: kMinRadius * 2.0,
      child: Hero(
        createRectTween: _createRectTween,
        tag: imageName,
        child: RadialExpansion3(
          minRadius: kMinRadius,
          maxRadius: kMaxRadius,
          child: Photo3(
            photo: imageName,
            onTap: () {
              Navigator.of(context).push(
                PageRouteBuilder<void>(
                  pageBuilder: (context, animation, secondaryAnimation) {
                    return AnimatedBuilder(
                      animation: animation,
                      builder: (context, child) {
                        return Opacity(
                          opacity: opacityCurve.transform(animation.value),
                          child: _buildPage(context, imageName, description),
                        );
                      },
                    );
                  },
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    timeDilation = 5.0; // 1.0 is normal animation speed.

    return Scaffold(
      appBar: AppBar(
        title: const Text('Radial Transition Demo3'),
      ),
      body: Container(
        padding: const EdgeInsets.all(32),
        alignment: FractionalOffset.bottomLeft,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildHero(context, 'images/chair-alpha.png', 'Chair'),
            _buildHero(context, 'images/binoculars-alpha.png', 'Binoculars'),
            _buildHero(context, 'images/beachball-alpha.png', 'Beach ball'),
          ],
        ),
      ),
    );
  }
}

// Demo from ChatGPT
// Example 1
class FirstScreen extends StatelessWidget {
  const FirstScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Radial Hero Animation')),
      body: Center(
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => const SecondScreen()));
          },
          child: Hero(
            tag: 'radial-hero',
            child: ClipOval(
              child: Container(
                width: 100,
                height: 100,
                color: Colors.blue,
                child: const Icon(Icons.add, color: Colors.white, size: 50),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class SecondScreen extends StatelessWidget {
  const SecondScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          Navigator.of(context).pop();
        },
        child: Center(
          child: Hero(
            tag: 'radial-hero',
            child: ClipOval(
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.width,
                color: Colors.blue,
                child: const Icon(Icons.add, color: Colors.white, size: 150),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// Example 1
class FirstScreen1 extends StatelessWidget {
  const FirstScreen1({super.key});

  @override
  Widget build(BuildContext context) {
    timeDilation = 2.0; // 1.0 is normal animation speed.
    return Scaffold(
      appBar: AppBar(title: const Text('Radial Hero FirstScreen1')),
      body: Center(
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              PageRouteBuilder(
                transitionDuration: const Duration(microseconds: 1000), // phải kết hợp với timeDilation
                pageBuilder: (context, animation, secondaryAnimation) => const SecondScreen1(),
                transitionsBuilder: (context, animation, secondaryAnimation, child) {
                  return FadeTransition(
                    opacity: animation,
                    child: child,
                  );
                },
              ),
            );
          },
          child: Hero(
            tag: 'radial-hero',
            child: ClipOval(
              child: Container(
                width: 100,
                height: 100,
                color: Colors.yellow,
                child: Image.asset(
                  'images/flippers-alpha.png',
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class SecondScreen1 extends StatelessWidget {
  const SecondScreen1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          Navigator.of(context).pop();
        },
        child: Center(
          child: Hero(
            tag: 'radial-hero',
            child: ClipOval(
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.width,
                color: Colors.blue,
                child: Image.asset(
                  'images/flippers-alpha.png',
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

//

class FirstScreen3 extends StatelessWidget {
  const FirstScreen3({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    timeDilation = 2.0; // 1.0 is normal animation speed.

    return Scaffold(
      appBar: AppBar(title: const Text('Radial Hero Animation')),
      body: Center(
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              PageRouteBuilder(
                transitionDuration: const Duration(microseconds: 2000), // phải kết hợp với timeDilation
                pageBuilder: (context, animation, secondaryAnimation) => const SecondScreen3(),
                transitionsBuilder: (context, animation, secondaryAnimation, child) {
                  return FadeTransition(
                    opacity: animation,
                    child: child,
                  );
                },
              ),
            );
          },
          child: const Hero(
            tag: 'radial-hero',
            child: CircleAvatar(
              backgroundColor: Colors.blue,
              radius: 50,
              child: Icon(Icons.flutter_dash, size: 50, color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}

class SecondScreen3 extends StatelessWidget {
  const SecondScreen3({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          Navigator.of(context).pop();
        },
        child: Center(
          child: Hero(
            tag: 'radial-hero',
            child: CircleAvatar(
              backgroundColor: Colors.blue,
              radius: MediaQuery.of(context).size.width / 2,
              child: Icon(Icons.flutter_dash, size: MediaQuery.of(context).size.width / 2, color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
