import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyMediaQuery extends StatelessWidget {
  const MyMediaQuery({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Flutter MediaQuery')),
        body: const SafeAreaWithColorsDemo(),
        // backgroundColor: Color.fromARGB(255, 235, 217, 163),
      ),
    );
  }
}

//---------------------------
// Xử lý qua mediaQuery.size.width
class MediaQuery01 extends StatelessWidget {
  const MediaQuery01({super.key});

  @override
  Widget build(BuildContext context) {
    // Accessing MediaQuery to get screen properties
    final mediaQuery = MediaQuery.of(context);

    // Adjusting the widget based on screen width
    final screenWidth = mediaQuery.size.width;
    final isWideScreen = screenWidth > 600;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Responsive App'),
      ),
      body: Center(
          child: Column(
        children: [
          Text('screenWidth - ${screenWidth.toStringAsFixed(2)}'),
          Text(
            isWideScreen ? 'Wide Screen Layout' : 'Narrow Screen Layout',
            style: TextStyle(fontSize: isWideScreen ? 24.0 : 20.0),
          )
        ],
      )),
    );
  }
}

// MediaQuery to get text scale factor & devicePixelRatio
class MediaQuery02 extends StatelessWidget {
  const MediaQuery02({super.key});

  @override
  Widget build(BuildContext context) {
    // Accessing MediaQuery to get text scale factor
    //  cho biết tỷ lệ phóng to/thu nhỏ của văn bản dựa trên cài đặt của hệ điều hành.
    //  devicePixelRatio on Nexus 6 has a device pixel ratio = 3.5.
    final textScaleFactor = MediaQuery.of(context).textScaler;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Text Scaling Demo'),
      ),
      body: Center(
          child: Column(children: [
        Text(
          'Hello, Text Scaling! - $textScaleFactor',
          style: TextStyle(
            // fontSize: 10 * MediaQuery.of(context).devicePixelRatio,
            fontSize: 10 * textScaleFactor.scale(3.5),
          ),
        ),
        Text(
          'Hello, Text Scaling! - $textScaleFactor',
          style: TextStyle(
            fontSize: 10 * MediaQuery.of(context).devicePixelRatio,
            // fontSize: 10 * textScaleFactor.scale(3),
          ),
        ),
      ])),
    );
  }
}

//
class MediaQuery03 extends StatelessWidget {
  const MediaQuery03({super.key});

  @override
  Widget build(BuildContext context) {
    // getting the size of the window
    final size = MediaQuery.of(context).size;
    final height = size.height;
    final width = size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Geeks For Geeks"),
        backgroundColor: Colors.green,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Screen Width: $width',
                style: const TextStyle(fontSize: 20),
              ),
              const SizedBox(height: 20),
              Text(
                'Screen Height: $height',
                style: const TextStyle(fontSize: 20),
              ),
              const SizedBox(height: 20),
              Container(
                color: Colors.yellow,
                height: height / 2, // half of the height size
                width: width / 2, // half of the width size
                child: const Center(
                  child: Text(
                    'Half of the Screen',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// MediaQuery.of(context).orientation
class MediaQuery04 extends StatelessWidget {
  const MediaQuery04({super.key});

  @override
  Widget build(BuildContext context) {
    // getting the orientation of the app
    var orientation = MediaQuery.of(context).orientation;
    Orientation currentOrientation = MediaQuery.of(context).orientation;
    debugPrint('Orientation - $currentOrientation');
    //size of the window
    final size = MediaQuery.of(context).size;
    final height = size.height;
    final width = size.width;

    return Scaffold(
        appBar: AppBar(
          title: const Text("Geeks For MediaQuery04"),
          backgroundColor: Colors.green,
        ),

        // checking the orientation
        body: orientation == Orientation.portrait
            ? Container(
                color: Colors.blue,
                height: height / 2,
                width: width / 2,
                child: Text("$currentOrientation"),
              )
            : Container(
                height: height / 4,
                width: width / 2,
                color: Colors.red,
                child: Text("$currentOrientation"),
              ));
  }
}

//

// OrientationBuilder

class MyOrientationDemo extends StatelessWidget {
  const MyOrientationDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('OrientationBuilder Example'),
      ),
      body: Center(
        child: OrientationBuilder(
          builder: (context, orientation) {
            // Build UI elements based on device orientation
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(
                  // Display different icons based on orientation
                  orientation == Orientation.portrait
                      ? Icons.horizontal_rule
                      : Icons.phone_iphone,
                  size: 100.0,
                ),
                const SizedBox(height: 20.0),
                Text(
                  // Display different text based on orientation
                  'Device is in ${orientation == Orientation.portrait ? 'Portrait' : 'Landscape'} mode',
                  style: const TextStyle(fontSize: 20.0),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

// thay OrientationBuilder bằng MediaQuery
class MyOrientationDemo2 extends StatelessWidget {
  const MyOrientationDemo2({super.key});

  @override
  Widget build(BuildContext context) {
    // Lấy thông tin hướng màn hình từ MediaQuery
    final orientation = MediaQuery.of(context).orientation;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Orientation with MediaQuery'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              // Hiển thị biểu tượng khác nhau dựa trên hướng màn hình
              orientation == Orientation.portrait
                  ? Icons.horizontal_rule
                  : Icons.phone_iphone,
              size: 100.0,
            ),
            const SizedBox(height: 20.0),
            Text(
              // Hiển thị văn bản khác nhau dựa trên hướng màn hình
              'Device is in ${orientation == Orientation.portrait ? 'Portrait' : 'Landscape'} mode',
              style: const TextStyle(fontSize: 20.0),
            ),
          ],
        ),
      ),
    );
  }
}

// MediaQuery.of(context).padding;

class SafeAreaWithColorsDemo extends StatelessWidget {
  const SafeAreaWithColorsDemo({super.key});

  @override
  Widget build(BuildContext context) {
    // Lấy thông tin padding từ MediaQuery
    final padding = MediaQuery.of(context).padding;
    return Scaffold(
      appBar: AppBar(
        title: const Text('SafeArea with Background Colors'),
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Container(
              color: Colors.red,
              height: padding.top > 50
                  ? padding.top
                  : 50, // Đảm bảo chiều cao đủ lớn
              child: Center(
                  child: Text('Top Padding: ${padding.top}',
                      style: const TextStyle(color: Colors.white))),
            ),
            Container(
              color: Colors.green,
              height: 100, // Chiều cao cố định cho vùng nội dung
              child: const Center(
                  child: Text('Main Content Area',
                      style: TextStyle(color: Colors.white))),
            ),
            Container(
              color: Colors.blue,
              height: 100, // Chiều cao cố định cho vùng nội dung
              child: const Center(
                  child: Text('Another Content Area',
                      style: TextStyle(color: Colors.white))),
            ),
            Container(
              color: Colors.orange,
              height: padding.bottom > 50
                  ? padding.bottom
                  : 50, // Đảm bảo chiều cao đủ lớn
              child: Center(
                  child: Text('Bottom Padding: ${padding.bottom}',
                      style: const TextStyle(color: Colors.white))),
            ),
          ],
        ),
      ),
    );
  }
}

//
