import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyMediaQuery extends StatelessWidget {
  const MyMediaQuery({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Flutter MediaQuery')),
        body: const MediaQuery04(),
        // backgroundColor: Color.fromARGB(255, 235, 217, 163),
      ),
    );
  }
}

//---------------------------

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
        child: Text(
          isWideScreen ? 'Wide Screen Layout' : 'Narrow Screen Layout',
          style: TextStyle(fontSize: isWideScreen ? 24.0 : 16.0),
        ),
      ),
    );
  }
}

//
class MediaQuery02 extends StatelessWidget {
  const MediaQuery02({super.key});

  @override
  Widget build(BuildContext context) {
    // Accessing MediaQuery to get text scale factor
    final textScaleFactor = MediaQuery.of(context).textScaleFactor;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Text Scaling Demo'),
      ),
      body: Center(
        child: Text(
          'Hello, Text Scaling! - $textScaleFactor',
          style: TextStyle(
            fontSize: 20 * MediaQuery.of(context).devicePixelRatio,
          ),
        ),
      ),
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
      body: Container(
        color: Colors.yellow,
        height: height / 2, //half of the height size
        width: width / 2, //half of the width size
      ),
    );
  }
}

//
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
                width: width / 4,
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

//

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
